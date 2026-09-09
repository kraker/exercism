#!/usr/bin/env bash

die() { echo "$*" >&2; exit 1; }

is_number() {
  [[ "$1" =~ ^-?[[:digit:]]+$ ]]
}

# Up until now I've intentionally not sought the help of an AI... but in this
# particular case I got some help with this function by chatting with Claude,
# Opus 5.
pop() {
    local -n __arr=$1
    local -n __out=$2
    local __keys=("${!__arr[@]}")
    (( ${#__keys[@]} )) || return 1
    local __last=${__keys[-1]}
    __out=${__arr[__last]}
    unset '__arr[__last]'
}

define() {
  local -l word="$1" # lower-case word

  if is_number "$word"; then
    die "illegal operation"
  fi

  local definition="$2"
  local -a expression
  read -ra expression <<< "$definition"

  local -i indice
  local elem
  for indice in "${!expression[@]}"; do
    elem="${expression[$indice]}"
    if [[ -v dictionary[$elem] ]]; then
      expression[indice]="${dictionary[$elem]}"
    fi
  done
  # dictionary associative array is defined as a "global" in main
  dictionary["$word"]="${expression[*]}"
}

validate() {
  length="$1"
  case "$length" in
    0) die "empty stack" ;;
    1) die "only one value on the stack" ;;
    *) : ;;
  esac
}

calculate() {
  local -i a="$1" b="$2" result
  local op="$3"
  case "$op" in
    "+") ((result = a + b)) ;;
    "-") ((result = a - b)) ;;
    "*") ((result = a * b)) ;;
    "/")
      if ((b == 0)); then
        die "divide by zero"
      else
        ((result = a / b)) 
      fi
      ;;
  esac
  echo "$result"
}

evaluate() {
  local -a expression
  read -ra expression <<< "$1"

  local -l word # lower-case word
  local -a stack
  for word in "${expression[@]}"; do
    if is_number "$word"; then
      stack+=("$word")
      continue
    elif [[ -v "dictionary[$word]" ]]; then
      read -ra stack <<< "$(evaluate "${stack[*]} ${dictionary[$word]}")"
      continue
    fi

    case "$word" in
      [-+*/]) 
        validate "${#stack[@]}"
        op="$word"
        pop stack b
        pop stack a
        result=$(calculate "$a" "$b" "$op") || exit 1
        stack+=("$result")
        ;;
      dup)
        ((${#stack[@]} > 0)) || validate "${#stack[@]}"
        stack+=("${stack[-1]}")
        ;;
      drop)
        ((${#stack[@]} > 0)) || validate "${#stack[@]}"
        unset 'stack[-1]'
        ;;
      swap)
        validate "${#stack[@]}"
        pop stack b
        pop stack a
        stack+=("$b" "$a")
        ;;
      over)
        validate "${#stack[@]}"
        stack+=("${stack[-2]}")
        ;;
      *) die "undefined operation" ;;
    esac
  done

  echo "${stack[@]}"
}

main() {
  local -a lines
  mapfile -t lines

  local -A dictionary
  local word definition

  local line
  local -a statement

  for line in "${lines[@]}"; do
    IFS=' ;' read -ra statement <<< "$line"
    case "${statement[0]}" in
      ":")
        word="${statement[1]}"
        definition="${statement[*]:2}"
        define "$word" "$definition"
        ;;
      *)
        evaluate "${statement[*]}"
        ;;
    esac
  done
}

main "$@"
