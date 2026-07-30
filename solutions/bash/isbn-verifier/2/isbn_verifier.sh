#!/usr/bin/env bash

die() { echo "$*"; exit 0; }

ISBN="${1//-/}"

[[ "$ISBN" =~ ^[0-9]{9}[0-9X]$ ]] || die "false"

sum=0
for ((i = 0, j = 10; i < 10; i++, j--)); do
  n="${ISBN:i:1}"
  [[ "$n" == "X" ]] && n=10
  ((sum += n * j))
done

(( sum % 11 == 0 )) && die true || die false
