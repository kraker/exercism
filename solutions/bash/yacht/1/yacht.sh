#!/usr/bin/env bash

ordinals() {
  local -i n="$1" d score=0

  for d in "${roll[@]}"; do
    ((d == n)) && ((score += d))
  done

  echo "$score"
}

full_house() {
  local -i a="${roll[0]}" b
  local -i counta countb score=0

  for d in "${roll[@]}"; do
    ((d == a)) && ((counta++))
    ((d != a)) && ((b = d))
  done

  for d in "${roll[@]}"; do
    ((d == b)) && ((countb++))
  done

  if ((counta == 3 && countb == 2)) || ((counta == 2 && countb == 3)); then
    for d in "${roll[@]}"; do
      ((score += d))
    done
  fi

  echo "$score"
}

four_kind() {
  local -i a="${roll[0]}" b
  local -i counta countb

  for d in "${roll[@]}"; do
    ((d == a)) && ((counta++))
    ((d != a)) && ((b = d))
  done

  for d in "${roll[@]}"; do
    ((d == b)) && ((countb++))
  done

  if ((counta >= 4)); then
    echo "$((a * 4))"
  elif ((countb >= 4)); then
    echo "$((b * 4))"
  else
    echo "0"
  fi
}

straight() {
  local kind="$1"
  local -a straight

  for d in "${roll[@]}"; do
    ((straight[d] = d))
  done

  if [[ "$kind" == "ls" && "${straight[*]}" == "1 2 3 4 5" ]] ||
     [[ "$kind" == "bs" && "${straight[*]}" == "2 3 4 5 6" ]]
  then
    echo "30"
  else
    echo "0"
  fi
}

choice() {
  local -i score=0
  for d in "${roll[@]}"; do
    ((score += d))
  done
  echo "$score"
}

yacht() {
  local -i a="${roll[0]}" count score

  for d in "${roll[@]}"; do
    ((d == a)) && ((count++))
  done

  if ((count == 5)); then
    echo "50"
  else
    echo "0"
  fi
}

## main ##
category="$1"; shift
roll=("$@")

case "$category" in
  "ones")   ordinals 1 ;;
  "twos")   ordinals 2 ;;
  "threes") ordinals 3 ;;
  "fours")  ordinals 4 ;;
  "fives")  ordinals 5 ;;
  "sixes")  ordinals 6 ;;
  "full house") full_house ;;
  "four of a kind") four_kind ;;
  "little straight") straight "ls" ;;
  "big straight") straight "bs" ;;
  "choice") choice ;;
  "yacht") yacht ;;
esac
