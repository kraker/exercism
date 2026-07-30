#!/usr/bin/env bash

# Nothing found in empty array
(($# > 1)) || { echo "-1"; exit 0; }

title="$1"
songs=( "${@:2}" )

if ((${#songs[@]} % 2 == 0)); then
  ((segment = ${#songs[@]} / 2))
else
  ((segment = (${#songs[@]} + 1) / 2))
fi

index="$((segment - 1))"
while ((title != songs[index] && segment > 0)); do
  (( segment /= 2 ))
  if ((title < songs[index])); then
    ((index -= segment))
  elif ((title > songs[index])); then
    ((index += segment))
  fi
done

if ((title == songs[index])); then
  echo "$index"
else
  echo "-1"
fi

