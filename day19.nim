include prelude
import re, sequtils, strformat, sugar

const maxLoops = 15

type
  Rules = Table[int, seq[seq[int]]]
  Mem = Table[int, string]
  Messages = seq[string]


proc getPattern(rule: int, rules: Rules, mem: var Mem): string =
  if rule in mem:
    return mem[rule]

  let options = rules[rule]
  if options.len > 1:
    result &= "("

  for i, option in options:
    if i > 0:
      result &= "|"

    for subRule in option:
      result &= getPattern(subRule, rules, mem)

  if options.len > 1:
    result &= ")"

  mem[rule] = result


proc part1(rules: Rules, mem: Mem, messages: Messages): int =
  var mem = mem
  let regex = re("^" & getPattern(0, rules, mem) & "$")
  for message in messages:
    if message.match(regex):
      inc result


proc part2(rules: Rules, mem: Mem, messages: Messages): int =
  var mem = mem
  mem[8] = "c"
  mem[11] = "d"
  let p42 = getPattern(42, rules, mem)
  let p31 = getPattern(31, rules, mem)
  let p0 = "^" & getPattern(0, rules, mem).replace("c", fmt"({p42})+") & "$"

  let regexes = collect(newSeq):
    for i in 1 .. maxLoops:
      re(p0.replace("d", fmt"({p42}){{{i}}}({p31}){{{i}}}"))

  for message in messages:
    for regex in regexes:
      if message.match(regex):
        inc result
        break


proc main =
  let groups = "inputs/day19.txt".readFile.split("\n\n")

  var rules: Rules
  var mem: Mem
  for line in groups[0].splitLines:
    let split1 = line.split(": ")
    let key = split1[0].parseInt
    if split1[1].startsWith('"'):
      mem[key] = split1[1][1 .. ^2]
    else:
      rules[key] = toSeq(split1[1].split(" | ")).mapIt(it.split.map(parseInt))

  let messages = groups[1].splitLines

  let answer1 = part1(rules, mem, messages)
  echo answer1
  doAssert answer1 == 144

  let answer2 = part2(rules, mem, messages)
  echo answer2
  doAssert answer2 == 260


main()