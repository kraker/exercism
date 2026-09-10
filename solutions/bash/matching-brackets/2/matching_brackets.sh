#!/usr/bin/env bash

bool_exit() { echo "$1"; exit 0; }

# Strip out anything that's not a bracket
string="${1//[^\(\)\{\}\[\]]/}"

# If there are an odd number of brackets then fail immediately. For each open
# bracket to have a correspoding close bracket the number of brackets must be
# a multiple of 2.
((${#string} % 2 == 0)) || bool_exit "false"

# The rest pretty much stolen from @glennj and @IsaacG's solutions.

declare -A brackets=(
  ["]"]="["
  [")"]="("
  ["}"]="{"
)

stack=""

for ((i = 0; i < ${#string}; i++)); do
  char=${string:i:1}
  case $char in
    "["|"("|"{") stack+=$char ;;
    "]"|")"|"}")
      b=${brackets[$char]}
      [[ $stack = *"$b" ]] || bool_exit "false"
      stack=${stack%"$b"}
      ;;
  esac
done

# At the end stack should be empty
[[ -z $stack ]] || bool_exit "false"

bool_exit "true"
