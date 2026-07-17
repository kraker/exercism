#!/usr/bin/env bash

string="$1"

# Silence is 0 or more whitespace chars and nothing else.
is_silent()   { [[ "$string" =~ ^[[:space:]]*$ ]]; }
# Question is anything ending with a '?' with or without trailing whitespace
is_question() { [[ "$string" =~ ^.*\?[[:space:]]*$ ]]; }
# Shouting is no lowercase but contains uppercase
is_yelling()  {
  [[ "$string" =~ ^[^[:lower:]]+$ && "$string" =~ ^.*[[:upper:]]+.*$ ]]
}

if is_silent; then
  echo "Fine. Be that way!"
elif is_question; then
  if is_yelling; then 
    echo "Calm down, I know what I'm doing!"
  else
    echo "Sure."
  fi
elif is_yelling; then
  echo "Whoa, chill out!"
else
  echo "Whatever."
fi

