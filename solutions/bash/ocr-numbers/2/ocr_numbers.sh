#!/usr/bin/env bash

#      _  _     _  _  _  _  _  _  #
#    | _| _||_||_ |_   ||_||_|| | # Decimal numbers.
#    ||_  _|  | _||_|  ||_| _||_| #
#                                 # The fourth line is always blank
#   1  2  3  4  5  6  7  8  9  0

## Variables ##
declare -A ocrs
ocrs[0]+=" _ "; ocrs[1]+="   "; ocrs[2]+=" _ "; ocrs[3]+=" _ "; ocrs[4]+="   "
ocrs[0]+="| |"; ocrs[1]+="  |"; ocrs[2]+=" _|"; ocrs[3]+=" _|"; ocrs[4]+="|_|"
ocrs[0]+="|_|"; ocrs[1]+="  |"; ocrs[2]+="|_ "; ocrs[3]+=" _|"; ocrs[4]+="  |"
ocrs[0]+="   "; ocrs[1]+="   "; ocrs[2]+="   "; ocrs[3]+="   "; ocrs[4]+="   "
ocrs[5]+=" _ "; ocrs[6]+=" _ "; ocrs[7]+=" _ "; ocrs[8]+=" _ "; ocrs[9]+=" _ "
ocrs[5]+="|_ "; ocrs[6]+="|_ "; ocrs[7]+="  |"; ocrs[8]+="|_|"; ocrs[9]+="|_|"
ocrs[5]+=" _|"; ocrs[6]+="|_|"; ocrs[7]+="  |"; ocrs[8]+="|_|"; ocrs[9]+=" _|"
ocrs[5]+="   "; ocrs[6]+="   "; ocrs[7]+="   "; ocrs[8]+="   "; ocrs[9]+="   "

## Functions ##
die() { echo "$*" >&2; exit 1; }

ocr_to_arabic() {
  local -n __lines="$1"

  local -i i j found
  local -a output
  local line0 line1 line2 line3 arabic

  for ((i = 0; i < ${#__lines[@]}; i += 4)); do
    line0="${__lines[i + 0]}"
    line1="${__lines[i + 1]}"
    line2="${__lines[i + 2]}"
    line3="${__lines[i + 3]}"
    arabic=""

    for ((j = 0; j < "${#line0}"; j += 3)); do
      ocr="${line0:j:3}${line1:j:3}${line2:j:3}${line3:j:3}"

      ((found = 0))
      for n in {0..9}; do
        if [[ "${ocrs[$n]}" == "$ocr" ]]; then
          arabic+="$n"
          ((found = 1))
        fi
      done

      if ((found == 0)); then
        arabic+="?"
      fi
    done

    output+=("$arabic")
  done

  if ((${#output[@]} > 1)); then
    IFS=','
    echo "${output[*]}"
    unset IFS
  else
    echo "${output[0]}"
  fi

}

## Main ##
main() {
  mapfile -t lines "$@"

  ((${#lines[@]} % 4 == 0)) ||
    die "Number of input lines is not a multiple of four"
  ((${#lines[0]} % 3 == 0)) ||
    die "Number of input columns is not a multiple of three"

  ocr_to_arabic lines
}

main "$@"
