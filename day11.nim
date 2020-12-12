include prelude
import sequtils

type
  Grid = seq[string]
  Neighbors = seq[seq[int]]
  Seats = seq[bool]


proc getNeighbors(grid: Grid, part: int): Neighbors =
  let iSlice = 0 .. grid.high
  let jSlice = 0 .. grid[0].high

  var offsets = newSeqWith(grid.len, newSeq[int](grid[0].len))
  var offset = 0
  for i in iSlice:
    for j in jSlice:
      offsets[i][j] = offset
      if grid[i][j] != '.':
        inc offset

  for i in iSlice:
    for j in jSlice:
      if grid[i][j] != '.':
        result.add @[]
        for di in -1 .. 1:
          for dj in -1 .. 1:
            if not (di == 0 and dj == 0):
              var ci = i + di
              var cj = j + dj
              while ci in iSlice and cj in jSlice:
                if grid[ci][cj] == 'L':
                  result[^1].add offsets[ci][cj]
                  break

                if part == 1:
                  break

                ci += di
                cj += dj


proc updateSeats(seats1: var Seats, seats2: var Seats,
                 neighbors: Neighbors, maxNeighbors: int): bool =
  for i, offsets in neighbors:
    var count = 0
    for offset in offsets:
      if seats1[offset]:
        inc count

    seats2[i] = count == 0 or count <= maxNeighbors and seats1[i]
    if seats2[i] != seats1[i]:
      result = true


proc getStableNum(neighbors: Neighbors, maxNeighbors: int): int =
  var seats1, seats2 = newSeq[bool](neighbors.len)
  while updateSeats(seats1, seats2, neighbors, maxNeighbors):
    swap(seats1, seats2)

  for seat in seats1:
    if seat:
      inc result


proc part1(grid: Grid): int =
  let neighbors = getNeighbors(grid, 1)
  return getStableNum(neighbors, 3)


proc part2(grid: Grid): int =
  let neighbors = getNeighbors(grid, 2)
  return getStableNum(neighbors, 4)


proc main =
  let grid = toSeq("inputs/day11.txt".lines)

  let answer1 = part1(grid)
  echo answer1
  doAssert answer1 == 2470

  let answer2 = part2(grid)
  echo answer2
  doAssert answer2 == 2259


main()