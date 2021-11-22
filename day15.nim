include prelude
import sugar


proc solve(inputNums: seq[int], numTurns: int): int =
  var mem: Table[int, int]
  for turn, num in inputNums[0 .. ^2]:
    mem[num] = turn

  result = inputNums[^1]
  for turn in inputNums.high ..< numTurns - 1:
    let nextNum = if result in mem: turn - mem[result] else: 0
    mem[result] = turn
    result = nextNum


proc main =
  let inputNums = collect:
    for num in "inputs/day15.txt".readFile.split(','):
      num.parseInt

  let answer1 = solve(inputNums, numTurns = 2020)
  echo answer1
  doAssert answer1 == 1522

  let answer2 = solve(inputNums, numTurns = 30_000_000)
  echo answer2
  doAssert answer2 == 18234


main()