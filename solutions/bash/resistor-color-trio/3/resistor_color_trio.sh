#!/usr/bin/env bash

# NOTE: Reimplementation borrowing liberally from @glennj's and @isaacg's
# solutions.

COLORS=(
  "black"
  "brown"
  "red"
  "orange"
  "yellow"
  "green"
  "blue"
  "violet"
  "grey"
  "white"
)

UNITS=(ohms kiloohms megaohms gigaohms)

die() { echo "$*" >&2; exit 1; }

color_value() {
  local value
  for value in "${!COLORS[@]}"; do
    if [[ "$1" == "${COLORS[value]}" ]]; then
      echo "$value"
      return
    fi
  done
  return 1
}

resistance() {
  echo $(( (10 * $1 + $2) * 10 ** $3 ))
}

for color in "${@:1:3}"; do
  values+=("$(color_value "$color")") || die "unknown color: $color"
done

R="$(resistance "${values[@]}")"

scale=0
while ((R && R % 1000 == 0)); do
  ((R /= 1000, scale++))
done

echo "$R ${UNITS[scale]}"
