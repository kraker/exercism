#!/usr/bin/env bash

die() { echo "$*"; exit 1; }

abs() {
  local -i n="$1"
  ((n < 0)) && echo $((n * -1)) || echo $n
}

IFS=','
read -ra w <<< "$2"
read -ra b <<< "$4"
unset IFS

((w[0] >= 0 && b[0] >= 0))        || die "row not positive"
((w[1] >= 0 && b[1] >= 0))        || die "column not positive"
((w[0] <  8 && b[0] <  8))        || die "row not on board"
((w[1] <  8 && b[1] <  8))        || die "column not on board"
((w[0] == b[0] && w[1] == b[1] )) && die "same position"

# Calculating deltas is cleaner, borrowed idea from @glennj's solution
row_delta=$(abs $((w[0] - b[0])))
col_delta=$(abs $((w[1] - b[1])))

if ((row_delta == 0 || col_delta == 0 || row_delta == col_delta)); then
  echo "true"
else
  echo "false"
fi

