#!/usr/bin/env bash

encode() {
  local string="$1" rle
  local -i i count

  for ((i = 0; i < ${#string}; i++)); do
    count=1
    while [[ "${string:i:1}" == "${string:i+1:1}" ]]; do
      ((count++))
      ((i++))
    done

    if ((count == 1)); then
      rle+="${string:i:1}"
    else
      rle+="${count}${string:i:1}"
    fi
  done

  echo "$rle"
}

decode() {
  local rle="$1" string n
  local -i j
  
  for ((j = 0; j < ${#rle}; j++)); do
    n=""
    while [[ "${rle:j:1}" == [0-9] ]]; do
      n+="${rle:j:1}"
      ((j++))
    done

    while ((n > 0)); do
      string+="${rle:j:1}"
      ((n--))
    done

    if [[ -z "$n" ]]; then
      string+="${rle:j:1}"
    fi
  done

  echo "$string"
}

case "$1" in
  encode) encode "$2" ;;
  decode) decode "$2" ;;
esac
