#!/usr/bin/env bash

# Earth year in seconds
EARTH_YEAR_SECONDS=31557600

# Planet orbital periods in Earth years
declare -A periods=(
  [Mercury]=0.2408467
  [Venus]=0.61519726
  [Earth]=1.0
  [Mars]=1.8808158
  [Jupiter]=11.862615
  [Saturn]=29.447498
  [Uranus]=84.016846
  [Neptune]=164.79132
)

planet="$1"
age_seconds="$2"  # age in seconds

# Is a planet?
[[ -n "${periods[$planet]}" ]] || { echo "not a planet" >&2; exit 1; }

age=$(bc -l <<< "$age_seconds / ($EARTH_YEAR_SECONDS * ${periods[$planet]})" )

printf '%.2f\n' "$age"
