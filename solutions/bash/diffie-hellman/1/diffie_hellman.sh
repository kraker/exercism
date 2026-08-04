#!/usr/bin/env bash

# Generate psuedorandom number in range 1 to max non-inclusive
privateKey() {
  local -i max="$1"
  echo "$(( (RANDOM % (max - 2)) + 2))"
}

publicKey() {
  local p="$1" g="$2" pk="$3"
  bc -l <<< "scale=0; $g^$pk % $p"
}

secret() {
  local p="$1" k="$2" pk="$3"
  bc -l <<< "scale=0; $k^$pk % $p"
}

case $1 in
  privateKey) privateKey "$2" ;;
  publicKey) publicKey "$2" "$3" "$4" ;;
  secret) secret "$2" "$3" "$4" ;;
esac
