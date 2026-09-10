#!/usr/bin/env bash

main() {
  local -i num="$1"
  local -i len="${#1}"
  
  local -i sum=0
  for ((i = 0; i < len; i++)); do
    sum+=$(( ${num:i:1} ** len ))
  done

  ((num == sum)) && echo "true" || echo "false"
}

main "$@"
