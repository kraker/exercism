#!/usr/bin/env bash

read -ra words <<< "$@"

pig_latin() {
  local word="$1"
  local pig

  if [[ "$word" =~ ^[aeiou] || "$word" =~ ^(xr|yt) ]]; then
    pig="${word}ay"
  elif [[ "$word" =~ ^[^aeiou]*qu ]]; then
    c="${BASH_REMATCH[0]}"
    pig="${word#"$c"}${c}ay"
  elif [[ "$word" =~ ^[^aeiou]+y ]]; then
    c="${BASH_REMATCH[0]%y}"
    pig="${word#"$c"}${c}ay"
  elif [[ "$word" =~ ^[^aeiou]+ ]]; then
    c="${BASH_REMATCH[0]}"
    pig="${word#"$c"}${c}ay"
  fi

  echo "$pig"
}

for word in "${words[@]}"; do
  pigs+=("$(pig_latin "$word")")
done

printf '%s\n' "${pigs[*]}"
