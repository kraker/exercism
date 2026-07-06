#!/usr/bin/env bash

string="${1,,}"
alphabet=(a b c d e f g h i j k l m n o p q r s t u v w x y z)

count=0
for letter in "${alphabet[@]}"; do
  [[ "$string" =~ $letter ]] && ((count += 1))
done

((count == 26)) && echo "true" || echo "false"
