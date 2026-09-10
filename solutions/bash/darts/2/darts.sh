#!/usr/bin/env bash

die() {
  echo "Invalid coordinates" >&2 
  exit 1
}

# Must be exactly 2 params
(($# == 2)) || die

# Params must be real numbers (floating point ok)
for arg in $1 $2; do
  [[ $arg =~ ^[-.[:digit:]]+$ ]] || die
done

# NOTE: Since Bash doesn't really give us floating point arithmetic, calling bc
# is relatively idiomatic for basic calculations. But I acknowledge that this is
# not _pure_ Bash...

# Borrow bc here string "script" idea from @IsaacG
bc -l <<< "
  scale=4
  x=$1; y=$2; r=sqrt(x^2 + y^2)
  if (r <= 1)       10\
  else if (r <= 5)  5 \
  else if (r <= 10) 1 \
  else              0 
"
