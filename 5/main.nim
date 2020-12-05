include prelude
import algorithm
import sequtils
import sugar


proc seatNumber(code: string): int =
  let
    row = code[.. 6].replace('F', '0').replace('B', '1').parseBinInt
    col = code[7 .. ^1].replace('L', '0').replace('R', '1').parseBinInt
  return row * 8 + col


proc main_1 =
  let
    input = readFile(joinPath(os.getAppDir(), "input.txt"))
    lines = input.splitLines
    seatNumbers = lines.map(x => seatNumber(x))

  echo max(seatNumbers)


proc main_2 =
  let
    input = readFile(joinPath(os.getAppDir(), "input.txt"))
    lines = input.splitLines
    seatNumbers = lines.map(x => seatNumber(x)).sorted

  var curSeat = seatNumbers[0]
  for seatNumber in seatNumbers:
    if curSeat < seatNumber:
      echo curSeat
      return

    curSeat += 1


main_1()
main_2()