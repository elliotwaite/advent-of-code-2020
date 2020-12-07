include prelude
import hashes, intsets, sequtils, strscans

let inputPath = joinPath(os.getAppDir(), "input.txt")

type
  ParentsTable = Table[string, HashSet[string]]
  Child = tuple[color: string, count: int]
  Children = seq[Child]
  ChildrenTable = Table[string, Children]


proc parseLine(line: string): (string, seq[(string, int)]) =
  var children: string
  if line.scanf("$+ bags contain $+.", result[0], children):
    if children != "no other bags":
      var
        count: int
        color: string
      for child in children.split(", "):
        if child.strip(leading=false, chars={'s'}).scanf("$i $+ bag$.", count, color):
          result[1].add((color, count))


proc part1: int =
  var parentsTable: ParentsTable

  for line in inputPath.lines:
    let (parent, children) = line.parseLine
    for (child, count) in children:
      parentsTable.mgetOrPut(child, initHashSet[string]()).incl parent

  var ancestors: HashSet[string]

  proc addAncestors(color: string) =
    if color in parentsTable:
      for parent in parentsTable[color]:
          if parent notin ancestors:
            ancestors.incl parent
            addAncestors(parent)

  addAncestors("shiny gold")

  return ancestors.len


proc part2: int =
  var childrenTable: ChildrenTable

  for line in inputPath.lines:
    let (parent, children) = line.parseLine
    childrenTable[parent] = newSeq[Child]()
    for (child, count) in children:
      childrenTable[parent].add (child, count)

  var numDescendentsMemo: Table[string, int]

  proc numDescendents(color: string): int =
    if color in numDescendentsMemo:
      return numDescendentsMemo[color]

    if color in childrenTable:
      for (child, count) in childrenTable[color]:
        result += count * (1 + numDescendents(child))

  return numDescendents("shiny gold")


when isMainModule:
  let answer1 = part1()
  doAssert answer1 == 224
  echo answer1

  let answer2 = part2()
  doAssert answer2 == 1488
  echo answer2