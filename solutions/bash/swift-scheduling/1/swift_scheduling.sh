#!/usr/bin/env bash

# NOTE: First draft of a working solution... could use some polish.

first_workday_of_month() {
  local year="$1" month="$2" first_day
  # First day of the month in terms of day of week 1-7
  first_day="$(date --date "${year}-${month}-01" '+%u')"

  # First workday must be mon-fri (1-5)
  if ((first_day > 5)); then
    ((delta = 8 - first_day))
    date --date "${year}-${month}-01 08:00 $delta days" '+%FT%T'
  else
    date --date "${year}-${month}-01 08:00" '+%FT%T'
  fi
}

last_workday_of_quarter() {
  local year="$1" quarter="$2" qm week_day
  # quarter multiplier (3, 6, 9, 12) result in months
  ((qm = quarter * 3))
  # Week day (1-7) of last day of quarter
  wd="$(date --date "${year}-01-01 $qm months 1 day ago" '+%u')"
  if ((wd > 5)); then
    ((delta = wd - 4))
    date --date "${year}-01-01 08:00 $qm months $delta days ago" '+%FT%T'
  else
    date --date "${year}-01-01 08:00 $qm months 1 day ago" '+%FT%T'
  fi
}

deadline="$1"
# Date time string
datetime="$2"
# Calendar date YYYY-mm-dd
date="$(date --date "$datetime" '+%F')"
# Year YYYY
year="$(date --date "$datetime" '+%Y')" 
# Quarter
quarter="$(date --date "$datetime" '+%q')"
# Calendar month 1-12 (no 0 prefix since Bash interprets those as octal)
month="$(date --date "$datetime" '+%-m')"
# Day of the week 1-7 (mon = 1)
week_day="$(date --date "$datetime" '+%u')"
# 0-24 hour without 0 padding
hour="$(date --date "$datetime" '+%-H')"

if [[ "$deadline" == "NOW" ]]; then
  date --date "$datetime 2 hours" '+%FT%T'
elif [[ "$deadline" == "ASAP" ]]; then
  if ((hour < 13)); then
    date --date "$date 17:00" '+%FT%T'
  else
    date --date "$date 13:00 1 day" '+%FT%T'
  fi
elif [[ "$deadline" == "EOW" ]]; then
  if ((week_day < 4)); then
    ((delta = 5 - week_day))
    date --date "$date 17:00 $delta days" '+%FT%T'
  else
    ((delta = 7 - week_day))
    date --date "$date 20:00 $delta days" '+%FT%T'
  fi
elif [[ "${deadline: -1}" == "M" ]]; then
  # Month deadline 1-12 (Bash interprets 0 prefix integers as octal)
  m_deadline="${deadline:0:-1}"
  # Month deadline in mm format 01-12
  mm_deadline="$(printf '%02d' "${deadline:0:-1}")"
  #echo "$month : $m_deadline: $mm_deadline"
  if ((month < m_deadline)); then
    first_workday_of_month "$year" "$mm_deadline"
  else
    ((year++))
    first_workday_of_month "$year" "$mm_deadline"
  fi
elif [[ "${deadline:0:1}" == "Q" ]]; then 
  q_deadline="${deadline:1}"
  if ((quarter <= q_deadline)); then
    last_workday_of_quarter "$year" "$q_deadline"
  else
    ((year++))
    last_workday_of_quarter "$year" "$q_deadline"
  fi
fi

