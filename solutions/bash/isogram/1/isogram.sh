#!/usr/bin/env bash

str_sort() {
  local str="${1,,}"
  
  for a in {a..z}; do
    for ((i = 0; i < ${#str}; i++)); do
      [[ "$a" == "${str:i:1}" ]] && sorted_str+="$a"
    done
  done
  echo "$sorted_str"
}

str_dedup() {
  local str="$1"

  for ((j = 0; j < ${#str} - 1; j++)); do
    [[ "${str:j:1}" == "${str:j+1:1}" ]] || str_dedup+="${str:j:1}"
  done
  str_dedup+="${str: -1}"

  echo "$str_dedup"
}

STRING="$1"
STRING_SORTED="$(str_sort "$STRING")"
STRING_DEDUP="$(str_dedup "$STRING_SORTED")"

((${#STRING_SORTED} == ${#STRING_DEDUP})) && echo "true" || echo "false"
