#!/usr/bin/env bash

nums="$1"
span="$2"

die() {
  printf '%s\n' "$1" >&2
  exit 1
}

[[ -z "$nums" ]]      && die "series cannot be empty"
(( span == 0 ))       && die "slice length cannot be zero"
(( span < 0 ))        && die "slice length cannot be negative"
(( span > ${#nums} )) && die "slice length cannot be greater than series length"

for ((i = 0; i <= ${#nums} - span; i++)); do
  substr+=("${nums:i:span}")
done

echo "${substr[@]}"
