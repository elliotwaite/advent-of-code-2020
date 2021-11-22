include prelude
import deques

type
  Op = enum
    opSum, opMul

proc eval1(line: string): int =
  # Only parenthesis precedence.
  var vals = [0].toDeque
  var ops = [opSum].toDeque
  for c in line:
    if c == ' ':
      discard
    elif c == '(':
      vals.addLast 0
      ops.addLast opSum
    elif c == ')':
      let val = vals.popLast
      discard ops.popLast
      if ops[^1] == opSum:
        vals[^1] += val
      else:
        vals[^1] *= val
    elif c == '+':
      ops[^1] = opSum
    elif c == '*':
      ops[^1] = opMul
    else:
      let val = ord(c) - ord('0')
      if ops[^1] == opSum:
        vals[^1] += val
      else:
        vals[^1] *= val

  return vals[0]


proc eval2(line: string): int =
  # Parenthesis precedence and addition before multiplication.
  var muls = [1].toDeque
  var adds = [0].toDeque
  for c in line:
    if c == ' ':
      discard
    elif c == '(':
      muls.addLast 1
      adds.addLast 0
    elif c == ')':
      let val = muls.popLast * adds.popLast
      adds[^1] += val
    elif c == '+':
      discard
    elif c == '*':
      muls[^1] *= adds[^1]
      adds[^1] = 0
    else:
      adds[^1] += ord(c) - ord('0')

  return muls[0] * adds[0]


proc part1(lines: seq[string]): int =
  for line in lines:
    result += line.eval1


proc part2(lines: seq[string]): int =
  for line in lines:
    result += line.eval2


proc main =
  let lines = "inputs/day18.txt".lines.toSeq

  let answer1 = part1(lines)
  echo answer1
  doAssert answer1 == 23507031841020

  let answer2 = part2(lines)
  echo answer2
  doAssert answer2 == 218621700997826


main()