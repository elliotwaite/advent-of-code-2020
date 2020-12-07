include prelude
include sequtils

let inputPath = joinPath(os.getAppDir(), "input.txt")


proc part1: int =
  for group in inputPath.readFile.split("\p\p"):
    var groupSet: set[char]
    for line in group.splitLines:
      for char in line:
        groupSet.incl char

    result += groupSet.len


proc part2: int =
  for group in inputPath.readFile.split("\p\p"):
    var groupSet = {'a' .. 'z'}
    for line in group.splitLines:
      var lineSet: set[char]
      for char in line:
        lineSet.incl char

      groupSet = groupSet * lineSet

    result += groupSet.len


when isMainModule:
  let answer1 = part1()
  doAssert answer1 == 6782
  echo answer1

  let answer2 = part2()
  doAssert answer2 == 3596
  echo answer2