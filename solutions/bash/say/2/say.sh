#!/usr/bin/env bash

declare -a ones teens tens magnitudes say

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

(( thousand = 10**3 ))
(( million  = 10**6 ))
(( billion  = 10**9 ))
(( trillion = 10**12 ))

magnitudes=(
  [thousand]=thousand
  [million]=million
  [billion]=billion
  [trillion]=trillion
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
  local -i n="$1" m mag

  ((n >= 0 && n < trillion )) || die "input out of range"

  if ((n == 0)); then
    echo "${ones[$n]}"
    exit 0
  fi

  for mag in $billion $million $thousand; do
    if ((n >= mag)); then
      ((m = n / mag))
      says "$m"
      say+=( "${magnitudes[$mag]}")
      ((n %= mag))
    fi
  done

  if ((n > 0)); then
    says "$n"
  fi

  echo "${say[@]}"
}

main "$@"
