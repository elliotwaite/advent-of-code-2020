include prelude
import arraymancer, sequtils, sugar


proc step3d(s1: var Tensor[int], s2: var Tensor[int]) =
  for i in 0 ..< s1.shape[0]:
    for j in 0 ..< s1.shape[1]:
      for k in 0 ..< s1.shape[2]:
        let count = s1[
          max(0, i - 1) .. min(i + 1, s1.shape[0] - 1),
          max(0, j - 1) .. min(j + 1, s1.shape[1] - 1),
          max(0, k - 1) .. min(k + 1, s1.shape[2] - 1),
        ].sum
        if count == 3 or count == 4 and s1[i, j, k] == 1:
          s2[i, j, k] = 1
        else:
          s2[i, j, k] = 0


proc step4d(s1: var Tensor[int], s2: var Tensor[int]) =
  for i in 0 ..< s1.shape[0]:
    for j in 0 ..< s1.shape[1]:
      for k in 0 ..< s1.shape[2]:
        for l in 0 ..< s1.shape[3]:
          let count = s1[
            max(0, i - 1) .. min(i + 1, s1.shape[0] - 1),
            max(0, j - 1) .. min(j + 1, s1.shape[1] - 1),
            max(0, k - 1) .. min(k + 1, s1.shape[2] - 1),
            max(0, l - 1) .. min(l + 1, s1.shape[3] - 1),
          ].sum
          if count == 3 or count == 4 and s1[i, j, k, l] == 1:
            s2[i, j, k, l] = 1
          else:
            s2[i, j, k, l] = 0


proc part1(s0: Tensor[int]): int =
  let n = 6
  let pad = 2 * n
  var s1 = zeros[int]([pad + 1, pad + s0.shape[0], pad + s0.shape[1]])
  s1[n, n..^(n+1), n..^(n+1)] = s0.reshape(1, s0.shape[0], s0.shape[1])
  var s2 = s1.clone

  for _ in 1 .. n:
    step3d(s1, s2)
    swap(s1, s2)

  return s1.sum


proc part2(s0: Tensor[int]): int =
  let n = 6
  let pad = 2 * n
  var s1 = zeros[int]([pad + 1, pad + 1, pad + s0.shape[0], pad + s0.shape[1]])
  s1[n, n, n..^(n+1), n..^(n+1)] = s0.reshape(1, 1, s0.shape[0], s0.shape[1])
  var s2 = s1.clone

  for _ in 1 .. n:
    step4d(s1, s2)
    swap(s1, s2)

  return s1.sum


proc main =
  let lines = toSeq("inputs/day17.txt".lines)
  var s0 = zeros[int]([lines.len, lines[0].len])
  for i, line in lines:
    for j, c in line:
      if c == '#':
        s0[i, j] = 1

  let answer1 = part1(s0)
  echo answer1
  doAssert answer1 == 207

  let answer2 = part2(s0)
  echo answer2

  doAssert answer2 == 2308


main()