include prelude
import math, sequtils


proc part1(earliest: int, ids: seq[int]): int =
  let (wait, id) = ids.mapIt((it - 1 - ((earliest - 1) mod it), it)).min
  return wait * id


proc part2(ids: seq[int], offsets: seq[int]): int =
  var jump, nextJump = ids[0]
  var deltas = offsets

  var numSynced = 1
  while numSynced < deltas.len:
    result += jump
    for i in 1 .. deltas.high:
      if deltas[i] != 0:
        deltas[i] = (deltas[i] + jump) mod ids[i]
        if deltas[i] == 0:
          inc numSynced
          nextJump = lcm(nextJump, ids[i])

    jump = nextJump


proc main =
  let lines = toSeq("inputs/day13.txt".lines)
  let earliest = lines[0].parseInt

  var ids, offsets: seq[int]
  var offset = 0
  for id in lines[1].split(','):
    if id != "x":
      ids.add id.parseInt
      offsets.add offset
    inc offset

  let answer1 = part1(earliest, ids)
  echo answer1
  doAssert answer1 == 3865

  let answer2 = part2(ids, offsets)
  echo answer2
  doAssert answer2 == 415579909629976


main()