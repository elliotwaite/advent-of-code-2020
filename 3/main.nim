include prelude


func numTrees(lines: openArray[string], right: int, down: int): int =
  let width = lines[0].len

  var
    num_trees = 0
    x = 0

  for line_i in countup(down, lines.high, down):
    x = (x + right) mod width
    if lines[line_i][x] == '#':
      num_trees += 1

  return num_trees


proc main_1 =
  let
    input = readFile(joinPath(os.getAppDir(), "input.txt"))
    lines = splitLines(input)

  echo numTrees(lines, 3, 1)


proc main_2 =
  let
    input = readFile(joinPath(os.getAppDir(), "input.txt"))
    lines = splitLines(input)
    a = numTrees(lines, 1, 1)
    b = numTrees(lines, 3, 1)
    c = numTrees(lines, 5, 1)
    d = numTrees(lines, 7, 1)
    e = numTrees(lines, 1, 2)

  echo a * b * c * d * e


main_1()
main_2()