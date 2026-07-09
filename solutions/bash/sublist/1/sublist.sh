#!/usr/bin/env bash

a="${1:1:-1},"
b="${2:1:-1},"

if [[ "$a" == "$b" ]]; then echo "equal"
elif [[ "$a" =~ $b ]]; then echo "superlist"
elif [[ "$b" =~ $a ]]; then echo "sublist"
else                        echo "unequal"
fi
