#!/usr/bin/env bash

size="$1"
length="$((size * size))"

# Initialize with placeholders
declare -A spiral
for ((i = 0; i < size; i++)); do
  for ((j = 0; j < size; j++)); do
    spiral["$i $j"]="X"
  done
done

((n = 0))
((x = -1))
((y = 0))
((s = size))
# s is the length of that segment of the spiral, e.g:
#
# 1 2 3
# 8 9 4
# 7 6 5
#
# 123|45|67|8|9

while ((s >= 0)); do
  for side in {0..3}; do
    case $side in
      0)
        ((end = x + s))
        for ((j = x; j < end; j++)); do
          ((n++))
          ((x++))
          ((spiral["$y $x"] = n))
        done
        ((s--))
        ;;
      1)
        ((end = y + s))
        for ((i = y; i < end; i++)); do
          ((n++))
          ((y++))
          ((spiral["$y $x"] = n))
        done
        ;;
      2)
        ((end = x - s + 1))
        for ((j = x; j >= end; j--)); do
          ((n++))
          ((x--))
          ((spiral["$y $x"] = n))
        done
        ((s--))
        ;;
      3)
        ((end = y - s + 1))
        for ((i = y; i >= end; i--)); do
          ((n++))
          ((y--))
          ((spiral["$y $x"] = n))
        done
        ;;
    esac
  done
done

# print spiral
for ((i = 0; i < size; i++)); do
  for ((j = 0; j < size; j++)); do
    if ((j == 0)); then
      printf '%d' "${spiral["$i $j"]}"
    else
      printf '% d' "${spiral["$i $j"]}"
    fi
  done
  printf '\n'
done
