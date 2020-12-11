include prelude
import algorithm, math, sequtils, strutils, sugar, tables


proc nextState(grid: seq[string], part: int): (seq[string], bool) =
  let iSlice = 0 .. grid.high
  let jSlice = 0 .. grid[0].high
  let maxNeighbors = 3 + part

  result[0] = grid
  for i in iSlice:
    for j in jSlice:
      if grid[i][j] != '.':
        var count = 0
        for a in -1 .. 1:
          for b in -1 .. 1:
            if not (a == 0 and b == 0):
              var p = i + a
              var q = j + b
              while p in iSlice and q in jSlice:
                if grid[p][q] == '#':
                  inc count
                  break

                if part == 1 or grid[p][q] == 'L':
                  break

                p = p + a
                q = q + b

        if grid[i][j] == 'L':
          if count == 0:
            result[0][i][j] = '#'
            result[1] = true

        elif grid[i][j] == '#':
          if count >= maxNeighbors:
            result[0][i][j] = 'L'
            result[1] = true


proc countOccupied(grid: seq[string]): int =
  for row in grid:
    for seat in row:
      if seat == '#':
        inc result


proc part1(grid: seq[string]): int =
  var grid = grid
  var didChange = true
  while didChange:
    (grid, didChange) = nextState(grid, 1)

  return countOccupied(grid)


proc part2(grid: seq[string]): int =
  var grid = grid
  var didChange = true
  while didChange:
    (grid, didChange) = nextState(grid, 2)

  return countOccupied(grid)


proc main =
  let grid = toSeq("inputs/day11.txt".lines)

  let answer1 = part1(grid)
  echo answer1
  doAssert answer1 == 2470

  let answer2 = part2(grid)
  echo answer2
  doAssert answer2 == 2259


main()