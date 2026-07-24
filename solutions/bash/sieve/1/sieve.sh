#!/usr/bin/env bash

n="$1"


sieve=("F" "T")
for ((i = 2; i <= n; i++)); do
  sieve+=("T")
done

p=2
while ((p <= n)); do
  if [[ "${sieve[$p]}" == "T" ]]; then
    primes+=($p)
    ((m = p * p))
    while ((m <= n)); do
      sieve[m]="F"
      ((m += p))
    done
  fi
  ((p += 1))
done

echo "${primes[@]}"

