include prelude
import sequtils, sugar


proc main_1 =
  let
    input = readFile(joinPath(os.getAppDir(), "input.txt"))
    nums = splitLines(input).map(x => parseInt(x))

  for i in 0 .. nums.high:
    for j in i + 1 .. nums.high:
      if nums[i] + nums[j] == 2020:
        echo nums[i] * nums[j]
        return


proc main_2 =
  let
    input = readFile(joinPath(os.getAppDir(), "input.txt"))
    nums = splitLines(input).map(x => parseInt(x))

  for i in 0 .. nums.high:
    for j in i + 1 .. nums.high:
      for k in j + 1 .. nums.high:
        if nums[i] + nums[j] + nums[k] == 2020:
          echo nums[i] * nums[j] * nums[k]
          return


main_1()
main_2()