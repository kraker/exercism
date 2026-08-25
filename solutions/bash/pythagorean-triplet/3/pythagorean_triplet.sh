#!/usr/bin/env bash

# Using c^2 identities we can simplify using algebra so that we can find b in
# terms of a and N where N is the given perimeter of the triangle.
# a + b + c = N
# N - a - b = c
# (N - a - b)^2 = c^2 = a^2 + b^2
# N^2 - 2aN - 2bN + 2ab + a^2 + b^2 = a^2 + b^2
# N^2 - 2aN - 2bN + 2ab = 0
# N^2 - 2aN = 2bN - 2ab
# N(N - 2a) = 2b(N - a)
# b = N(N - 2a) / 2(N - a)

# Reimplementation of exemplary solution:
# https://exercism.org/tracks/bash/exercises/pythagorean-triplet/solutions/ExercismGhost
N="$1"
((N % 2 != 0)) && exit

a=1
while true; do
  if ((N * (N - 2 * a) % (2 * (N - a)) == 0)); then
    ((b = N * (N - 2 * a) / (2 * (N - a))))
    ((a >= b)) && break
    echo "$a,$b,$((N - a - b))"
  fi
  ((a++))
done

