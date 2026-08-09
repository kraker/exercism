#!/usr/bin/env bash

billion=1000000000
million=1000000
thousand=1000

declare -a ones teens tens say

ones=(
  zero
  one
  two
  three
  four
  five
  six
  seven
  eight
  nine
)

teens=(
  [10]=ten
  [11]=eleven
  [12]=twelve
  [13]=thirteen
  [14]=fourteen
  [15]=fifteen
  [16]=sixteen
  [17]=seventeen
  [18]=eighteen
  [19]=nineteen
)

tens=(
  [20]=twenty
  [30]=thirty
  [40]=forty
  [50]=fifty
  [60]=sixty
  [70]=seventy
  [80]=eighty
  [90]=ninety
)

die() { echo "$*" >&2; exit 1; }

says() {
  local n="$1" n1 n10 n100

  case "$n" in
    [0-9])    say+=( "${ones[$n]}" )  ;;
    [1][0-9]) say+=( "${teens[$n]}" ) ;;
    [2-9][0]) say+=( "${tens[$n]}" )  ;;
    [2-9][1-9])
      n10="${n:0:1}0"
      n1="${n:1:1}"
      say+=( "${tens[$n10]}-${ones[$n1]}" )
      ;;
    [1-9][0-9][0-9])
      n100="${n:0:1}"
      n10="${n:1}"
      say+=( "${ones[$n100]} hundred" )
      ((n10 > 0)) && says "$n10"
      ;;
  esac
}

main() {
  local -i n="$1" m

  ((n < 999999999999 && n >= 0)) || die "input out of range"

  if ((n == 0)); then
    echo "${ones[$n]}"
    exit 0
  fi
  if ((n >= billion)); then
    ((m = n / billion))
    says "$m"
    say+=( "billion" )
    ((n %= billion))
  fi
  if ((n >= million)); then
    ((m = n / million))
    says "$m"
    say+=( "million" )
    ((n %= million))
  fi
  if ((n >= thousand)); then
    ((m = n / thousand))
    says "$m"
    say+=( "thousand" )
    ((n %= thousand))
  fi
  if ((n > 0)); then
    says "$n"
  fi

  echo "${say[@]}"
}

main "$@"
