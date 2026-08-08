#!/usr/bin/env bash

numerator()   { echo "${1%/*}"; }
denominator() { echo "${1#*/}"; }

abs_n() {
  n="$1"
  ((n < 0)) && ((n *= -1))
  echo "$n"
}

# get all divisors for n inclusive [1,|n|]
divisors() {
  local -i n="$1" abs_n d
  local -n divisors="$2"

  divisors=("1") # Initilize with 1 since all numbers are divisible by it

  ((n != 0)) || return

  abs_n=$(abs_n "$n")
  for ((d = 2; d <= abs_n / 2; d++)); do
    ((n % d == 0)) && divisors+=("$d")
  done
  divisors+=("$abs_n")
}

# greatest common divisor, gcd(12, 8) = 4
gcd() {
  local -i a="$1" b="$2"
  local -a ad bd

  divisors $a ad
  divisors $b bd

  local -i i j
  for ((i = ${#ad[@]} - 1; i >= 0; i--)); do
    for ((j = ${#bd[@]} - 1; j >= 0; j--)); do
      if ((ad[i] == bd[j])); then
        echo "${ad[$i]}"
        return
      fi
    done
  done
}

reduce() {
  local -i a b gcd

  a=$(numerator "$1")
  b=$(denominator "$1")

  if ((a == 0)); then
    echo "0/1"
    return
  fi

  # If denominator is negative, normalize to negative numerator convention
  if (( b < 0)); then
    ((a *= -1))
    ((b *= -1))
  fi

  gcd=$(gcd "$a" "$b")

  ((a /= gcd))
  ((b /= gcd))

  echo "$a/$b"
}

add() {
  local -i a1 a2 b1 b2

  a1=$(numerator "$1")
  a2=$(numerator "$2")
  b1=$(denominator "$1")
  b2=$(denominator "$2")

  ((a = a1 * b2 + a2 * b1))
  ((b = b1 * b2))

  reduce "$a/$b"
}

subtract() {
  local -i a1 a2 b1 b2

  a1=$(numerator "$1")
  a2=$(numerator "$2")
  b1=$(denominator "$1")
  b2=$(denominator "$2")

  ((a = a1 * b2 - a2 * b1))
  ((b = b1 * b2))
  
  reduce "$a/$b"
}

multiply() {
  local -i a1 a2 b1 b2

  a1=$(numerator "$1")
  a2=$(numerator "$2")
  b1=$(denominator "$1")
  b2=$(denominator "$2")

  ((a = a1 * a2))
  ((b = b1 * b2))

  reduce "$a/$b"
}

divide() {
  local -i a1 a2 b1 b2

  a1=$(numerator "$1")
  a2=$(numerator "$2")
  b1=$(denominator "$1")
  b2=$(denominator "$2")

  ((a2 != 0)) || return 1 

  ((a = a1 * b2))
  ((b = a2 * b1))

  reduce "$a/$b"
}

abs() {
  local -i a b abs_a abs_b

  a=$(numerator "$1")
  b=$(denominator "$1")
  abs_a=$(abs_n "$a")
  abs_b=$(abs_n "$b")

  reduce "$abs_a/$abs_b"
}

pow() {
  local -i a1 b1 a b n="$2" m

  a1=$(numerator "$1")
  b1=$(denominator "$1")

  if ((n >= 0)); then
    ((a = a1 ** n))
    ((b = b1 ** n))
  else
    m=$(abs_n "$n")
    ((a = b1 ** m))
    ((b = a1 ** m))
  fi

  reduce "$a/$b"
}

rpow() {
  # x^(a/b)
  local -i x="$1" a b

  # r = a/b
  a=$(numerator "$2")
  b=$(denominator "$2")
  p=$(bc -l <<< "e((1/$b)*l($x^$a))")

  pf=$(printf '%.6f\n' "$p")
  if [[ "$pf" =~ ^[0-9]+\.0+$ ]]; then
    printf '%.1f\n' "$p"
  else
    echo "$pf"
  fi
}

case "$1" in
  "+")    add      "$2" "$3" ;;
  "-")    subtract "$2" "$3" ;;
  "*")    multiply "$2" "$3" ;;
  "/")    divide   "$2" "$3" ;;
  abs)    abs      "$2"      ;;
  pow)    pow      "$2" "$3" ;;
  rpow)   rpow     "$2" "$3" ;;
  reduce) reduce   "$2" "$3" ;;
esac
