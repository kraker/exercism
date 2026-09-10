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

build_stanza() {
  local stanza="$1"
  local s1="s"
  local s2="s"

  ((stanza == 1)) && unset s1
  ((stanza == 2)) && unset s2

  cat << EOF
${counts[$stanza]^} green bottle${s1:-} hanging on the wall,
${counts[$stanza]^} green bottle${s1:-} hanging on the wall,
And if one green bottle should accidentally fall,
There'll be ${counts[$stanza - 1]} green bottle${s2:-} hanging on the wall.
EOF
}

build_rhyme() {
  local start="$1"
  local count="$2"

  for ((i = 0; i < count; i++)); do
    build_stanza $((start - i))
    echo
  done
}

(($# == 2))  || { echo "2 arguments expected" >&2; exit 1; }
(($2 <= $1)) || { echo "cannot generate more verses than bottles" >&2; exit 1; }

build_rhyme "$1" "$2"
