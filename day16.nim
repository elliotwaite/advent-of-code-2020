include prelude
import sequtils, strscans, sugar

type
  Rule = tuple[field: string, range: set[int16]]
  Rules = seq[Rule]
  Ticket = seq[int16]
  Tickets = seq[Ticket]


proc parseTickets(group: string): Tickets =
  for line in group.splitLines[1 .. ^1]:
    result.add line.split(',').mapIt(it.parseInt.int16)


proc contains(rules: Rules, val: int16): bool =
  for rule in rules:
    if val in rule.range:
      return true


proc part1(rules: Rules, nearbyTickets: Tickets): int =
  for ticket in nearbyTickets:
    for val in ticket:
      if val notin rules:
        result += val


proc part2(rules: Rules, myTicket: Ticket, nearbyTickets: Tickets): int =
  var validTickets = nearbyTickets.filterIt(it.allIt(it in rules))

  var rulePossibleFields: seq[set[int8]]
  for rule in rules:
    var possibleFields: set[int8]
    for fieldIndex in 0.int8 .. myTicket.high.int8:
      if validTickets.allIt(it[fieldIndex] in rule.range):
        possibleFields.incl fieldIndex

    rulePossibleFields.add possibleFields

  var ruleToField: Table[int, int]
  for _ in 0 .. rulePossibleFields.high:
    for ruleIndex, possibleFields in rulePossibleFields:
      if possibleFields.len == 1:
        let field = toSeq(possibleFields)[0]
        ruleToField[ruleIndex] = field
        for i in 0 .. rulePossibleFields.high:
          rulePossibleFields[i].excl field
        break

  result = 1
  for ruleIndex, rule in rules:
    if rule.field.startsWith "departure":
      result *= myTicket[ruleToField[ruleIndex]]


proc main =
  let groups = "inputs/day16.txt".readFile.split("\n\n")
  var rules = collect(newSeq):
    for line in toSeq(groups[0].splitLines):
      var field: string
      var a, b, c, d: int
      var range: set[int16]
      if line.scanf("$+: $i-$i or $i-$i", field, a, b, c, d):
        (field, {a.int16 .. b.int16, c.int16 .. d.int16})

  var myTicket = parseTickets(groups[1])[0]
  var nearbyTickets = parseTickets(groups[2])

  let answer1 = part1(rules, nearbyTickets)
  echo answer1
  doAssert answer1 == 32835

  let answer2 = part2(rules, myTicket, nearbyTickets)
  echo answer2
  doAssert answer2 == 514662805187


main()