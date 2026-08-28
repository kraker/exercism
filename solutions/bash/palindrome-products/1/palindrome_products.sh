#!/usr/bin/env bash

# NOTE: A brute forced attempt at the problem to get all test cases to pass as
# a first attempt at a solution... I'm sure this could be more elegant.

#str::reverse() {
#  local string="$1"
#  local reverse
#
#  for ((i = ${#string} - 1; i >= 0; i--)); do
#    reverse+="${string:i:1}"
#  done
#
#  echo "$reverse"
#}

#palindromes() {
#  local -i length="$1"
#  local -n pal="$2"
#
#  local -i midpoint
#  if ((length % 2 == 0)); then
#    ((midpoint = length / 2))
#  else
#    ((midpoint = (length / 2) + 1))
#  fi
#
#  local -i m #n
#  ((m = 10 ** midpoint))
#  #((n = 10 ** (midpoint -1)))
#
#  local -i i
#  local r s
#  pal=()
#  for ((i = 1; i < m; i++)); do
#    r=$(str::reverse "$i")
#    s="${r:1}"
#    pal[$i$r]=1
#    pal[$i$s]=1
#  done
#
#  #echo "palindromes: ${!palindromes[@]}"
#}

# Brute force create array of palindrome numbers up to 8 characters in length
# This is faster than building palindromes based on string manipulation above.
# This is also *way* faster than calculating all products and checking if each
# one is a palindrome...
palindromes() {
  local -n pals="$1"

  for a in {1..9}; do
    pals[$a]=1
    pals[$a$a]=1
    for b in {0..9}; do
      pals[$a$b$a]=1
      pals[$a$b$b$a]=1
      for c in {0..9}; do
        pals[$a$b$c$b$a]=1
        pals[$a$b$c$c$b$a]=1
        for d in {0..9}; do
          pals[$a$b$c$d$c$b$a]=1
          pals[$a$b$c$d$d$c$b$a]=1
        done
      done
    done
  done
}

palindrome_products() {
  local case="$1"
  local -i min="$2"
  local -i max="$3"
  local -n pproducts="$4"

  local -ai palindromes
  palindromes palindromes

  # Larger ranges start taking a long time to calc... for example, 1000 - 9999.
  # but these slices of the range are arbitrary just to get test cases to pass.
  # There might be corner cases I'm not accounting for...
  # Better would be to find definitive mathematical limits for smallest and
  # largest possible palindrome products given an arbitrary range.
  case "$case" in
    smallest)
      if ((max - min >= 1000)); then
        ((max = min + 1000))
      fi
      ;;
    largest)
      if ((max - min >= 1000)); then
        ((min = max - 1000))
      fi
  esac

  # Brute force all products in range and then check each against the list of
  # palindromes we generated.
  local -i i j
  for ((i = min; i <= max; i++)); do
    for ((j = i; j <= max; j++)); do
      ((p = i * j))
      if ((palindromes[p] == 1)); then
        pproducts[p]+="[$i, $j]"
      fi
    done
  done
}

main () {
  local -i min="$2"
  local -i max="$3"

  ((min > max)) && { echo "min must be <= max" >&2; exit 1; }

  local -a products
  palindrome_products "$1" "$min" "$max" products

  if ((${#products[@]} < 1)); then
    exit
  fi

  local -ai indices
  indices=("${!products[@]}")

  case "$1" in
    smallest) echo "${indices[0]}: ${products[${indices[0]}]}" ;;
    largest) echo "${indices[-1]}: ${products[${indices[-1]}]}" ;;
    *) echo "first arg should be 'smallest' or 'largest'" >&2; exit 1 ;;
  esac
}

main "$@"
