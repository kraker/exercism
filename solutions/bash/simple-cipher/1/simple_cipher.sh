#!/usr/bin/env bash

alphabet=({a..z})

die() { echo "$*" >&2; exit 1; }

# Psuedorandom number in range [a,b)
# $RANDOM is bash func that returns pseudorandom int 0 - 32767.
# See also: https://tldp.org/LDP/abs/html/randomvar.html
rand() {
  local -i a="$1" b="$2"
  echo $(( (RANDOM % (b - a)) + a ))
}

generate_key() {
  local -i length="${1:-100}" i
  local rc key

  for ((i = 0; i < length; i++)); do
    rc=$(rand "0" "26")
    key+="${alphabet[$rc]}"
  done
  echo "$key"
}

# Get indice of letter in alphabet, e.g. a=0
letter_indice() {
  local char="$1"
  local -i j

  for ((j = 0; j < 26; j++)); do
    if [[ "$char" == "${alphabet[j]}" ]]; then
      echo "$j"
      return
    fi
  done

  return 1
}

# Convert key to array of rotation distances, e.g. "abc" to "[0, 1, 2]"
key_to_rot_array() {
  local    _key="$1"
  local -n _rot="$2" # namref to array of rotation distances
  _rot=()            # Initialize as an empty array

  local    c
  local -i i
  for ((i = 0; i < ${#_key}; i++)); do
    c="${_key:i:1}"
    _rot+=( "$(letter_indice "$c")" )
  done
}

encode() {
  local    key="$1" message="$2"
  local    code
  local -a rot

  key_to_rot_array "$key" rot

  local    m
  local -i i r ci mi ri
  for ((i = 0; i < ${#message}; i++)); do
    m="${message:i:1}"        # letter from message
    mi=$(letter_indice "$m")  # indice of letter in alphabet
    (( ri = i % ${#rot[@]} )) # indice of rotation array
    r="${rot[ri]}"            # rotation (or shift) distance
    (( ci = (mi + r) % 26 ))  # shift or rotate letter by distance "r"
    code+="${alphabet[ci]}"   # add letter to cipher
  done

  echo "$code"
}

decode() {
  local    key="$1" code="$2"
  local    message
  local -a rot

  key_to_rot_array "$key" rot

  local    c
  local -i i r ci mi ri
  for ((i = 0; i < ${#code}; i++)); do
    c="${code:i:1}"                # letter from code
    ci=$(letter_indice "$c")       # indice of letter in alphabet
    (( ri = i % ${#rot[@]} ))      # indice of rotation array
    r="${rot[ri]}"                 # rotation (or shift) distance
    (( mi = (ci - r) % 26 ))       # shift or rotate letter by distance "-r"
    (( mi < 0 )) && (( mi += 26 )) # If less than 0, wrap around
    message+="${alphabet[mi]}"     # add letter to message
  done
  echo "$message"
}

main() {
  local key
  local opt OPTIND OPTARG

  while getopts "k:" opt; do
    case "$opt" in
      k)
        key="${OPTARG}"
        [[ "$key" =~ ^[a-z]+$ ]] || die "invalid key"
        ;;
      *) echo "Unknown option" >&2 ;;
    esac
  done
  shift $((OPTIND - 1))

  case "$1" in
    key) generate_key ;;
    encode) encode "$key" "${2,,}" ;;
    decode) decode "$key" "${2,,}" ;;
  esac
}

main "$@"
