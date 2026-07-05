#!/usr/bin/env bash

name="$1"
num="$2"

# Slightly more efficient to calculate once per
ones=$((num % 10))
tens=$((num % 100))

suffix="th"
((ones == 1 && tens != 11)) && suffix="st"
((ones == 2 && tens != 12)) && suffix="nd"
((ones == 3 && tens != 13)) && suffix="rd"

echo "${name}, you are the ${num}${suffix} customer we serve today. Thank you!"
