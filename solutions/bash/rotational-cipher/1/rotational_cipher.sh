#!/usr/bin/env bash

alphabet+=({a..z})
ALPHABET+=({A..Z})

alpha_index() {
  local -i index

  local j
  for ((j = 0; j < 26; j++)); do
    [[ "$1" == "${alphabet[j]}" || "$1" == "${ALPHABET[j]}" ]] && index=$j
  done

  echo "$index"
}

string="$1"
ROT="$2"

for ((i = 0; i < ${#string}; i++)); do
  char="${string:i:1}"

  if [[ "$char" =~ [[:alpha:]] ]]; then
    key="$(alpha_index "$char")"
    (( idx = (ROT + key) % 26 ))

    if [[ "$char" =~ [[:lower:]] ]]; then
      cypher+="${alphabet[$idx]}"
    else
      cypher+="${ALPHABET[$idx]}"
    fi
  else
    cypher+="$char"
  fi
done

echo "$cypher"
