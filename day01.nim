include prelude
import sugar


proc part1(nums: seq[int]): int =
  for i, a in nums:
    for b in nums[i + 1 .. ^1]:
      if a + b == 2020:
        return a * b


proc part2(nums: seq[int]): int =
  for i, a in nums:
    for j, b in nums[i + 1 .. ^1]:
      for c in nums[j + 1 .. ^1]:
        if a + b + c == 2020:
          return a * b * c


proc main =
  var nums = collect:
    for line in "inputs/day01.txt".lines:
      line.parseInt

  let answer1 = part1(nums)
  echo answer1
  doAssert answer1 == 1007331

  let answer2 = part2(nums)
  echo answer2
  doAssert answer2 == 48914340


main()