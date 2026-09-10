#!/usr/bin/env bash

square_of_sum() {
  local -i num="$1"
  local -i sum=0

  for ((i = 1; i <= num; i++)); do
    sum+=i
  done

  echo $(( sum ** 2 ))
}

sum_of_squares() {
  local -i num="$1"
  local -i sq_sum=0

  for ((i = 1; i <= num; i++)); do
    sq_sum+=$(( i ** 2 ))
  done

  echo "$sq_sum"
}

difference() {
  local -i num="$1"
  echo $(( $(square_of_sum $num) - $(sum_of_squares $num) ))
}

"$1" "$2"
