include prelude
import re, sequtils

let inputPath = joinPath(os.getAppDir(), "input.txt")


let
  requiredFields = toHashSet(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
  hclPattern = re"^#[0-9a-f]{6}$"
  eclSet = toHashSet(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
  pidPattern = re"^\d{9}$"


proc isValid(passport: Table[string, string]): bool =
  try:
    doAssert passport["byr"].parseInt in 1920 .. 2002
    doAssert passport["iyr"].parseInt in 2010 .. 2020
    doAssert passport["eyr"].parseInt in 2020 .. 2030
    doAssert (
      (passport["hgt"][^2 .. ^1] == "cm" and passport["hgt"][0 .. ^3].parseInt in 150 .. 193) or
      (passport["hgt"][^2 .. ^1] == "in" and passport["hgt"][0 .. ^3].parseInt in 59 .. 76)
    )
    doAssert passport["hcl"].match(hclPattern)
    doAssert eclSet.contains(passport["ecl"])
    doAssert passport["pid"].match(pidPattern)
    return true

  except:
    return false


proc toPassport(passportStr: string): Table[string, string] =
  for keyVal in passportStr.splitWhitespace:
    let keyValSplit = keyVal.split(':')
    result[keyValSplit[0]] = keyValSplit[1]


proc part1: int =
  let passports = inputPath.readFile.split("\p\p").map(toPassport)
  for passport in passports:
    if toSeq(passport.keys).toHashSet >= requiredFields:
      inc result


proc part2: int =
  let passports = inputPath.readFile.split("\p\p").map(toPassport)
  for passport in passports:
    if isValid(passport):
      inc result


when isMainModule:
  let answer1 = part1()
  doAssert answer1 == 196
  echo answer1

  let answer2 = part2()
  doAssert answer2 == 114
  echo answer2