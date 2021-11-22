include prelude
import algorithm, sugar


proc part1(nums: seq[int]): int =
  var d1, d3 = 0
  for i in 1 .. nums.high:
    case nums[i] - nums[i - 1]:
      of 1: inc d1
      of 3: inc d3
      else: discard

  return d1 * d3


proc part2(nums: seq[int]): int =
  var paths = [0].toCountTable
  for num in nums[1 .. ^1]:
    paths[num] = paths[num - 1] + paths[num - 2] + paths[num - 3]

  return paths[nums[^1]]


proc main =
  var nums = collect:
    for line in "inputs/day10.txt".lines:
      line.parseInt

  nums.sort
  nums = 0 & nums & nums[^1] + 3

  let answer1 = part1(nums)
  echo answer1
  doAssert answer1 == 2475

  let answer2 = part2(nums)
  echo answer2
  doAssert answer2 == 442136281481216


main()