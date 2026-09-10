#!/usr/bin/env bash

# lowercase sort by letter in alphabetic order
str_sort() {
  local str="$1"

  for c in {a..z}; do
    for ((i = 0; i < ${#str}; i++)); do
      [[ $c == "${str:i:1}" ]] && sorted+="$c"
    done
  done

  echo "$sorted"
}

word="$1"
read -ra words <<< "$2"
key="$(str_sort "${word,,}")"

for case in "${words[@]}"; do
  # Word can't be anagram of itself
  if [[ "${word,,}" != "${case,,}" ]]; then
    k="$(str_sort "${case,,}")"
    [[ "$key" == "$k" ]] && anagrams+=("$case")
  fi
done

echo "${anagrams[@]}"
