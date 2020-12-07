include prelude
import algorithm, sequtils

let inputPath = joinPath(os.getAppDir(), "input.txt")


func toSeatNumber(boardingPass: string): int =
  boardingPass.replace('F', '0').replace('B', '1').replace('L', '0').replace('R', '1').parseBinInt


proc part1: int =
  return toSeq(inputPath.lines).map(toSeatNumber).max


proc part2: int =
  let seatNumbers = toSeq(inputPath.lines).map(toSeatNumber).sorted
  for i, seatNumber in seatNumbers:
    if seatNumbers[i + 1] != seatNumber + 1:
      return seatNumber + 1


when isMainModule:
  let answer1 = part1()
  doAssert answer1 == 892
  echo answer1

  let answer2 = part2()
  doAssert answer2 == 625
  echo answer2