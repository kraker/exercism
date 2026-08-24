#!/usr/bin/env bash

n="$1"

if ((n < 1)); then
  echo "invalid input" >&2
  exit 1
elif ((n == 1)); then
  lower_bound="1.0"
  upper_bound="2.0"
elif ((n > 1 && n < 6)); then
  # Loose upper and lower bounds:
  # nlog(n) < p(n) < 2nlog(n)
  # https://www.quora.com/Given-a-number-n-what-are-some-upper-and-lower-bound-on-the-size-of-the-n-th-prime-in-terms-of-n
  lower_bound=$(bc -l <<< "$n * l($n)")
  upper_bound=$(bc -l <<< "2 * $n * l($n)")
else
  # n(log(n) + log(log(n)) - 1) < P(n) < n(log(n) + log(log(n)))
  # upper bound holds for n >= 6
  # https://en.wikipedia.org/wiki/Prime-counting_function#Inequalities
  lower_bound=$(bc -l <<< "$n * (l($n) + l(l($n)) - 1)")
  upper_bound=$(bc -l <<< "$n * (l($n) + l(l($n)))")
fi

# rounded to nearest whole integer
lb=$(printf '%.0f\n' "$lower_bound")
ub=$(printf '%.0f\n' "$upper_bound")

# Simple prime sieve to upper bound.
# Adapted from my solution "sieve" problem:
# https://exercism.org/tracks/bash/exercises/sieve/solutions/kraker
#
# Note: a segmented sieve between just lower and upper bounds would be more
# efficient...
# https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes#Segmented_sieve
# https://research.cs.wisc.edu/techreports/1990/TR909.pdf
declare -a primes out
primes[1]=0

for ((i = 2; i <= ub; i++)); do
  primes[i]=1
done

for ((i = 2; i <= ub; i++)); do
  ((primes[i] == 1)) || continue 
  out+=("$i")
  for ((j = 2 * i; j <= ub; j += i)); do
    primes[j]=0
  done
done

echo "${out[$n - 1]}"
