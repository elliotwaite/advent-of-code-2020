include prelude
import math


proc part1(earliest: int, cycleTimes: seq[int]): int =
  let (wait, cycleTime) = cycleTimes.mapIt(
    (it - ((earliest - 1) mod it) - 1, it)
  ).min
  return wait * cycleTime


proc part2(cycleTimes: seq[int], offsets: seq[int]): int =
  var jump = cycleTimes[0]

  for (cycleTime, offset) in zip(cycleTimes[1 .. ^1], offsets[1 .. ^1]):
    let targetMod = floorMod(cycleTime - offset, cycleTime)
    while true:
      if result mod cycleTime == targetMod:
        jump = lcm(jump, cycleTime)
        break
      result += jump


proc main =
  let lines = "inputs/day13.txt".lines.toSeq
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