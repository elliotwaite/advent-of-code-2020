include prelude
import bitops, sequtils, strscans


proc floatingOrMasks(mask: string): seq[int] =
  var numXsRemaining = mask.count('X')
  var shiftAmounts: seq[(int, int)]
  for i, c in mask:
    if c == 'X':
      dec numXsRemaining
      shiftAmounts.add (numXsRemaining, mask.high - i)

  let baseOrMask = mask.replace('X', '0').parseBinInt
  var orMask: int
  for compactMask in 0 ..< 1 shl shiftAmounts.len:
    orMask = baseOrMask
    for (compactMaskShiftAmount, addressShiftAmount) in shiftAmounts:
      orMask = orMask or (
        (compactMask and (1 shl compactMaskShiftAmount)) shl
        (addressShiftAmount - compactMaskShiftAmount)
      )
    result.add orMask


proc part1(lines: seq[string]): int =
  var mask: string
  var andMask, orMask, address, val: int
  var mem: Table[int, int]
  for line in lines:
    if line.scanf("mask = $+", mask):
      andMask = mask.replace('X', '1').parseBinInt
      orMask = mask.replace('X', '0').parseBinInt

    elif line.scanf("mem[$i] = $i", address, val):
      mem[address] = val and andMask or orMask

  for v in mem.values:
    result += v


proc part2(lines: seq[string]): int =
  var mask: string
  var andMask, address, val: int
  var orMasks: seq[int]
  var mem: Table[int, int]
  for line in lines:
    if line.scanf("mask = $+", mask):
      andMask = not mask.replace('X', '1').parseBinInt
      orMasks = floatingOrMasks(mask)

    elif line.scanf("mem[$i] = $i", address, val):
      address = address and andMask
      for orMask in orMasks:
        mem[address or orMask] = val

  for v in mem.values:
    result += v


proc main =
  let lines = toSeq("inputs/day14.txt".lines)

  let answer1 = part1(lines)
  echo answer1
  doAssert answer1 == 7997531787333

  let answer2 = part2(lines)
  echo answer2
  doAssert answer2 == 3564822193820


main()