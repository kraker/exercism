#!/usr/bin/env bash

shopt -s assoc_expand_once

string="$1"

# Strip out punctuation except ' and whitespace chars.
string="${string//[^\'[:alnum:]]/ }"

read -ra words <<< "${string,,}"

declare -A counts
for word in "${words[@]}"; do
  # Remove leading and trailing apostrophes from words
  word="${word#\'}"
  word="${word%\'}"

  [[ -n "$word" ]] && ((counts[$word] += 1))
done

for word in "${!counts[@]}"; do
  echo "$word: ${counts[$word]}"
done

