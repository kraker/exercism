#!/usr/bin/env bash

num="$1"

((num > 0)) || { echo "Error: Only positive integers are allowed" >&2; exit 1; }

declare -i steps=0
while ((num != 1)); do
  ((num % 2 == 0)) && ((num /= 2)) || ((num = num * 3 + 1))
  steps+=1
done

echo "$steps"
