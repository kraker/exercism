#!/usr/bin/env bash

string="$1"

# Strip out punctuation except ' and whitespace chars.
string="${string//[^\'[:digit:][:alpha:]]/ }"

read -ra words <<< "${string,,}"

declare -A counts
for word in "${words[@]}"; do
  # Remove leading and trailing apostrophes from words
  w="${word#\'}"
  w="${w%\'}"

  ((counts[$w] += 1))
done

for word in "${!counts[@]}"; do
  echo "$word: ${counts[$word]}"
done

