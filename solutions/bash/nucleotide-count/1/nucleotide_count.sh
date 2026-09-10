#!/usr/bin/env bash

invalid() { echo "Invalid nucleotide in strand" >&2; exit 1; }

declare -i A=0 C=0 G=0 T=0

strand="$1"

for ((i = 0; i < ${#strand}; i++)); do
  nucleotide="${strand:i:1}"
  case $nucleotide in
    A) A+=1 ;; 
    C) C+=1 ;;
    G) G+=1 ;;
    T) T+=1 ;;
    *) invalid ;;
  esac
done

printf '%s\n' "A: $A" "C: $C" "G: $G" "T: $T"
