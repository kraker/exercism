#!/usr/bin/env bash

total() {
  local sum=0
  for i in {1..64}; do
    sum=$(bc <<< "$sum + $(grains_of_wheat $i)")
  done
  echo "$sum"
}

grains_of_wheat() {
  local square="$1"
  bc <<< "2 ^ ($square -1)"
}

if [[ "$1" == "total" ]]; then
  total
elif (($1 > 0 && $1 <= 64)); then
  grains_of_wheat "$1"
else
  echo "Error: invalid input" >&2
  exit 1
fi

