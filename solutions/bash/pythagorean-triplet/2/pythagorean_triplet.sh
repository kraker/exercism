#!/usr/bin/env bash

N="$1"

# a < b < c
# Using c^2 identities we can simplify using algebra so that only need to find 
# a and b.
# a + b + c = N
# N - a - b = c
# (N - a - b)^2 = c^2
# a^2 + b^2 = c^2
# (N - a - b)^2 = a^2 + b^2
# N^2 - 2aN - 2bN + 2ab + a^2 + b^2 = a^2 + b^2
# N^2 - 2aN - 2bN + 2ab = 0
# N^2 - 2N(a + b) + 2ab = 0

# Since we know a < b < c and c = N - a - b then a < b < N - a - b
for ((a = 1; a < N - a - b; a++)); do
  for ((b = a + 1; b < N - a - b; b++)); do
    if (((N ** 2) - (2 * N * (a + b)) + (2 * a * b) == 0)); then
      c=$((N - a - b))
      echo "$a,$b,$c"
    fi
  done
done

