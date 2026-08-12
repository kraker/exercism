#!/usr/bin/env bash

longest() {
  local -n _lines="$1"
  local    line
  local -i _longest=0

  for line in "${_lines[@]}"; do
    if ((${#line} > _longest)); then
      ((_longest = ${#line}))
    fi
  done
  echo "$_longest"
}

main() {
  local -a lines; mapfile -t lines "$@"
  local -i longest=$(longest lines)     # longest line
  local -i llines="${#lines[@]}"        # length lines


  # abc__  aaaAA
  # abcde  bb_B
  # a_     cc
  # AB     _d
  # A      _e
  #
  # Pad shorter lines with spaces if there are longer lines after it
  local -i length next_longest
  local    line
  local -a lines_left
  for ((i = 0; i < llines; i++)); do
    line="${lines[$i]}"
    length="${#line}"

    # Shorter lines need to always be padded with spaces so they equal the
    # length of the next longest line to come.
    lines_left=( "${lines[@]:i:llines - i}" )
    next_longest=$(longest lines_left)
    if ((length < next_longest)); then
      lines[i]+=$(printf '%*s' $((next_longest - length)) ' ')
    fi
  done

  local -i j
  for ((j =0; j < longest; j++)); do
    for line in "${lines[@]}"; do
      printf '%s' "${line:j:1}"
    done
    printf "\n"
  done
}

main "$@"
