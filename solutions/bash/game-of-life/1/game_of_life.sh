#!/usr/bin/env bash

main() {
  local -a input output
  read -ra input <<< "$@"

  # Borrowing the "neighborhood" idea from my "Flower Field" solution:
  # https://exercism.org/tracks/bash/exercises/flower-field/solutions/kraker
  #
  # Relates to "Moore neighborhood"
  # https://en.wikipedia.org/wiki/Moore_neighborhood
  # 
  # NW N NE
  # W  C  E
  # SW S SE
  #
  # Each neighborhood is 9 cells with a central cell "C" and the 8 cells
  # surrounding it as shown above.

  local -i rows="${#input[@]}"
  local -i cols="${#input[0]}"
  local -i i j count c
  local row_n row_c row_s

  # Loop over each row and count surrounding cells, if conditions for life
  # are found, cell lives another iteration, otherwise it dies.
  for ((i = 0; i < rows; i++)); do
    row_n="${input[i - 1]}"  # row_n = nw n ne (north)
    row_c="${input[i + 0]}"  # row_c = w  c  e (central)
    row_s="${input[i + 1]}"  # row_s = sw s se (south)

    for ((j = 0; j < cols; j++)); do
      count=0
      if ((j > 0)); then
        if ((i > 0)); then
          ((${row_n:j - 1:1} == 1)) && ((count++))  # NW
        fi
        ((${row_c:j - 1:1} == 1))   && ((count++))  # W
        if ((i < rows - 1)); then
          ((${row_s:j - 1:1} == 1)) && ((count++))  # SW
        fi
      fi
      if ((i > 0)); then
        ((${row_n:j:1} == 1))       && ((count++))  # N
      fi
      c="${row_c:j:1}"                              # C
      if ((i < rows - 1)); then
        ((${row_s:j:1} == 1))       && ((count++))  # S
      fi
      if ((j < cols - 1)); then
        if ((i > 0)); then
          ((${row_n:j + 1:1} == 1)) && ((count++))  # NE
        fi
        ((${row_c:j + 1:1} == 1))   && ((count++))  # E
        if ((i < rows - 1)); then
          ((${row_s:j + 1:1} == 1)) && ((count++))  # SE
        fi
      fi

      if ((c == 1)) && ((count == 2 || count == 3)); then
        output[i]+="1"
      elif ((c == 0)) && ((count == 3)); then
        output[i]+="1"
      else
        output[i]+="0"
      fi
    done
  done

  printf '%s\n' "${output[@]}"
}

main "$@"
