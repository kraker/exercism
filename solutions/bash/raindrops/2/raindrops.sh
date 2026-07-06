#!/usr/bin/env bash

num="$1"

((num % 3)) || rain+="Pling"
((num % 5)) || rain+="Plang"
((num % 7)) || rain+="Plong"

echo "${rain:-$num}"
