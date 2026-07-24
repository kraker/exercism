#!/usr/bin/env bash

n="$1"

# Basic ascending linear search
# https://en.wikipedia.org/wiki/Integer_square_root#Algorithm_using_linear_search
l=0
while (( (l + 1) * (l + 1) <= n )); do
  ((l += 1))
done

((l * l == n)) && echo "$l" || echo "Integer square root not found."
