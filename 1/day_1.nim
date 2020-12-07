include prelude
import sequtils

let inputPath = joinPath(os.getAppDir(), "input.txt")


proc part1: int =
  var nums = toSeq(inputPath.lines).map(parseInt)

  for i, a in nums:
    for b in nums[i + 1 .. ^1]:
      if a + b == 2020:
        return a * b


proc part2: int =
  var nums = toSeq(inputPath.lines).map(parseInt)

  for i, a in nums:
    for j, b in nums[i + 1 .. ^1]:
      for c in nums[j + 1 .. ^1]:
        if a + b + c == 2020:
          return a * b * c


when isMainModule:
  let answer1 = part1()
  doAssert answer1 == 1007331
  echo answer1

  let answer2 = part2()
  doAssert answer2 == 48914340
  echo answer2