#!/usr/bin/env bash

students=(
  "Alice"
  "Bob"
  "Charlie"
  "David"
  "Eve"
  "Fred"
  "Ginny"
  "Harriet"
  "Ileana"
  "Joseph"
  "Kincaid"
  "Larry"
)

declare -A codes=(
  [G]=grass
  [C]=clover
  [R]=radishes
  [V]=violets
)

mapfile -t rows < <(echo -e "$1")
student="$2"

# Find student index
for index in "${!students[@]}"; do
  if [[ "$student" == "${students[index]}" ]]; then
    break
  fi
done

slice=$((index * 2))

for row in "${rows[@]}"; do
  p1="${row:slice:1}"
  p2="${row:slice + 1:1}"
  plants+=("${codes[$p1]}" "${codes[$p2]}")
done

echo "${plants[@]}"
