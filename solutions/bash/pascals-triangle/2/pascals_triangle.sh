#!/usr/bin/env bash


factorial() {
  local -i n="$1" i f=1
  for ((i = n; i > 0; i--)); do
    ((f *= i))
  done
  echo "$f"
}

# "n choose k": https://en.wikipedia.org/wiki/Pascal%27s_triangle#Formula
n_choose_k() {
  local -i n="$1" k="$2"
  local -i d=$((n - k))
  local -i p=$(( $(factorial $n) / ($(factorial $k) * $(factorial $d)) ))
  echo "$p"
}

declare -i rows="$1"

for ((n = 0, s = rows - 1; n < rows; n++, s--)); do
  row=()
  for ((k = 0; k <= n; k++)); do
    row+=("$(n_choose_k $n $k)")
  done
  printf '%*s' $s ""  # print leading spaces
  printf '%s\n' "${row[*]}"
done

