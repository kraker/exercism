#!/usr/bin/env bash

sequence="$1"
span="$2"

((span > ${#sequence} )) && {
  echo "span must not exceed string length" >&2
  exit 1
} || ((span < 1)) && {
  echo "span must not be negative" >&2
  exit 1
} || [[ "$sequence" =~ [a-zA-Z] ]] && {
  echo "digits input must only contain digits" >&2
  exit 1
}

declare -a products
for ((i = 0; i < ${#sequence} - span + 1; i++)); do
  series="${sequence:$i:$span}"

  declare -i product=1
  for ((j = 0; j < span; j++)); do
    ((product *= ${series:j:1}))
  done
    
  products+=($product)
done

#echo "${products[@]}"
IFS=$'\n' sorted=($(sort -n <<< "${products[*]}"))
unset IFS
echo "${sorted[-1]}"
