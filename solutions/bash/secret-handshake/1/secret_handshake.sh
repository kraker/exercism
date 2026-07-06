#!/usr/bin/env bash

code="$1"

reverse_array() {
  local -n arr="$1"
  local -n rra="$2"

  for ((i = ${#arr[@]} - 1; i >= 0; i--)); do
    rra+=("${arr[$i]}")
  done
}

((code & 1)) && moves+=("wink")
((code & 2)) && moves+=("double blink")
((code & 4)) && moves+=("close your eyes")
((code & 8)) && moves+=("jump")
((code & 16)) && reverse=1 || reverse=0

if ((reverse)); then
  reverse_array moves rmoves

  IFS=',' handshake="${rmoves[*]}"
  unset IFS
else
  IFS=',' handshake="${moves[*]}"
  unset IFS
fi

echo "${handshake}"
