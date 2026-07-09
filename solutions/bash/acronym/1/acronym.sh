#!/usr/bin/env bash

# Split hyphen into separate words
phrase="${1//-/ }"
# Read words into array stripping out non-alpha
read -r -a phrase_arr <<< "${phrase//[^[:alpha:] ]/}"

for word in "${phrase_arr[@]}"; do
  acronym+="${word:0:1}"
done
echo "${acronym^^}"
