#!/usr/bin/env bash

# Adapted from @glennj's solution:
# https://exercism.org/tracks/bash/exercises/palindrome-products/solutions/glennj
# whose solution uses the algorithm lifted from:
# https://exercism.io/tracks/python/exercises/palindrome-products/solutions/d68cab86cad94d4d821f26da44bb0722

# This times out in exercism, but tests are successful on my machine:
# ❯ exercism test
# Running tests via `bats palindrome_products.bats`
#
# 1..14
# ok 1 find the smallest palindrome from single digit factors
# ok 2 find the largest palindrome from single digit factors
# ok 3 find the smallest palindrome from double digit factors
# ok 4 find the largest palindrome from double digit factors
# ok 5 find the smallest palindrome from triple digit factors
# ok 6 find the largest palindrome from triple digit factors
# ok 7 find the smallest palindrome from four digit factors
# ok 8 find the largest palindrome from four digit factors
# ok 9 empty result for smallest if no palindrome in the range
# ok 10 empty result for largest if no palindrome in the range
# ok 11 error result for smallest if min is more than max
# ok 12 error result for largest if min is more than max
# ok 13 smallest product does not use the smallest factor
# ok 14 error result for first param

die() { echo "$*" >&2; exit 1; }

is_palindrome() {
  local word="$1"
  local -i i j length="${#word}"
  for ((i = 0, j = 1; i < length / 2; i++, j++)); do
    [[ "${word:i:1}" == "${word:(-j):1}" ]] || return 1
  done
}

smallest() {
  local -i min="$1" max="$2"
  local -i min_product max_product

  ((min_product = min * min))
  ((max_product = max * max))

  local -i i j
  for (( i = min_product; i <= max_product; i++)); do
    if is_palindrome "$i"; then
      for ((j = min; j * j <= i; j++)); do
        ((i % j == 0)) || continue
        factors+=("[$j, $((i / j))]")
      done
      if ((${#factors[@]} > 0)); then
        echo "$i: ${factors[*]}"
        break
      fi
    fi
  done
}

largest() {
  local -i min="$1" max="$2"
  local -i min_product max_product

  ((min_product = min * min))
  ((max_product = max * max))

  local -i i j
  for (( i = max_product; i >= min_product; i--)); do
    if is_palindrome "$i"; then
      for ((j = max; j * j >= i; j--)); do
        ((i % j == 0)) || continue
        factors+=("[$((i / j)), $j]")
      done
      if ((${#factors[@]} > 0)); then
        echo "$i: ${factors[*]}"
        break
      fi
    fi
  done
}

main() {
  local -i min="$2" max="$3"

  ((min > max)) && die "min must be <= max"

  case "$1" in
    smallest) smallest "$min" "$max" ;;
    largest)  largest "$min" "$max"  ;;
    *) die "first arg should be 'smallest' or 'largest'" ;;
  esac
}

main "$@"
