include prelude
import algorithm, sugar


proc part1(seatNumbers: seq[int]): int =
  return seatNumbers[^1]


proc part2(seatNumbers: seq[int]): int =
  for i, seatNumber in seatNumbers:
    if seatNumbers[i + 1] != seatNumber + 1:
      return seatNumber + 1


proc main =
  var seatNumbers = collect:
    for line in "inputs/day05.txt".lines:
      line.replace('F', '0').replace('B', '1').replace('L', '0').replace('R', '1').parseBinInt

  seatNumbers.sort

  let answer1 = part1(seatNumbers)
  echo answer1
  doAssert answer1 == 892

  let answer2 = part2(seatNumbers)
  echo answer2
  doAssert answer2 == 625


main()