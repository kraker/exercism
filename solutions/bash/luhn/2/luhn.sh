#!/usr/bin/env bash

die() { echo "false"; exit 0; }

number="${1// /}"

((${#number} > 1)) || die
[[ "$number" =~ ^[0-9]+$ ]] || die

for ((i = ${#number} - 1, d = 0; i >= 0; i--, d = !d)); do
  n="${number:i:1}"
  if (( d )); then
    ((n *= 2))
    ((n > 9)) && ((n -= 9))
  fi
  ((sum += n))
done

((sum % 10 == 0)) && echo "true" || echo "false"
