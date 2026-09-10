#!/usr/bin/env bash

n="$1"

((n > 0)) || { 
  echo "Classification is only possible for positive integers." >&2
  exit 1
}

factors=("1")
for ((d = 2; d * d <= n; d++)); do
  if ((n % d == 0)); then
    p=$((n / d))
    factors+=("$d")
    ((p != d)) && factors+=("$p")
  fi
done

for factor in "${factors[@]}"; do
  ((sum += factor))
done

if   ((sum <  n || n == 1)); then echo "deficient"
elif ((sum == n));           then echo "perfect"
elif ((sum >  n));           then echo "abundant"
fi
