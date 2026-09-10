#!/usr/bin/env bash

usage() {
  echo "Usage: ${0##*/} <year>" >&2
  exit 1
}

is_leap() {
 (($1 % 4 == 0 && $1 % 100 != 0 || $1 % 400 == 0))
}

(($# != 1))                && usage  # exactly 1 arg
[[ "$1" =~ [^[:digit:]] ]] && usage  # input must be integer number

is_leap "$1" && echo "true" || echo "false"
