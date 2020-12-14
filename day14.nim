include prelude
import bitops, sequtils, strscans


proc part1(lines: seq[string]): int =
  var mask: string
  var maskAnd, maskOr, address, val: int
  var mem: Table[int, int]
  for line in lines:
    if line.scanf("mask = $+", mask):
      maskAnd = mask.replace('X', '1').parseBinInt
      maskOr = mask.replace('X', '0').parseBinInt

    elif line.scanf("mem[$i] = $i", address, val):
      mem[address] = (val and maskAnd) or maskOr

  for v in mem.values:
    result += v


proc part2(lines: seq[string]): int =
  var mask: string
  var maskAnd, maskOr, address, val, curAddress: int
  var shiftAmounts: seq[(int, int)]
  var mem: Table[int, int]
  for line in lines:
    if line.scanf("mask = $+", mask):
      maskAnd = not mask.replace('X', '1').parseBinInt
      maskOr = mask.replace('X', '0').parseBinInt
      shiftAmounts = @[]
      var numXsRemaining = mask.count('X')
      for i, c in mask:
        if c == 'X':
          dec numXsRemaining
          shiftAmounts.add (numXsRemaining, mask.high - i)

    elif line.scanf("mem[$i] = $i", address, val):
      address = (address and maskAnd) or maskOr
      for compactMask in 0 ..< 1 shl shiftAmounts.len:
        curAddress = address
        for (compactMaskShiftAmount, addressShiftAmount) in shiftAmounts:
          curAddress = curAddress or (
            (compactMask and (1 shl compactMaskShiftAmount)) shl
            (addressShiftAmount - compactMaskShiftAmount)
          )

        mem[curAddress] = val

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