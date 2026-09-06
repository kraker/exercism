#!/usr/bin/env bash

group() {
  local -n __groups="$1"; shift
  local -i die

  for die; do
    ((__groups[die]++))
  done
}

sum() {
  local -i die sum

  for die; do
    ((sum += die))
  done
  echo "$sum"
}

ordinals() {
  local -i n="$1"; shift
  local -a groups
  group groups "$@"

  echo "$((n * groups[n]))"
}

# NOTE: Borrowed logic from @glennj's solution:
# https://exercism.org/tracks/bash/exercises/yacht/solutions/glennj
full_house() {
  local -a groups
  group groups "$@"

  # full house must be 2 groups
  if ((${#groups[@]} == 2)); then
    for die in "${!groups[@]}"; do
      case "${groups[die]}" in
        # groups must be 2 or 3 die
        2 | 3) sum "$@" ;;
        *)     echo "0" ;;
      esac
      return
    done
  else
    echo "0"
  fi
}

four_kind() {
  local -a groups
  local -i die
  group groups "$@"

  for die in "${!groups[@]}"; do
    if ((groups[die] >= 4)); then
      echo "$((die * 4))"
      return
    fi
  done
  echo "0"
}

straight() {
  local kind="$1"; shift
  local straight

  case "$kind" in
    ls) straight="1 2 3 4 5" ;;
    bs) straight="2 3 4 5 6" ;;
  esac

  local -a groups
  group groups "$@"

  if [[ "${!groups[*]}" == "$straight" ]]; then
    echo "30"
  else
    echo "0"
  fi
}

yacht() {
  local -a groups
  group groups "$@"

  if ((${#groups[@]} == 1)); then
    echo "50"
  else
    echo "0"
  fi
}

## main ##
main() {
  local category="$1"
  shift

  case "$category" in
    "ones")            ordinals 1    "$@" ;;
    "twos")            ordinals 2    "$@" ;;
    "threes")          ordinals 3    "$@" ;;
    "fours")           ordinals 4    "$@" ;;
    "fives")           ordinals 5    "$@" ;;
    "sixes")           ordinals 6    "$@" ;;
    "full house")      full_house    "$@" ;;
    "four of a kind")  four_kind     "$@" ;;
    "little straight") straight "ls" "$@" ;;
    "big straight")    straight "bs" "$@" ;;
    "choice")          sum           "$@" ;;
    "yacht")           yacht         "$@" ;;
  esac
}

main "$@"
