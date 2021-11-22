include prelude


proc part1(groups: seq[string]): int =
  for group in groups:
    var groupSet: set[char]
    for line in group.splitLines:
      for char in line:
        groupSet.incl char

    result += groupSet.len


proc part2(groups: seq[string]): int =
  for group in groups:
    var groupSet = {'a' .. 'z'}
    for line in group.splitLines:
      var lineSet: set[char]
      for char in line:
        lineSet.incl char

      groupSet = groupSet * lineSet

    result += groupSet.len


proc main =
  var groups = "inputs/day06.txt".readFile.split("\p\p")

  let answer1 = part1(groups)
  echo answer1
  doAssert answer1 == 6782

  let answer2 = part2(groups)
  echo answer2
  doAssert answer2 == 3596


main()