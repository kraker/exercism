#!/usr/bin/env bash

word="$1"
word_lower="${word,,}"
read -ra words <<< "$2"

for elem in "${words[@]}"; do
  # If words are not the same length can't be an anagram
  (( ${#elem} == ${#word} )) || continue
  # Can't be an anagram if words are the same
  [[ "$word_lower" == "${elem,,}" ]] && continue

  # Count how many letters are a match. If they're the same, then is an anagram.
  # NOTE: Still need to figure out how to handle repeated letters...
  count=0
  for ((i = 0; i < ${#word}; i++)); do
    letter="${word_lower:i:1}"
    [[ "${elem,,}" =~ $letter ]] && (( count+=1 ))
  done
  (( count == ${#word} )) && anagrams+=("$elem")
done

echo "${anagrams[@]}"
