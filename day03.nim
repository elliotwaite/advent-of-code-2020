include prelude

let inputPath = joinPath(os.getAppDir(), "input.txt")


func numTrees(grid: seq[string], right, down: int): int =
  let width = grid[0].len
  var x = 0
  for y in countup(down, grid.high, down):
    x = (x + right) mod width
    if grid[y][x] == '#':
      inc result


proc part1(grid: seq[string]): int =
  return numTrees(grid, 3, 1)


proc part2(grid: seq[string]): int =
  return (
    numTrees(grid, 1, 1) *
    numTrees(grid, 3, 1) *
    numTrees(grid, 5, 1) *
    numTrees(grid, 7, 1) *
    numTrees(grid, 1, 2)
  )


proc main =
  let grid = "inputs/day03.txt".lines.toSeq

  let answer1 = part1(grid)
  echo answer1
  doAssert answer1 == 272

  let answer2 = part2(grid)
  echo answer2
  doAssert answer2 == 3898725600


main()