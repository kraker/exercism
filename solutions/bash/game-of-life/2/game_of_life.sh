#!/usr/bin/env bash

# Reimplementation of @glennj's elegant solution:
# https://exercism.org/tracks/bash/exercises/game-of-life/solutions/glennj

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

  # Simulate 2D arrays with an associative arrays in bash
  declare -A cells neighbors

  local -i i j
  local row
  for ((i = 0; i < rows; i++)); do
    row="${input[i]}"
    for ((j = 0; j < cols; j++)); do
      cells["$i $j"]="${row:j:1}"

      # If a cell is equal to 1 then it increments its "neighbors"
      if ((${row:j:1} == 1)); then
        # Iterate over all neighbors:
        #   rows = [i -1, i, i + 1] = "delta i" and 
        #   cols = [j -1, j, j + 1] = "delta j"
        for di in {-1..1}; do
          ((ii = i + di))
          ((0 <= ii && ii < rows)) || continue
          for dj in {-1..1}; do
            ((di == 0 && dj == 0)) && continue  # Skip "C" from neighborhood
            ((jj = j + dj))
            ((0 <= jj && jj < cols)) || continue

            ((neighbors["$ii $jj"] += 1))
          done
        done
      fi
    done
  done

  for ((i = 0; i < rows; i++)); do
    for ((j = 0; j < cols; j++)); do
      case "${neighbors["$i $j"]}" in
        3) cells["$i $j"]=1 ;;
        2) : ;;
        *) cells["$i $j"]=0 ;;
      esac
      printf '%s' "${cells["$i $j"]}"
    done
    printf '\n'
  done
}

main "$@"
