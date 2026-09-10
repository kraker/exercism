#!/usr/bin/env bash

string="$1"

die() {
  printf '%s\n' "$*"
  exit 0
}

# Silence is 0 or more whitespace characters and nothing else.
[[ "$string" =~ ^[[:space:]]*$ ]] && die "Fine. Be that way!"

# Question is anything ending with a '?' with or without trailing whitespace
if [[ "$string" =~ ^.*\?[[:space:]]*$ ]]; then
  # Shouting is all uppercase and can include non-alpha chars. It's easier to
  # say shouting contains no lowercase chars and at least one uppercase char.
  if [[ "$string" =~ ^[^[:lower:]]+$ && "$string" =~ ^.*[[:upper:]]+.*$ ]]; then 
    die "Calm down, I know what I'm doing!"
  else
    die "Sure."
  fi
elif [[ "$string" =~ ^[^[:lower:]]+$ && "$string" =~ ^.*[[:upper:]]+.*$ ]]; then
  die "Whoa, chill out!"
else
  die "Whatever."
fi

