#!/usr/bin/env bash

(($# != 2)) && echo "Usage: hamming.sh <string1> <string2>" >&2 && exit 1
((${#1} != ${#2})) && echo "strands must be of equal length" >&2 && exit 1

declare -i hamming=0
for ((i = 0; i < ${#1}; i++)); do
  if [[ "${1:i:1}" != "${2:i:1}" ]]; then
    hamming+=1
  fi
done
echo "$hamming"
