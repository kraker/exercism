#!/usr/bin/env bash

dna="$1"

[[ "$dna" =~ [^GCTA] ]] && echo "Invalid nucleotide detected." >&2 && exit 1

for ((i = 0; i < ${#dna}; i++)); do
  [[ "${dna:$i:1}" == "G" ]] && rna+="C"
  [[ "${dna:$i:1}" == "C" ]] && rna+="G"
  [[ "${dna:$i:1}" == "T" ]] && rna+="A"
  [[ "${dna:$i:1}" == "A" ]] && rna+="U"
done

echo "$rna"
