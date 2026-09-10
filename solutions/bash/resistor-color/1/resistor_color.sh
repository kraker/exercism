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

[[ "$1" == "colors" ]] && printf '%s\n' "${colors[@]}" && exit 0
[[ "$1" == "code" ]] && color="$2"

for ((i = 0; i < ${#colors[@]}; i++)); do
  [[ "${colors[$i]}" == "$color" ]] && echo "$i" && break
done

