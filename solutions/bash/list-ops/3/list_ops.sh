#!/usr/bin/env bash

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    echo "This library of functions should be sourced into another script" >&2
    exit 4
fi
bash_version=$((10 * BASH_VERSINFO[0] + BASH_VERSINFO[1]))
if (( bash_version < 43 )); then
    echo "This library requires at least bash version 4.3" >&2
    return 4
fi

# Due to inherent bash limitations around word splitting and globbing,
# functions that are intended to *return a list* are instead required to
# receive a nameref parameter, the name of an array variable that will be
# populated in the list function.
# See the filter, map and reverse functions.

# Also note that nameref parameters cannot have the same name as the
# name of the variable in the calling scope.


# Append some elements to the given list.
list::append () {
  local -n __list="$1"
  shift
  __list+=("$@")
}

# Return only the list elements that pass the given function.
list::filter () {
  local __filter="$1" item
  local -n __list="$2" __result="$3"
  __result=()
  for item in "${__list[@]}"; do
    if "$__filter" "$item"; then
      __result+=("$item")
    fi
  done
}

# Transform the list elements, using the given function,
# into a new list.
list::map () {
  local __func="$1" item
  local -n __list="$2" __result="$3"
  __result=()
  for item in "${__list[@]}"; do
    item=$("$__func" "$item")
    __result+=("$item")
  done
}

# Left-fold the list using the function and the initial value.
list::foldl () {
  local __func="$1" __acc="$2"
  local -n __list="$3"
  local item
  for item in "${__list[@]}"; do
    __acc=$("$__func" "$__acc" "$item")
  done
  printf '%s\n' "$__acc"
}

# Right-fold the list using the function and the initial value.
list::foldr () {
  local __func="$1" __acc="$2"
  local -n __list="$3"
  local -i i
  local item
  for ((i = 1; i <= ${#__list[@]}; i++)); do
    item="${__list[-i]}"
    __acc=$("$__func" "$item" "$__acc")
  done
  printf '%s\n' "$__acc"
}

# Return the list reversed
list::reverse () {
  local -n __list="$1" __result="$2"
  __result=()
  local -i i
  for ((i = 1; i <= ${#__list[@]}; i++)); do
    __result+=("${__list[-i]}")
  done
}
