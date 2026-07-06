#!/usr/bin/env bash

string="${1,,}"

count=0
for letter in {a..z}; do
  [[ "$string" =~ $letter ]] && ((count += 1))
done

((count == 26)) && echo "true" || echo "false"
