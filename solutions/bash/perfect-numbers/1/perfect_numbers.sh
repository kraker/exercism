#!/usr/bin/env bash

num="$1"

((num > 0)) || { 
  echo "Classification is only possible for positive integers." >&2
  exit 1
}

# Very inefficient find all factors... takes a long time to run for larger
# numbers...
for ((i = 1; i < num; i++)); do
  ((num % i == 0)) && factors+=("$i")
done

for factor in "${factors[@]}"; do
  ((sum += factor))
done

if   ((sum < num));  then echo "deficient"
elif ((sum == num)); then echo "perfect"
elif ((sum > num));  then echo "abundant"
fi
