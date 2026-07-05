#!/usr/bin/env bash

year="$1"

err() {
  echo "Usage: ${0##*/} <year>" >&2
  exit 1
}

(($# != 1))               && err  # exactly 1 arg
[[ "$year" =~ \.+ ]]      && err  # no floating point nums
[[ "$year" =~ [a-zA-Z] ]] && err  # input must be number

((year % 4 == 0 && year % 100 != 0 || year % 400 == 0)) &&
  echo "true" || echo "false"
