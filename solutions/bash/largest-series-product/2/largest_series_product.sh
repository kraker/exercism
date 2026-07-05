#!/usr/bin/env bash

sequence="$1"
span="$2"

((span > ${#sequence} )) && {
  echo "span must not exceed string length" >&2
  exit 1
} || ((span < 1)) && {
  echo "span must not be negative" >&2
  exit 1
} || [[ "$sequence" =~ [a-zA-Z] ]] && {
  echo "digits input must only contain digits" >&2
  exit 1
}

for ((i = 0; i <= ${#sequence} - span; i++)); do
  product=1
  for ((j = 0; j < span; j++)); do
    ((product *= ${sequence:i+j:1}))
  done
  # Borrowed from @glennj's solution
  max=$((product > max ? product : max))
done

echo "$max"
