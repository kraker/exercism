#!/usr/bin/env bash

num="$1"

rain=""
((num % 3 == 0)) && rain+="Pling"
((num % 5 == 0)) && rain+="Plang"
((num % 7 == 0)) && rain+="Plong"
[[ -z "$rain" ]] && rain="$num"

echo "$rain"
