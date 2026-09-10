#!/usr/bin/env bash

counts=(
  "no"
  "one"
  "two"
  "three"
  "four"
  "five"
  "six"
  "seven"
  "eight"
  "nine"
  "ten"
)

build_verse() {
  local verse="$1"

  ((verse == 1)) && s=""
  ((verse == 2)) && s=""

  cat << EOF
${counts[$verse]^} green bottle${s:-s} hanging on the wall,
${counts[$verse]^} green bottle${s:-s} hanging on the wall,
And if one green bottle should accidentally fall,
There'll be ${counts[$stanza - 1]} green bottle${s:-s} hanging on the wall.
EOF
}

sing() {
  local start="$1"
  local count="$2"

  for ((i = 0; i < count; i++)); do
    build_verse $((start - i))
    echo
  done
}

(($# == 2))  || { echo "2 arguments expected" >&2; exit 1; }
(($2 <= $1)) || { echo "cannot generate more verses than bottles" >&2; exit 1; }

sing "$1" "$2"
