#!/usr/bin/env bash

reversed=""

for ((i = 1; i <= ${#1}; i++)); do
  reversed+="${1: -i:1}"
done

printf '%s\n' "${reversed}"

