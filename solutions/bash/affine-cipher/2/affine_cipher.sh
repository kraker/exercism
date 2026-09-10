#!/usr/bin/env bash

die() { echo "$*"; exit 1; }

math::abs() {
  n="$1"
  ((n < 0)) && ((n *= -1))
  echo "$n"
}

# get all divisors for n inclusive [1,|n|]
math::divisors() {
  local -i n="$1" abs d
  local -n divisors="$2"

  divisors=("1") # Initilize with 1 since all numbers are divisible by it

  ((n != 0)) || return

  abs=$(math::abs "$n")
  for ((d = 2; d <= abs / 2; d++)); do
    ((n % d == 0)) && divisors+=("$d")
  done
  divisors+=("$abs")
}

# greatest common divisor, gcd(12, 8) = 4
math::gcd() {
  local -i a="$1" b="$2"
  local -a ad bd

  math::divisors $a ad
  math::divisors $b bd

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

alpha_index() {
  local letter="${1,,}"
  local -i j
  for ((j = 0; j < 26; j++)); do
    if [[ "$letter" == "${alphabet[$j]}" ]]; then
      echo "$j"
      return
    fi
  done
}

encode() {
  local -i a="$1"
  local -i b="$2"
  local    text="$3"

  local -i j E
  local char cipher_text
  for ((j = 0; j < ${#text}; j++)); do
    char="${text:$j:1}"
    if [[ "$char" =~ [[:space:][:punct:]] ]]; then
      continue
    elif [[ "$char" =~ [[:alpha:]] ]]; then
      i=$(alpha_index "$char")
      ((E = (a*i + b) % m))
      cipher_text+="${alphabet[$E]}"
    else
      cipher_text+="$char"
    fi
  done

  local -i k
  local -a cipher
  for ((k = 0; k < ${#cipher_text}; k += 5)); do
    cipher+=( "${cipher_text:k:5}" )
  done

  echo "${cipher[@]}"
}

# find modular multiplicative inverse MMI
mmi() {
  local -i a="$1" m="$2" x=0 mmi
  while (( mmi != 1 )); do
    ((x++))
    ((mmi = (a * x) % 26)) 
  done
  echo "$x"
}

decode() {
  local -i a="$1"
  local -i b="$2"
  local    cipher_text="${3// /}"

  local -i l D
  for ((l = 0; l < ${#cipher_text}; l++)); do
    char="${cipher_text:$l:1}"
    if [[ "$char" =~ [[:alpha:]] ]]; then
      y=$(alpha_index "$char")
      mmi=$(mmi "$a" "$m")
      ((D = (mmi * (y - b)) % m))
      text+="${alphabet[$D]}"
    else
      text+="$char"
    fi
  done

  echo "$text"
}

main() {
  local -a alphabet=({a..z})
  local -i m="${#alphabet[@]}"

  (( $(math::gcd "$2" "$m") == 1 )) || die "a and m must be coprime."

  case "$1" in
    encode) encode "$2" "$3" "$4" ;;
    decode) decode "$2" "$3" "$4" ;;
  esac
}

main "$@"
