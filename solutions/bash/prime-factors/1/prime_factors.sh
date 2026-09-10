#!/usr/bin/env bash

n="$1"

# Trial division algorithm
for ((d = 2; d * d <= n; d++)); do
  while ((n % d == 0)); do
    factors+=("$d")
    (( n /= d ))
  done
done

((n > 1)) && factors+=("$n")

echo "${factors[@]}"
