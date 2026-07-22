#!/usr/bin/env bash

n="$1"

# Wheel factorization (optimization of "Trial division"), only check odd numbers
# after 2
while ((n % 2 == 0)); do
  factors+=("2")
  (( n /= 2 ))
done

for ((d = 3; d * d <= n; d += 2)); do
  while ((n % d == 0)); do
    factors+=("$d")
    (( n /= d ))
  done
done

((n > 1)) && factors+=("$n")

echo "${factors[@]}"
