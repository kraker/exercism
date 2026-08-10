#!/usr/bin/env bash

# crudely sorts an array based on first letter. This only works because the input
# is friendly and each team starts with a different letter of the alphabet.
# this is pure bash vs. calling sort. sort is probably better in practice tho...
crude_lexical_array_sort() {
  local -n arr="$1"
  local -a sorted
  local letter item fc

  for letter in {a..z}; do
    for item in "${arr[@]}"; do
      fc="${item:0:1}"
      [[ "${fc,,}" == "$letter" ]] && sorted+=( "$item" )
    done
  done

  arr=( "${sorted[@]}" )
}

# Given a nameref to a sorted array will deduplicate the array
array_dedup() {
  local -n arr="$1"
  local -a dedup
  local -i i

  for ((i = 0; i < ${#arr[@]}; i++)); do
    while [[ "${arr[i]}" == "${arr[i+1]}" ]]; do
      ((i++))
    done
    dedup+=( "${arr[i]}" )
  done

  arr=( "${dedup[@]}" )
}

get_teams() {
  local -n _matches="$1"
  local -n _teams="$2"

  local    _match
  local -a _line
  for _match in "${_matches[@]}"; do
    IFS=';' read -ra _line <<< "$_match"
    _teams+=( "${_line[@]:0:2}")
  done

  crude_lexical_array_sort _teams
  array_dedup _teams
}

matches_calc() {
  local -i _team_idx="$1"
  local    _team="$2"
  local -n _matches="$3"

  local    match
  local -i mp=0 w=0 l=0 d=0
  for match in "${_matches[@]}"; do
    IFS=';' read -ra line <<< "$match"
    if [[ "${line[0]}" == "$_team" ]]; then
      ((mp++))
      case "${line[2]}" in
        win) ((w++)) ;;
        loss) ((l++)) ;;
        draw) ((d++)) ;;
      esac
    elif [[ "${line[1]}" == "$_team" ]]; then
      ((mp++))
      case "${line[2]}" in
        win) ((l++)) ;;
        loss) ((w++)) ;;
        draw) ((d++)) ;;
      esac
    fi
  done

  p=$(( (w * 3) + d ))
  # quick and dirty, unique index ordered by points... this breaks down for
  # larger number of teams or p...
  idx=$((100 - (10 * p) + _team_idx))

  # Populate results array indices on function of p and _team_idx so they're
  # ordered by points and unique to each team
  results+=(
    [idx]="$(printf '%-30s | %2d | %2d | %2d | %2d | %2d\n' \
              "$_team" "$mp" "$w" "$d"  "$l"  "$p")"
  )
}

main() {
  local header
  header="Team                           | MP |  W |  D |  L |  P"

  local -a matches teams results
  mapfile -t matches "$@"

  get_teams matches teams
  #printf '%s\n' "${teams[@]}"

  local -i count=0
  for team in "${teams[@]}"; do
    matches_calc "$count" "$team" matches
    ((count++))
  done

  printf '%s\n' "$header"
  printf '%s\n' "${results[@]}"
}

main "$@"
