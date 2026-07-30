#!/usr/bin/env bash

declare -ra "ALPHA=({A..$1})"

index=$((${#ALPHA[@]} - 1))

if ((index == 0)); then
  echo "A"
  exit 0
fi

for ((i = 0; i <= index; i++)); do
  a="${ALPHA[i]}"
  lpad=$((index + 1 - i))
  rpad=$((index - i))
  cpad="$((i * 2))"
  if ((i == 0)); then
    printf '%*s%*s\n' "$lpad" "$a" "$rpad" " "
  elif ((rpad > 0)); then
    printf '%*s%*s%*s\n' "$lpad" "$a" "$cpad" "$a" "$rpad" " "
  else
    printf '%s%*s\n' "$a" "$cpad" "$a"
  fi
done
for ((j = index - 1; j >= 0; j--)); do
  a="${ALPHA[j]}"
  lpad=$((index + 1 - j))
  rpad=$((index - j))
  cpad="$((j * 2))"
  if ((j == 0)); then
    printf '%*s%*s\n' "$lpad" "$a" "$rpad" " "
  elif ((rpad > 0)); then
    printf '%*s%*s%*s\n' "$lpad" "$a" "$cpad" "$a" "$rpad" " "
  else
    printf '%s%*s\n' "$a" "$cpad" "$a"
  fi
done
