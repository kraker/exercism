#!/usr/bin/env bash

die() {
  echo "Invalid coordinates" >&2 
  exit 1
}

radius() {
  local x="$1"
  local y="$2"

  bc -l <<< "scale=2; sqrt($x^2 + $y^2)"
}

# Must be exactly 2 params
(($# == 2)) || die

# Params must be real numbers (floating point ok)
for arg in $1 $2; do
  [[ $arg =~ ^[-\.[:digit:]]+$ ]] || die
done

RADIUS=$(radius "$1" "$2")

if (( $(bc <<< "$RADIUS >= 0") && $(bc <<< "$RADIUS <= 1") )); then
  POINTS=10
elif (( $(bc <<< "$RADIUS <= 5") )); then
  POINTS=5
elif (( $(bc <<< "$RADIUS <= 10") )); then
  POINTS=1
else
  POINTS=0
fi

echo "$POINTS"
