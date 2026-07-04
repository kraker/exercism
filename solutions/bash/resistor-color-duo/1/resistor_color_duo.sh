#!/usr/bin/env bash

colors=(
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
resistance=""

for color in $1 $2; do
  is_color=0

  for i in "${!colors[@]}"; do
    if [[ "$color" == "${colors[$i]}" ]]; then
      is_color=1
      resistance+=$i
    fi
  done

  ((is_color != 1)) && break
done

((is_color != 1)) && echo "invalid color" && exit 1 || echo "${resistance#0}"

