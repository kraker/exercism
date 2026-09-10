#!/usr/bin/env bash

year="$1"

usage() {
  echo "Usage: ${0##*/} <year>" >&2
  exit 1
}

(($# != 1))               && usage  # exactly 1 arg
[[ "$year" =~ \.+ ]]      && usage  # no floating point nums
[[ "$year" =~ [a-zA-Z] ]] && usage  # input must be number

((year % 4 == 0 && year % 100 != 0 || year % 400 == 0)) &&
  echo "true" || echo "false"
