include prelude
import sugar

type
  Action = enum
    N, S, E, W, L, R, F

  Instructions = seq[tuple[action: Action, val: int]]
  Point = tuple[x: int, y: int]


proc rotateLeft(p: var Point, degrees: int) =
  case degrees:
    of 90: p = (-p.y, p.x)
    of 180: p = (-p.x, -p.y)
    else: p = (p.y, -p.x)


proc part1(instructions: Instructions): int =
  var pos, facing: Point
  facing = (1, 0)
  for inst in instructions:
    case inst.action:
      of N: pos.y += inst.val
      of S: pos.y -= inst.val
      of E: pos.x += inst.val
      of W: pos.x -= inst.val
      of L: rotateLeft(facing, inst.val)
      of R: rotateLeft(facing, 360 - inst.val)
      of F:
        pos.x += facing.x * inst.val
        pos.y += facing.y * inst.val

  return abs(pos.x) + abs(pos.y)


proc part2(instructions: Instructions): int =
  var pos, way: Point
  way = (10, 1)
  for inst in instructions:
    case inst.action:
      of N: way.y += inst.val
      of S: way.y -= inst.val
      of E: way.x += inst.val
      of W: way.x -= inst.val
      of L: rotateLeft(way, inst.val)
      of R: rotateLeft(way, 360 - inst.val)
      of F:
        pos.x += way.x * inst.val
        pos.y += way.y * inst.val

  return abs(pos.x) + abs(pos.y)


proc main =
  let instructions = collect(newSeq):
    for line in "inputs/day12.txt".lines:
      (parseEnum[Action](line[0 .. 0]), parseInt(line[1 .. ^1]))

  let answer1 = part1(instructions)
  echo answer1
  doAssert answer1 == 998

  let answer2 = part2(instructions)
  echo answer2
  doAssert answer2 == 71586


main()