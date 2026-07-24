#!/usr/bin/env bash

# NOTE: Bash doesn't handle floats so need to use something else like 'bc'.

die() { echo "$*"; exit 0; }

triangle="$1"
shift

# sides
a="$1"
b="$2"
c="$3"

# Any 0 length side is not a triangle
for side in $a $b $c; do
  (( $(bc <<< "$side > 0") )) || die "false"
done

# Can't be "degenerate"
(( $(bc <<< "$a + $b >= $c") )) || die "false"
(( $(bc <<< "$b + $c >= $a") )) || die "false"
(( $(bc <<< "$a + $c >= $b") )) || die "false"

case $triangle in
  equilateral)
    (( $(bc <<< "$a == $b && $b == $c") )) &&
      echo "true" || echo "false"
    ;;
  isosceles)
    (( $(bc <<< "$a == $b || $b == $c || $a == $c") )) &&
      echo "true" || echo "false"
    ;;
  scalene)
    (( $(bc <<< "$a != $b && $b != $c && $a != $c") )) &&
      echo "true" || echo "false"
    ;;
esac

