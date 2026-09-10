#!/usr/bin/env bash

string="$1"
length="${#string}"

for ((i = 1; i <= length; i++)); do
  echo -n "${string: -i:1}"
done
echo

