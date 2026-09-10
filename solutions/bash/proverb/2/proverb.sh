#!/usr/bin/env bash

things=("$@")

(($# > 0)) || exit 0

for ((i = 0, j = 1; j < ${#things[@]}; i++, j++)); do
  echo "For want of a ${things[i]} the ${things[j]} was lost."
done

echo "And all for the want of a ${things[0]}."
