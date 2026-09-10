#!/usr/bin/env bash

die() { echo "$*"; exit 1; }

# Reverse an array in place
reverse_array() {
  local -n arr="$1"
  local tmp_arr=("${arr[@]}")

  arr=()
  for ((i = ${#tmp_arr[@]} - 1; i >= 0; i--)); do
    arr+=("${tmp_arr[i]}")
  done
}

convert_to_base10() {
  local base="$1"
  read -ra digits <<< "$2"
  
  for ((i = 1; i <= ${#digits[@]}; i++)); do
    ((${digits[-i]} < base)) || return 1
    (( base10 += ${digits[-i]} * (base ** (i - 1)) ))
  done

  echo "$base10"
}

convert_from_base10() {
  local n="$1"
  local base="$2"
  local digits

  if ((n == 0)); then
    echo "0"
    return
  else
    while ((n > 0)); do
      digits+=("$((n % base))")
      ((n /= base))
    done
  fi

  reverse_array digits
  echo "${digits[@]}"
}

BASE_FROM="$1"
BASE_TO="$3"
DIGITS="$2"
# Empty string is equal to 0
[[ -n "$DIGITS" ]] || DIGITS="0"

# Base must be greater than 1
((BASE_FROM > 1 && BASE_TO > 1)) || die "error"
# Digits can't be negative
[[ "$DIGITS" == *-* ]] && die "error"

BASE_10="$(convert_to_base10 "$BASE_FROM" "$DIGITS")" || die "error"
convert_from_base10 "$BASE_10" "$BASE_TO"

