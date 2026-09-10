#!/usr/bin/env bash

declare -A RN=(
  [1000]=M
  [900]=CM
  [500]=D
  [400]=CD
  [100]=C
  [90]=XC
  [50]=L
  [40]=XL
  [10]=X
  [9]=IX
  [5]=V
  [4]=IV
  [1]=I
)

mods=(
  1000
  900
  500
  400
  100
  90
  50
  40
  10
  9
  5
  4
  1
)

str::multiply() {
  local s="$1" m
  local -i count="$2" i
  for ((i = 0; i < count; i++)); do
    m+="$s"
  done
  echo "$m"
}

n="$1"
r=""

for m in "${mods[@]}"; do
  if ((n >= m)); then
    c="$((n / m))"
    r+="$(str::multiply "${RN[$m]}" "$c")"
    ((n %= m))
  fi
done

echo "$r"
