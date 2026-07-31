#!/usr/bin/env bash

die() { echo "false"; exit 0; }

number="${1// /}"

((${#number} > 1)) || die

for ((i = 1; i <= ${#number}; i++)); do
  n="${number: -i:1}"
  [[ "$n" =~ [0-9] ]] || die
  if ((i % 2 == 0)); then
    ((n *= 2))
    ((n > 9)) && ((n -= 9))
  fi
  ((sum += n))
done

((sum % 10 == 0)) && echo "true" || echo "false"
