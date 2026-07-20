#!/usr/bin/env bash

eggs="$1"

declare -i count=0
while ((eggs > 0)); do
  ((eggs & 1)) && ((count++))
  ((eggs >>= 1))
done

echo "$count"
