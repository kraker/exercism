#!/usr/bin/env bash

direction_number() {
  local direction="$1"
  local -i i

  # Default if there's no input is "north"
  if [[ -z "$direction" ]]; then
    echo "0"
    return
  fi

  for ((i = 0; i < ${#directions[@]}; i++)); do
    if [[ "$direction" = "${directions[$i]}" ]]; then
      echo "$i"
      return
    fi
  done

  # Return error if no direction found
  return 1
}

turn_right() {
  if ((direction < 3)); then
    ((direction += 1))
  else
    ((direction = 0))
  fi
}

turn_left() {
  if ((direction > 0)); then
    ((direction -= 1))
  else
    ((direction = 3))
  fi
}

advance() {
  case "$direction" in
    0) ((y += 1)) ;;
    1) ((x += 1)) ;;
    2) ((y -= 1)) ;;
    3) ((x -= 1)) ;;
  esac
}

directions=(
  north
  east
  south
  west
)

x="${1:-"0"}"
y="${2:-"0"}"
direction=$(direction_number "$3") || { echo "invalid direction" >&2; exit 1; }
moves="$4"

for ((i = 0; i < ${#moves}; i++)); do
  case "${moves:i:1}" in
    R) turn_right ;;
    L) turn_left ;;
    A) advance ;;
    *) echo "invalid instruction" >&2; exit 1 ;;
  esac
done

echo "$x $y ${directions[$direction]}"
