#!/usr/bin/env bash

day_of_week() {
  local day="$1"
  local weekdays
  weekdays=(Sunday Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

  for idx in "${!weekdays[@]}"; do
    if [[ "${weekdays[$idx]}" == "$day" ]]; then
      echo "$idx"
      return
    fi
  done

  echo "$day not a valid weekday" >&2
  return 1
}

calendar_days() {
  local -i first_day="$1" number_of_days="$2"
  local -n _calendar="$3"

  local -i day i
  ((day = first_day))
  for ((i = 1; i <= number_of_days; i++)); do
    (( _calendar[i] = day ))
    ((day = (day + 1) % 7))
  done
}

day_of_month_calc() {
  local -i day_of_week="$1" occurrence="$2"
  local -i start end i

  ((start = 1 + (7 * (occurrence - 1))))
  ((end = 7 * occurrence))

  for ((i = start; i <= end; i++)); do
    if ((calendar[i] == day_of_week)); then
      echo "$i"
      return
    fi
  done
}

day_of_month_teenth() {
  local -i day_of_week="$1" i

  for ((i = 13; i <= 19; i++)); do
    if ((calendar[i] == day_of_week)); then
      echo "$i"
      return
    fi
  done
}

day_of_month_last() {
  local -i day_of_week="$1" number_of_days="$2"

  local -i i
  for ((i = number_of_days; i >= 1; i--)); do
    if ((calendar[i] == day_of_week)); then
      echo "$i"
      return
    fi
  done
}

main() {
  local -i year="$1" month="$2"
  local week="$3" day="$4"

  local -i day_of_week first_day number_of_days
  # Convert weekday name to a number representation 0-6, 0 is Sunday
  day_of_week="$(day_of_week "$day")"
  # first weekday of the month 0-6, 0 is Sunday
  first_day=$(date --date "${year}-${month}-1" '+%w')
  # Number of days in the month
  if ((month == 12)); then
    ((number_of_days = 31))
  else
    # Next month minus a day
    number_of_days=$(date --date "${year}-$((month + 1))-1 yesterday" '+%d')
  fi

  # Build array with indices as day of the month with day of week as values
  # 1 2 3 4 5 6 7 8 9 ... 30 31
  # 6 0 1 2 3 4 5 6 0 ... 1  2
  local -ai calendar
  calendar_days "$first_day" "$number_of_days" calendar

  case "$week" in
    first)  day_of_month=$(day_of_month_calc "$day_of_week" 1) ;;
    second) day_of_month=$(day_of_month_calc "$day_of_week" 2) ;;
    third)  day_of_month=$(day_of_month_calc "$day_of_week" 3) ;;
    fourth) day_of_month=$(day_of_month_calc "$day_of_week" 4) ;;
    teenth) day_of_month=$(day_of_month_teenth "$day_of_week") ;;
    last)   day_of_month=$(day_of_month_last "$day_of_week" "$number_of_days") ;;
  esac

  date --date "${year}-${month}-${day_of_month}" --iso-8601
}

main "$@"
