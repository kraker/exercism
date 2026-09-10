#!/usr/bin/env bash

things=("$@")

(($# > 0)) || exit 0

for ((i = 0; i < ${#things[@]} - 1; i++)); do
  echo "For want of a ${things[i]} the ${things[i + 1]} was lost."
done

echo "And all for the want of a ${things[0]}."
