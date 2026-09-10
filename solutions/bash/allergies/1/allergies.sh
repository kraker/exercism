#!/usr/bin/env bash

# Not the most elegant solution, but it works...

declare -i SCORE="${1:?}"
OUTPUT_TYPE="${2:?}"
ALLERGY="$3"

list=(eggs peanuts shellfish strawberries tomatoes chocolate pollen cats)

declare -A allergies
for index in "${!list[@]}"; do
  allergy="${list[$index]}"
  allergies["$allergy"]=$((2 ** index))
done

if [[ "$OUTPUT_TYPE" == "allergic_to" ]]; then
  ((SCORE & ${allergies[$ALLERGY]})) && echo "true" || echo "false"
  exit 0
fi

if [[ "$OUTPUT_TYPE" == "list" ]]; then
  for allergy in "${list[@]}"; do
    ((SCORE & ${allergies[$allergy]})) && echo -n "$allergy "
  done | sed 's/\s*$//'  # trim trailing whitespace, not pure bash :(
  echo
fi

