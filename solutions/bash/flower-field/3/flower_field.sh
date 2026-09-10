#!/usr/bin/env bash

field=("$@")
rows="${#field[@]}"
cols="${#field[0]}"

#   [ij]
#      0  1  2  3 
#   0  00 01 02 03 
#   1  10 11 12 13
#   2  20 21 22 23
#   3  30 31 32 33

# build sorta 2d array
declare -A graph
for ((i = 0; i < rows; i++)); do
  row="${field[$i]}"
  for ((j = 0; j < cols; j++)); do
    c="${row:j:1}"
    [[ "$c" == "*" ]] || c=0
    graph["${i},${j}"]="$c"
  done
done

# Relates to "Moore neighborhood"?
# https://en.wikipedia.org/wiki/Moore_neighborhood
# 
# NW N NE
# W  C  E
# SW S SE
#
# Each neighborhood is 9 cells with a central cell "C" and the 8 cells
# surrounding it as shown above.
#
# If C is "*" and if the adjacent are not "*" then they are incremented by 1.
# After all flowers "*" are found each of the adjacent cells have a final count.

for ((i = 0; i < rows; i++)); do
  for ((j = 0; j < cols; j++)); do
    c="$i,$j"
    [[ "${graph[$c]}" == "*" ]] || continue

    # Build indexes [ab] of surrounding cells.
    if ((i - 1 >= 0))
    then
      ((j - 1 >= 0))   && nw="$((i - 1)),$((j - 1))"
                           n="$((i - 1)),${j}"
      ((j + 1 < cols)) && ne="$((i - 1)),$((j + 1))"
    fi
    ((j - 1 >= 0 ))    &&  w="${i},$((j - 1))"
    ((j + 1 < cols))   &&  e="${i},$((j + 1))"
    if ((i + 1 < rows))
    then
      ((j - 1 >= 0))   && sw="$((i + 1)),$((j - 1))"
                           s="$((i + 1)),${j}"
      ((j + 1 < cols)) && se="$((i + 1)),$((j + 1))"
    fi

    for d in $nw $n $ne $w $e $sw $s $se; do
      if [[ "${graph[$d]}" != "*" ]]; then
        ((graph[$d] += 1))
      fi
    done

    unset nw n ne w c e sw s se
  done
done

# Print graph
for ((i = 0; i < rows; i++)); do
  for ((j = 0; j < cols; j++)); do
    if [[ "${graph["$i,$j"]}" == "0" ]]; then
      printf '%s' " "
    else
      printf '%s' "${graph["$i,$j"]}"
    fi
  done
  printf '\n'
done
