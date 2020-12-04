include prelude
import re

let pattern = re"(\d+)-(\d+) (\w): (\w+)"


proc parseLine(line: string): (int, int, char, string) =
    var matches: array[4, string]
    discard line.match(pattern, matches)
    let
      a = parseInt(matches[0])
      b = parseInt(matches[1])
      char = matches[2][0]
      password = matches[3]

    return (a, b, char, password)


proc main_1 =
  let input = readFile(joinPath(os.getAppDir(), "input.txt"))
  var num_valid = 0

  for line in splitLines(input):
    let
      (min, max, char, password) = parseLine(line)
      char_count = password.count(char)

    if min <= char_count and char_count <= max:
      num_valid += 1

  echo num_valid


proc main_2 =
  let input = readFile(joinPath(os.getAppDir(), "input.txt"))
  var num_valid = 0

  for line in splitLines(input):
    let (pos_0, pos_1, char, password) = parseLine(line)

    if password[pos_0 - 1] == char xor password[pos_1 - 1] == char:
      num_valid += 1

  echo num_valid


main_1()
main_2()