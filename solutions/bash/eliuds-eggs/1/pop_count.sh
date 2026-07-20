#!/usr/bin/env bash

eggs="$1"

declare -i count=0
while ((eggs > 0)); do
  ((eggs % 2 == 1)) && count+=1
  ((eggs >>= 1))
done

echo "$count"
