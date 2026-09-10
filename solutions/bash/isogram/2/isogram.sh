#!/usr/bin/env bash

# NOTE: Reimplementation of @glennj's much more clever solution.

unset {a..z}

STRING="$1"

declare -l char # lower case
while IFS= read -r -n1 char; do
  if [[ -n ${!char} ]]; then
    echo "false"
    exit 0
  fi
  declare "${char}=seen"
done < <(echo -n "${STRING//[^[:alpha:]]/}")

echo "true"
