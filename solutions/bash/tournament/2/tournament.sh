#!/usr/bin/env bash

# NOTE: This iteration borrows a lot of ideas from @glennj's solution which
# cleverly dedups the teams list using associative arrays.

# NOTE: External dependencies: sort

# aarray deduplicates keys which allows us to deduplicate list of teams
declare -A TEAMS WIN LOSS DRAW

main() {
  # Print header
  printf '%-30s | %2s | %2s | %2s | %2s | %2s\n' \
    "Team" \
    "MP" \
    "W" \
    "D" \
    "L" \
    "P"

  local t1 t2 r team
  while IFS=';' read -r t1 t2 r; do
    # If no input, exit
    [[ -z "$t1" ]] && exit

    # Initialize aarray values
    for team in "$t1" "$t2"; do
      if [[ ! -v TEAMS[$team] ]]; then
        TEAMS[$team]=1
        WIN[$team]=0
        LOSS[$team]=0
        DRAW[$team]=0
      fi
    done

    case "$r" in
      win)  ((  WIN[$t1]++ , LOSS[$t2]++ )) ;;
      loss) (( LOSS[$t1]++ ,  WIN[$t2]++ )) ;;
      draw) (( DRAW[$t1]++ , DRAW[$t2]++ )) ;;
    esac
  done

  local -i matches points
  for team in "${!TEAMS[@]}"; do
    (( matches = WIN[$team] + DRAW[$team] + LOSS[$team] ))
    (( points = WIN[$team] * 3 + DRAW[$team] ))
    printf '%-30s | %2d | %2d | %2d | %2d | %2d\n' \
      "$team" \
      "$matches" \
      "${WIN[$team]}" \
      "${DRAW[$team]}" \
      "${LOSS[$team]}" \
      "$points" 
  done | sort -t'|' -k6,6nr  # Sort based on total "points"
}

main "$@"
