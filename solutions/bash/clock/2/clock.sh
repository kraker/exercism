#!/usr/bin/env bash

err_args() {
  echo "invalid arguments" >&2
  exit 1
}

is_digit() {
  [[ "$1" =~ ^[-[:digit:]]+$ ]]
}

clock() {
  local hours="$1"
  local minutes="$2"

  local total_minutes="$((hours * 60 + minutes))"
  local total_hours="$((total_minutes / 60))"
  
  hour="$((total_hours % 24))"
  minute="$((total_minutes % 60))"
  
  ((minute < 0)) && { ((minute+=60)); ((hour-=1)); }
  ((hour < 0)) && ((hour+=24))

  printf "%02d:%02d\n" "$hour" "$minute"
}

HOURS="$1"
MINUTES="$2"

is_digit "$HOURS"   || err_args
is_digit "$MINUTES" || err_args

if (($# == 2)); then
  clock "$HOURS" "$MINUTES"
elif (($# >= 4 && $# <= 5)); then
  operator="$3"
  is_digit "$4" || err_args

  case $operator in
    "+") 
      ((MINUTES+=$4))
      clock "$HOURS" "$MINUTES"
      ;;
    "-")
      ((MINUTES-=$4)) 
      clock "$HOURS" "$MINUTES"
      ;;
    "=") 
      is_digit "$5" || err_args
      time1=$(clock "$1" "$2")
      time2=$(clock "$4" "$5")
      [[ "$time1" == "$time2" ]] && echo true || echo false
      ;;
    *) err_args ;;
  esac
else
  err_args
fi

