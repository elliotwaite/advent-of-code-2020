include prelude
import sugar

const cypherDist = 25


proc part1(nums: seq[int]): int =
  for i in cypherDist .. nums.high:
    block breakWhenValid:
      for j in i - cypherDist ..< i:
        for k in j + 1 ..< i:
          if nums[i] == nums[j] + nums[k]:
            break breakWhenValid

      return nums[i]


proc part2(nums: seq[int], target: int): int =
  for i in 0 .. nums.high:
    var sum = nums[i]
    for j in i + 1 .. nums.high:
      sum += nums[j]
      if sum == target:
        return nums[i] + nums[j]


proc main =
  let nums = collect:
    for line in "inputs/day09.txt".lines:
      line.parseInt

  let answer1 = part1(nums)
  echo answer1
  doAssert answer1 == 36845998

  let answer2 = part2(nums, answer1)
  echo answer2
  doAssert answer2 == 4830226


main()