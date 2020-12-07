include prelude
import strscans

let inputPath = joinPath(os.getAppDir(), "input.txt")


proc part1: int =
  var
    min, max: int
    char, password: string

  for line in inputPath.lines:
    if line.scanf("$i-$i $w: $w", min, max, char, password):
      if password.count(char[0]) in min .. max:
        inc result


proc part2: int =
  var
    pos0, pos1: int
    char, password: string

  for line in inputPath.lines:
    if line.scanf("$i-$i $w: $w", pos0, pos1, char, password):
      if password[pos0 - 1] == char[0] xor password[pos1 - 1] == char[0]:
        inc result


when isMainModule:
  let answer1 = part1()
  doAssert answer1 == 666
  echo answer1

  let answer2 = part2()
  doAssert answer2 == 670
  echo answer2