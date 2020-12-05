include prelude
import algorithm
import re
import sequtils
import sugar

let
  requiredFields = toHashSet(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
  hclPattern = re"^#[0-9a-f]{6}$"
  eclSet = toHashSet(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
  pidPattern = re"^\d{9}$"


proc main_1 =
  let
    input = readFile(joinPath(os.getAppDir(), "input.txt"))
    passportStrs = input.split("\n\n")

  var num_valid = 0

  for passportStr in passportStrs:
    let fields = passportStr.split(re" |\n").map(x => x.split(':')[0])
    if requiredFields <= toHashSet(fields):
      num_valid += 1

  echo num_valid

proc isValid(passport: Table[string, string]): bool =
  try:
    let
      byr = passport["byr"].parseInt
      iyr = passport["iyr"].parseInt
      eyr = passport["eyr"].parseInt
      hgtVal = passport["hgt"][0 .. ^3].parseInt
      hgtUnit = passport["hgt"][^2 .. ^1]

    doAssert byr >= 1920 and byr <= 2002
    doAssert iyr >= 2010 and iyr <= 2020
    doAssert eyr >= 2020 and eyr <= 2030
    doAssert (
      (hgtUnit == "cm" and hgtVal >= 150 and hgtVal <= 193) or
      (hgtUnit == "in" and hgtVal >= 59 and hgtVal <= 76)
    )
    doAssert passport["hcl"].match(hclPattern)
    doAssert eclSet.contains(passport["ecl"])
    doAssert passport["pid"].match(pidPattern)
    return true

  except:
    return false


proc main_2 =
  let
    input = readFile(joinPath(os.getAppDir(), "input.txt"))
    passportStrs = input.split("\n\n")

  var num_valid = 0

  for passportStr in passportStrs:
    var passport: Table[string, string]
    for key_val in passportStr.split(re" |\n"):
      let key_val_split = key_val.split(':')
      passport[key_val_split[0]] = key_val_split[1]

    if isValid(passport):
      num_valid += 1

  echo num_valid


main_1()
main_2()