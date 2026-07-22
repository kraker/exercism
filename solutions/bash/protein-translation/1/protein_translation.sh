#!/usr/bin/env bash

declare -A aminos=(
  [methionine]="AUG"
  [phenylalanine]="UUU UUC"
  [leucine]="UUA UUG"
  [serine]="UCU UCC UCA UCG"
  [tyrosine]="UAU UAC"
  [cysteine]="UGU UGC"
  [tryptophan]="UGG"
  [stop]="UAA UAG UGA"
)

die() { echo "Invalid codon" >&2; exit 1; }

sequence="$1"

for ((i = 0; i < ${#sequence}; i += 3)); do
  match=0
  for amino in "${!aminos[@]}"; do
    for codon in ${aminos[$amino]}; do
      if [[ "${sequence:i:3}" == "$codon" ]]; then
	if [[ "$amino" == "stop" ]]; then
	  break 3
	else
          translation+=("$amino")
          (( match++ ))
	fi
      fi
    done
  done
  ((match > 0)) || die
done

echo "${translation[@]^}"
