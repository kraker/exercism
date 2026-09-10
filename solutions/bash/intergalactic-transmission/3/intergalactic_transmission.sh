#!/usr/bin/env bash

die() { echo "$*"; exit 0; }

hex_to_bits() {
  local -a hexes; read -ra hexes <<< "$1"
  local -i hex
  local bits

  for hex in "${hexes[@]}"; do
    bit=$(bc <<< "obase=2; $hex")
    bits+="$(printf '%08d' "$bit")"
  done

  echo "$bits"
}

parity_bit() {
  local bits="${1//0/}"
  echo "$(( ${#bits} % 2 ))"
}

transmit_sequence() {
  local -a sequence
  local -i i dl pb n
  local bits chunk byte

  bits="$(hex_to_bits "$1")"

  for ((i = 0; i < ${#bits}; i += 7)); do
    chunk="${bits:i:7}"
    dl="$((8 - ${#chunk}))"     # delta length, determine 0 pad for parity bit
    pb="$(parity_bit "$chunk")" # parity bit
  
    byte="${chunk}$(printf '%0*d' $dl "$pb")"
    
    n=$(bc <<< "ibase=2; $byte")
    sequence+=( "$(printf '0x%02x' "$n")" )
  done

  echo "${sequence[@]}"
}

decode_message() {
  local bits byte message
  local -a sequence
  local -i i j pb n
  

  bits="$(hex_to_bits "$1")"

  for ((i = 0; i < ${#bits}; i += 8)); do
    byte="${bits:i:8}"
    pb="$(parity_bit "$byte")"

    ((pb == 0)) || die "wrong parity" 

    # Strip out parity bits
    message+="${byte:0:-1}"
  done

  for ((j = 0; j <= ${#message} - 8; j += 8)); do
    byte="${message:j:8}"
    n=$(bc <<< "ibase=2; $byte")
    sequence+=( "$(printf '0x%02x' "$n")" )
  done

  echo "${sequence[@]}"
}

"$1" "$2"
