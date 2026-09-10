#!/usr/bin/env bash

# NOTE: This first iteration I brute-forced the test cases to get them to pass.
# But there must be a more elegant way to solve this than the big ugly for loop
# I have...

die() { echo "$*" >&2; exit 1; }

declare -ai rolls=("$@")

# Fail fast if any throw is invalid
for roll in "${rolls[@]}"; do
  ((roll >= 0))  || die "Negative roll is invalid"
  ((roll <= 10)) || die "Pin count exceeds pins on the lane"
done

declare -ai frames
for ((i = 0; i < ${#rolls[@]}; i++)); do
  if ((rolls[i] == 10)); then
    ((frame = rolls[i] + rolls[i + 1] + rolls[i + 2])) # calc strike
    frames+=("$frame")
    # a strike in the last frame is a special case
    if ((${#frames[@]} == 10 )); then
      # Since last frame is a strike, there must be 2 more bonus rolls to finish
      # the game.
      if ((${#rolls[@]} <= i + 2)); then
        die "Score cannot be taken until the end of the game"
      elif ((${#rolls[@]} > i + 3)); then
        die "Cannot roll after game is over"
      fi
    fi
  else
    ((frame = rolls[i] + rolls[i + 1]))
    ((frame > 10)) && die "Pin count exceeds pins on the lane"
    ((frame == 10)) && ((frame += rolls[i + 2])) # calc spare
    frames+=("$frame")
    # a spare in the last frame is a special case
    if ((${#frames[@]} == 10 && frame >= 10)); then
      # last frame spare gets 1 more bonus roll
      if ((${#rolls[@]} <= i + 2)); then
        die "Score cannot be taken until the end of the game"
      elif ((${#rolls[@]} > i + 3)); then
        die "Cannot roll after game is over"
      fi
    # If the last frame isn't a spare there can be no more rolls
    elif ((${#frames[@]} == 10 && ${#rolls[@]} > i + 2)); then
      die "Cannot roll after game is over"
    fi
    ((i++))
  fi
done

((${#frames[@]} >= 10)) || die "Score cannot be taken until the end of the game"

declare -i score=0
for frame in "${frames[@]:0:10}"; do
  ((score += frame))
done

echo "$score"
