#!/usr/bin/env bash

clauses=(
  " the house that Jack built."
  " the malt that lay in"
  " the rat that ate"
  " the cat that killed"
  " the dog that worried"
  " the cow with the crumpled horn that tossed"
  " the maiden all forlorn that milked"
  " the man all tattered and torn that kissed"
  " the priest all shaven and shorn that married"
  " the rooster that crowed in the morn that woke"
  " the farmer sowing his corn that kept"
  " the horse and the hound and the horn that belonged to"
)

build_stanza() {
  local -i stanza="$1"

  string=""
  for ((j = stanza - 1; j >= 0; j--)); do
    string+="${clauses[$j]}"
  done

  echo "This is${string}"
}

build_rhyme() {
  local -i start="$1"
  local -i end="$2"

  for ((i = start; i <= end; i++)); do
    build_stanza "$i"
  done
}

(($1 < 1 || $1 > 12 || $2 < 1 || $2 > 12)) && echo "invalid" >&2 && exit 1

build_rhyme "$1" "$2"

