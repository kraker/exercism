#!/usr/bin/env bash

reverse() {
  local reversed=""

  for ((i = 1; i <= ${#1}; i++)); do
    reversed+="${1: -i:1}"
  done

  echo "${reversed}"
}

reverse "$@"

