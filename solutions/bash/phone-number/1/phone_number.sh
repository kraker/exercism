#!/usr/bin/env bash

die() { echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9" >&2; exit 1; }

# Strip out all non-numbers
number="${1//[^[:digit:]]/}"

# Number must be either 10 or 11 digits
((${#number} >= 10 && ${#number} <= 11)) || die

# If number is 11 digits long must use NANP country code "1"
if ((${#number} == 11 )); then
  ((${number:0:1} == 1)) || die
fi

# [1] NXX NXX-NXX, "N" must be 2-9. Count from end in case there's a country code
[[ ${number: -7:1}  =~ [2-9] ]] || die
[[ ${number: -10:1} =~ [2-9] ]] || die

echo "${number: -10}"
