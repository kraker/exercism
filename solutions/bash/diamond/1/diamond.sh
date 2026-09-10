#!/usr/bin/env bash

LETTER="$1"
ALPHA=({A..Z})

index=0
for a in {A..Z}; do
  if [[ "$LETTER" == "$a" ]]; then
    break
  fi
  ((index++))
done

if ((index == 0)); then
  echo "A"
  exit 0
fi

printf '%*s%*s\n' $((index + 1)) "${ALPHA[0]}" $index " "
for ((i = 1; i <= index; i++)); do
  a="${ALPHA[i]}"
  lpad=$((index + 1 - i))
  rpad=$((index - i))
  cpad="$((i * 2))"
  if ((rpad > 0)); then
    printf '%*s%*s%*s\n' "$lpad" "$a" "$cpad" "$a" "$rpad" " "
  else
    printf '%*s%*s\n' "$lpad" "$a" "$cpad" "$a"
  fi
done
for ((j = index - 1; j >= 1; j--)); do
  a="${ALPHA[j]}"
  lpad=$((index + 1 - j))
  rpad=$((index - j))
  cpad="$((j * 2))"
  if ((rpad > 0)); then
    printf '%*s%*s%*s\n' "$lpad" "$a" "$cpad" "$a" "$rpad" " "
  else
    printf '%*s%*s\n' "$lpad" "$a" "$cpad" "$a"
  fi
done
printf '%*s%*s\n' $((index + 1)) "${ALPHA[0]}" $index " "

