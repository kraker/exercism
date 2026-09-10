#!/usr/bin/env bash

# Nothing found in empty array
(($# > 1)) || { echo "-1"; exit 0; }

title="$1"
songs=("${@:2}")

# NOTE: More faithful implementation of binary search algorithm.
# https://en.wikipedia.org/wiki/Binary_search
L=0                        # Left
R=$((${#songs[@]} - 1))    # Right
while ((L <= R)); do
  m=$((L + ((R - L) / 2))) # midpoint
  if ((songs[m] < title)); then
    L=$((m + 1))
  elif ((songs[m] > title)); then
    R=$((m - 1))
  else
    break
  fi
done

((songs[m] == title)) && echo "$m" || echo "-1"

