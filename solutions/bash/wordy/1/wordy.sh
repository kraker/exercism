#!/usr/bin/env bash

die() { echo "$*" >&2; exit 1; }

is_valid() {
  local -n _expr="$1"

  # Empty expression is invalid, (e.g. "What is?")
  ((${#_expr[@]} > 0)) || return 1

  # Expression must be numbers with symbols in-between, e.g. (1 + 2 + 3) vs. (+ 1 2 3)
  local -i i
  for ((i = 0; i < ${#_expr[@]}; i += 2)); do
    number="${_expr[i]}"
    [[ "$number" =~ [[:digit:]] ]] || return 1

    operator="${_expr[i + 1]}"
    if [[ -n "$operator" ]]; then
      [[ "$operator" =~ [-+*/] ]] || return 1
    fi
  done

  # Last component of expression must be a number, e.g. (1 + 1 +) is invalid.
  [[ "${_expr[-1]}" =~ [[:digit:]] ]] || return 1
}

IFS=' ?'
read -ra words <<< "$1"

# Build expression
for word in "${words[@]:2}"; do
  case "$word" in
    [-0-9]*)    expression+=("$word") ;;
    plus)       expression+=("+") ;;
    minus)      expression+=("-") ;;
    multiplied) expression+=("*") ;;
    divided)    expression+=("/") ;;
    by) : ;;
    *) die "unknown operation" ;;
  esac
done

is_valid expression || die "syntax error"

# Calculate expression working from left to right, ignoring typical order of
# of operations.
while ((${#expression[@]} > 1)); do
  ((value = ${expression[@]:0:3}))
  if [[ -n "${expression[*]:3}" ]]; then
    expression=("$value" "${expression[@]:3}")
  else
    expression=("$value")
  fi
done

echo "${expression[0]}"
