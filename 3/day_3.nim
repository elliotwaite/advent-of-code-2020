include prelude
import sequtils

let inputPath = joinPath(os.getAppDir(), "input.txt")


func numTrees(lines: seq[string], right, down: int): int =
  let width = lines[0].len
  var x = 0

  for y in countup(down, lines.high, down):
    x = (x + right) mod width
    if lines[y][x] == '#':
      inc result


proc part1: int =
  let lines = toSeq(inputPath.lines)
  return numTrees(lines, 3, 1)


proc part2: int =
  let
    lines = toSeq(inputPath.lines)
    a = numTrees(lines, 1, 1)
    b = numTrees(lines, 3, 1)
    c = numTrees(lines, 5, 1)
    d = numTrees(lines, 7, 1)
    e = numTrees(lines, 1, 2)

  return a * b * c * d * e


when isMainModule:
  let answer1 = part1()
  doAssert answer1 == 272
  echo answer1

  let answer2 = part2()
  doAssert answer2 == 3898725600
  echo answer2