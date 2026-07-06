#!/usr/bin/env bash

dna="${1^^}"

[[ "$dna" =~ [^GCTA] ]] && echo "Invalid nucleotide detected." >&2 && exit 1

for ((i = 0; i < ${#dna}; i++)); do
  case ${dna:i:1} in
    G)
      rna+="C" ;;
    C)
      rna+="G" ;;
    T)
      rna+="A" ;;
    A)
      rna+="U" ;;
  esac
done

echo "$rna"
