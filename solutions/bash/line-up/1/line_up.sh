#!/usr/bin/env bash

name="$1"
num="$2"

suffix="th"
((num % 10 == 1 && num % 100 != 11)) && suffix="st"
((num % 10 == 2 && num % 100 != 12)) && suffix="nd"
((num % 10 == 3 && num % 100 != 13)) && suffix="rd"

echo "${name}, you are the ${num}${suffix} customer we serve today. Thank you!"
