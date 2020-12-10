include prelude
import strscans, sugar


proc part1(vals: seq[(int, int, string, string)]): int =
  for (min, max, char, pass) in vals:
    if pass.count(char[0]) in min .. max:
      inc result


proc part2(vals: seq[(int, int, string, string)]): int =
  for (pos0, pos1, char, pass) in vals:
    if pass[pos0 - 1] == char[0] xor pass[pos1 - 1] == char[0]:
      inc result


proc main =
  let vals = collect(newSeq):
    for line in "inputs/day02.txt".lines:
      var
        a, b: int
        char, pass: string

      if line.scanf("$i-$i $w: $w", a, b, char, pass):
        (a, b, char, pass)

  let answer1 = part1(vals)
  echo answer1
  doAssert answer1 == 666

  let answer2 = part2(vals)
  echo answer2
  doAssert answer2 == 670


main()