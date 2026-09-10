#!/usr/bin/env bash

# Reimplement baseed on glennj's solution; seems more idiomatic

COLORS=(
  black
  brown
  red
  orange
  yellow
  green
  blue
  violet
  grey
  white
)

color_value() {
  for index in "${!COLORS[@]}" ; do
    [[ "${COLORS[$index]}" == "$1" ]] && echo "$index" && return
  done
}

case "$1" in
  code) color_value "$2" ;;
  colors) printf '%s\n' "${COLORS[@]}" ;;
esac
