#!/usr/bin/env bash

# Cast to lowercase and strip all non-alphanumeric characters.
declare -l text="${1//[^[:alnum:]]/}"

((${#text} > 0)) || { echo ""; exit 0; }

# find nearest square that satisfies condition: c * c >= length
c=0
while ((c * c < ${#text})); do
  ((c++))
done

# make array representing rows of length c
for ((i = 0; i < ${#text}; i += c)); do
  rows+=("${text:i:c}")
done

# make array of columns by slicing each index of rows
for ((j = 0; j < c; j++)); do
  col=""
  for row in "${rows[@]}"; do
    char="${row:j:1}"
    col+="${char:-" "}"  # Empty char appends a space
  done
  cols+=("$col")
done

echo "${cols[@]}"
