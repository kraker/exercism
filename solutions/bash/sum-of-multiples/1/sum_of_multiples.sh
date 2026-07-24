#!/usr/bin/env bash

level="$1"
shift

declare -a points
for item in "$@"; do
  ((item > 0)) || continue
  for ((i = $item; i < $level; i += $item)); do
    points[i]=$i
  done
done

sum=0
for point in "${points[@]}"; do
  ((sum += point))
done

echo "$sum"
