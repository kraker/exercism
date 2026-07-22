#!/usr/bin/env bash

die() { echo "$*"; exit 1; }

IFS=','
read -ra w <<< "$2"
read -ra b <<< "$4"
unset IFS

((w[0] >= 0 && b[0] >= 0 ))       || die "row not positive"
((w[1] >= 0 && b[1] >= 0 ))       || die "column not positive"
((w[0] <  8 && b[0] <  8 ))       || die "row not on board"
((w[1] <  8 && b[1] <  8 ))       || die "column not on board"
((w[0] == b[0] && w[1] == b[1] )) && die "same position"

if   ((w[0] == b[0]));               then echo "true"  # same row
elif ((w[1] == b[1]));               then echo "true"  # same column
elif ((w[0] + w[1] == b[0] + b[1])); then echo "true"  # same diagonal
elif ((w[0] - w[1] == b[0] - b[1])); then echo "true"  # same diagnoal
else                                      echo "false"
fi

