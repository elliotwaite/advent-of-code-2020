include prelude
import math, sequtils


proc part1(earliest: int, cycleTimes: seq[int]): int =
  let (wait, cycleTime) = cycleTimes.mapIt(
    (it - ((earliest - 1) mod it) - 1, it)
  ).min
  return wait * cycleTime


proc part2(cycleTimes: seq[int], offsets: seq[int]): int =
  var jump, nextJump = cycleTimes[0]
  var deltas = offsets

  var numSynced = 1
  while numSynced < deltas.len:
    result += jump
    for i in 1 .. deltas.high:
      if deltas[i] != 0:
        deltas[i] = (deltas[i] + jump) mod cycleTimes[i]
        if deltas[i] == 0:
          inc numSynced
          nextJump = lcm(nextJump, cycleTimes[i])

    jump = nextJump


proc main =
  let lines = toSeq("inputs/day13.txt".lines)
  let earliest = lines[0].parseInt

  var cycleTimes, offsets: seq[int]
  var offset = 0
  for cycleTime in lines[1].split(','):
    if cycleTime != "x":
      cycleTimes.add cycleTime.parseInt
      offsets.add offset
    inc offset

  let answer1 = part1(earliest, cycleTimes)
  echo answer1
  doAssert answer1 == 3865

  let answer2 = part2(cycleTimes, offsets)
  echo answer2
  doAssert answer2 == 415579909629976


main()