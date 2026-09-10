#!/usr/bin/env bash

codes=(
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

# Orders of magnitute in terms of metric prefix's
GIGA=9
MEGA=6
KILO=3

declare -i code=0 count=0
for value in "$3" "$2" "$1"; do
  for ((i = 0; i < ${#codes[@]}; i++)); do
    if [[ "$value" == "${codes[i]}" ]]; then
      code+=$((i > 0 ? i * (10 ** count) : 0))
      ((count++))
      break
    fi
  done
done

# If not all inputs are valid color codes then error exit
((count == 3)) || { echo "Invalid input" >&2; exit 1; }

resistance=$(( code > 0 ? ${code:0:-1} * (10 ** ${code: -1}) : 0))

if ((${#resistance} > GIGA)); then
  ((resistance /= 10 ** GIGA))
  echo "$resistance gigaohms"
elif ((${#resistance} > MEGA)); then
  ((resistance /= 10 ** MEGA))
  echo "$resistance megaohms"
elif ((${#resistance} > KILO)); then
  ((resistance /= 10 ** KILO))
  echo "$resistance kiloohms"
else
  echo "$resistance ohms"
fi
