include prelude
import sugar

type
  Op = enum
    acc, jmp, nop

  Instruction = tuple[op: Op, val: int]
  Instructions = seq[Instruction]
  State = tuple[line: int16, accum: int]


proc update(state: var State, inst: Instruction) =
  case inst.op:
    of acc:
      state.accum.inc inst.val
      state.line.inc
    of jmp:
      state.line.inc inst.val
    else:
      state.line.inc


proc part1(insts: Instructions): int =
  var
    state: State
    visited: set[int16]

  while state.line notin visited:
    visited.incl state.line
    state.update insts[state.line]

  return state.accum


proc part2(insts: Instructions): int =
  var
    state: State
    visited: set[int16]
    doLoop: set[int16]
    dontLoop: set[int16]

  let validLines = int16(insts.low) .. int16(insts.high)

  # For all instructions, figure out which lead to a loop and which don't.
  for line in 0'i16 .. insts.high.int16:
    if line notin doLoop + dontLoop:
      visited = {}
      state.line = line

      while (
        state.line notin visited + doLoop + dontLoop and
        state.line in 0 .. insts.high
      ):
        visited.incl state.line
        state.update insts[state.line]

      if state.line in visited + doLoop:
        doLoop.incl visited
      else:
        dontLoop.incl visited

  var foundBug = false
  state.reset
  visited = {}

  while state.line notin visited and state.line != insts.len:
    visited.incl state.line

    if not foundBug:
      if insts[state.line].op == jmp and state.line + 1 in dontLoop:
        state.line.inc
        foundBug = true
        continue

      if insts[state.line].op == nop and state.line + insts[state.line].val.int16 in dontLoop:
        state.line.inc insts[state.line].val
        foundBug = true
        continue

    state.update(insts[state.line])

  return state.accum


proc main =
  let insts = collect(newSeq):
    for line in "inputs/day08.txt".lines:
      Instruction((parseEnum[Op](line[0 .. 2]), parseInt(line[4 .. ^1])))

  let answer1 = part1(insts)
  echo answer1
  doAssert answer1 == 1766

  let answer2 = part2(insts)
  echo answer2
  doAssert answer2 == 1639


main()