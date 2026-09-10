#!/usr/bin/env bash

atbash() {
  local char="$1"
  local -i i

  for ((i = 0; i < 26; i++)); do
    if [[ "$char" == "${alphabet[i]}" ]]; then
      echo "${alphabet[-i - 1]}"
      return 0
    fi
  done

  return 1
}

encode() {
  # Cast to lowercase and strip out anything that's not alphanumeric
  local -l string="${1//[^[:alnum:]]/}" cypher
  local -i i

  for ((i = 0; i < ${#string}; i++)); do
    # After every 5th char is a space
    ((i != 0 && i % 5 == 0)) && cypher+=" "
    char="${string:i:1}"
    cypher+=$(atbash "$char") || cypher+="$char"
  done

  echo "$cypher"
}

decode() {
  # Strip out spaces
  local cypher="${1// /}" string
  local -i i

  for ((i = 0; i < ${#cypher}; i++)); do
    char="${cypher:i:1}"
    string+=$(atbash "$char") || string+="$char"
  done

  echo "$string"
}

readonly alphabet=({a..z})

"$1" "$2"
