#!/usr/bin/env bash

die() { echo "$*"; exit 0; }

ISBN="${1//-/}"

(( ${#ISBN} == 10 )) || die "false"
[[ "${ISBN: -1}" =~ [X[:digit:]] ]] || die "false"

sum=0
for ((i = 0, j = 10; i < 10; i++, j--)); do
  n="${ISBN:i:1}"
  [[ "$i" == "9" && "$n" == "X" ]] && n=10
  [[ "$n" =~ [[:digit:]] ]] || die "false"
  ((sum += n * j))
done

(( sum % 11 == 0 )) && die true
die false
