#!/usr/bin/env bash

declare -A romans=(
  [1000]=M
  [500]=D
  [100]=C
  [50]=L
  [10]=X
  [5]=V
  [1]=I
)

str::multiply() {
  local s="$1" m
  local -i count="$2" i
  for ((i = 0; i < count; i++)); do
    m+="$s"
  done
  echo "$m"
}

n="$1"

r=""
if ((n >= 1000)); then
  c="$((n / 1000))"
  r+="$(str::multiply "M" "$c")"
  ((n %= 1000))
fi
if ((n >= 900)); then
  r+="CM"
  ((n -= 900))
fi
if ((n >= 500)); then
  r+="D"
  ((n -= 500))
fi
if ((n >= 400)); then
  r+="CD"
  ((n -= 400))
fi
if ((n >= 100)); then
  c="$((n / 100))"
  r+="$(str::multiply "C" "$c")"
  ((n %= 100))
fi
if ((n >= 90)); then
  r+="XC"
  ((n -= 90))
fi
if ((n >= 50)); then
  r+="L"
  ((n -= 50))
fi
if ((n >= 40)); then
  r+="XL"
  ((n -= 40))
fi
if ((n >= 10)); then
  c="$((n / 10))"
  r+="$(str::multiply "X" "$c")"
  ((n %= 10))
fi
if ((n == 9)); then
  r+="IX"
  ((n -= 9))
fi
if ((n >= 5)); then
  r+="V"
  ((n -= 5))
fi
if ((n == 4)); then
  r+="IV"
  ((n -= 4))
fi
if ((n >= 1)); then
  r+="$(str::multiply "I" "$n")"
  ((n %= n))
fi

echo "$r"

