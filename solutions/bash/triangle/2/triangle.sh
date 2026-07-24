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

count=0
(( $(bc <<< "$a == $b") )) && ((count++))
(( $(bc <<< "$b == $c") )) && ((count++))
(( $(bc <<< "$a == $c") )) && ((count++))

case $triangle in
  equilateral) ((count == 3)) && echo "true" || echo "false" ;;
  isosceles)   ((count >= 1)) && echo "true" || echo "false" ;;
  scalene)     ((count == 0)) && echo "true" || echo "false" ;;
esac

