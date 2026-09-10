#!/usr/bin/env bash

hours="$1"
minutes="$2"

total_minutes="$((hours * 60 + minutes))"
total_hours="$((total_minutes / 60))"

hour="$((total_hours % 24))"
minute="$((total_minutes % 60))"

((minute < 0)) && { ((minute+=60)); ((hour-=1)); }
((hour < 0)) && ((hour+=24))

printf "%02d:%02d\n" "$hour" "$minute"

