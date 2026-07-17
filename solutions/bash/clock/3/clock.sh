#!/usr/bin/env bash

err_args() {
  echo "invalid arguments" >&2
  exit 1
}

clock() {
  local hours="$1"
  local minutes="$2"

  local total_minutes="$((hours * 60 + minutes))"
  local total_hours="$((total_minutes / 60))"
  
  local h="$((total_hours % 24))"
  local m="$((total_minutes % 60))"
  
  ((m < 0)) && { ((m+=60)); ((h-=1)); }
  ((h < 0)) && ((h+=24))

  printf "%02d:%02d\n" "$h" "$m"
}

# Check args that should be integers
for arg in $1 $2 $4 $5; do
  [[ "$arg" =~ ^[-[:digit:]]+$ ]] || err_args
done

HOURS="$1"
MINUTES="$2"

case $# in
  2) clock "$HOURS" "$MINUTES" ;;
  [45]) 
    case $3 in
      "+") ((MINUTES+=$4)); clock "$HOURS" "$MINUTES" ;;
      "-") ((MINUTES-=$4)); clock "$HOURS" "$MINUTES" ;;
      "=") 
        if [[ "$(clock "$1" "$2")" == "$(clock "$4" "$5")" ]]; then
          echo "true"
        else
          echo "false"
        fi
        ;;
      *) err_args ;;
    esac 
    ;;
  *) err_args ;;
esac

