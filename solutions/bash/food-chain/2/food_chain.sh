#!/usr/bin/env bash

die() { echo "$*" >&2; exit 1; }

build_stanza() {
  local -i n="$1" i
  local lines line

  lines+=("I know an old lady who swallowed a ${food[$n]}.")
  if ((n > 1)); then
    lines+=("${exclaim[$n]}")

    if ((n == 8)); then
      printf '%s\n' "${lines[@]}"
      return
    fi

    for ((i = n; i >= 2; i--)); do
      line="She swallowed the ${food[$i]} to catch the ${food[$i - 1]}"
      if ((i == 3)); then
        line+=" that wriggled and jiggled and tickled inside her."
      else
        line+="."
      fi
      lines+=("$line")
    done
  fi
  lines+=("I don't know why she swallowed the fly. Perhaps she'll die.")

  printf '%s\n' "${lines[@]}"
}

food=(
  ""
  "fly"
  "spider"
  "bird"
  "cat"
  "dog"
  "goat"
  "cow"
  "horse"
)

exclaim=(
  ""
  ""
  "It wriggled and jiggled and tickled inside her."
  "How absurd to swallow a bird!"
  "Imagine that, to swallow a cat!"
  "What a hog, to swallow a dog!"
  "Just opened her throat and swallowed a goat!"
  "I don't know how she swallowed a cow!"
  "She's dead, of course!"
)

start="$1"
end="$2"

(($# == 2)) || die "2 arguments expected"
((start <= end)) || die "Start must be less than or equal to End"

for ((i = start; i <= end; i++)); do
  build_stanza "$i"
  ((i < end)) && echo || :
done

