#!/usr/bin/env bash

modifier() {
  local -i c="$1"
  ((c -= 10))
  # If constitution is not divisible by 2 round down to nearest integer first
  # then divide by 2. Bash only supports integer math. 
  ((c % 2 == 0)) && ((c /= 2)) || ((c = (c - 1) / 2))
  echo "$c"
}

die_sort() {
  local -n d="$1"      # d = "dice"
  local -n r="$2"      # r = "roll"

  for s in {6..1}; do  # s = "side"
    for ((i = 0; i < ${#d[@]}; i++)); do
      ((s == ${d[i]})) && r+=("${d[i]}")
    done
  done
}

roll() {
  local -n roll="$1"

  local dice=()
  for ((i = 0; i < 4; i++)); do
    dice+=("$(( (RANDOM % 6) + 1 ))")
  done

  die_sort dice roll
}

sum() {
  local -n roll="$1"
  local -i sum

  for die in "${roll[@]:0:3}"; do
    ((sum += die))
  done

  echo "$sum"
}

generate() {
  roll st; strength="$(sum st)"
  roll de; dexterity="$(sum de)"
  roll co; constitution="$(sum co)"
  roll in; intelligence="$(sum in)"
  roll wi; wisdom="$(sum wi)"
  roll ch; charisma="$(sum ch)"

  modifier="$(modifier "$constitution")"
  hitpoints="$((10 + modifier))"

  cat << EOF
strength $strength
dexterity $dexterity
constitution $constitution
intelligence $intelligence
wisdom $wisdom
charisma $charisma
hitpoints $hitpoints
EOF
}

main () {
  "$1" "$2"
}

main "$@"
