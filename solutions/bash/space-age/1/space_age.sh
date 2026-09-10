#!/usr/bin/env bash

# Orbital periods in seconds
declare -A periods
periods[earth]=31557600
periods[mercury]=$(bc -l <<< "${periods[earth]} * 0.2408467")
periods[venus]=$(bc -l   <<< "${periods[earth]} * 0.61519726")
periods[mars]=$(bc -l    <<< "${periods[earth]} * 1.8808158")
periods[jupiter]=$(bc -l <<< "${periods[earth]} * 11.862615")
periods[saturn]=$(bc -l  <<< "${periods[earth]} * 29.447498")
periods[uranus]=$(bc -l  <<< "${periods[earth]} * 84.016846")
periods[neptune]=$(bc -l <<< "${periods[earth]} * 164.79132")

planet="${1,,}"
age_secs="$2"  # age in seconds

count=0
for key in "${!periods[@]}"; do
  [[ "$planet" == "$key" ]] && (( count++ ))
done
((count == 1)) || { echo "not a planet" >&2; exit 1; }

age=$(bc -l <<< "$age_secs / ${periods[$planet]}" )

printf '%.2f\n' "$age"
