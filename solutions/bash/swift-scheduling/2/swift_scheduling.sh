#!/usr/bin/env bash

# Calculate date time n hours into the future from date
# Usage: now <datetime> <hours>
now() {
  local dt="$1" h="$2"
  date --date "$dt $h hours" "$FORMAT"
}

# Usage: asap <date> <hour>
asap() {
  local d="$1" h="$2"
  if ((h < 13)); then
    date --date "$d 17:00" "$FORMAT"
  else
    date --date "$d 13:00 1 day" "$FORMAT"
  fi
}

eow() {
  local d="$1" wd
  # Day of the week 1-7 (mon = 1)
  wd="$(date --date "$d" '+%u')"
  
  # If before Fri, EOW is Fri at 5pm
  if ((wd < 4)); then
    ((delta = 5 - wd))
    date --date "$d 17:00 $delta days" "$FORMAT"
  # Otherwise EOW means Sun at 8pm
  else
    ((delta = 7 - wd))
    date --date "$d 20:00 $delta days" "$FORMAT"
  fi
}

# Usage: nm <year> <current_month> <NM>
nm() {
  # y=year cm=<current_month), nm=<NM> ("N" month), md=month deadline 1-12,
  # mmd=month (mm formatted) deadline 01-12
  local y="$1" cm="$2" nm="$3" md mmd
  # Need month as integer w/o 0 pad for arithmetic comparison otherwise Bash
  # interprets as octal.
  md="${nm:0:-1}"
  mmd="$(printf '%02d' "${nm:0:-1}")"

  if ((cm < md)); then
    first_workday_of_month "$y" "$mmd"
  else
    ((y++))
    first_workday_of_month "$y" "$mmd"
  fi
}

#Usage: qn <date> <QN>
qn() {
  #d=date, qn=<QN>
  local d="$1" qn="$2" y q qd
  y="${d:0:4}" # year
  q="$(date --date "$d" '+%q')" # current quarter
  qd="${qn:1}" # quarter deadline

  if ((q <= qd)); then
    last_workday_of_quarter "$y" "$qd"
  else
    ((y++))
    last_workday_of_quarter "$y" "$qd"
  fi
}

# Usage: first_workday_of_month <year> <month>
first_workday_of_month() {
  local y="$1" m="$2" wd
  # Week day 1-7 of first day of the month
  wd="$(date --date "${y}-${m}-01" '+%u')"

  # First workday must be mon-fri (1-5)
  if ((wd > 5)); then
    ((delta = 8 - wd))
    date --date "${y}-${m}-01 08:00 $delta days" "$FORMAT"
  else
    date --date "${y}-${m}-01 08:00" "$FORMAT"
  fi
}

last_workday_of_quarter() {
  local y="$1" q="$2" qm wd
  # quarter multiplier (3, 6, 9, 12) result in months
  ((qm = q * 3))
  # Week day (1-7) of last day of quarter
  wd="$(date --date "${y}-01-01 $qm months 1 day ago" '+%u')"

  # Workday can't be a weekend day 6-7
  if ((wd > 5)); then
    ((delta = wd - 4)) # (wd - 5) + 1 since counting from first day of month after end of quarter.
    date --date "${y}-01-01 08:00 $qm months $delta days ago" "$FORMAT"
  else
    # Last day of month is always 1 day before the 1st day of the next month.
    # Let 'date' calculate 31, 30, 29, or 28 depending on month, year, leap year,
    # etc.
    date --date "${y}-01-01 08:00 $qm months 1 day ago" "$FORMAT"
  fi
}

FORMAT='+%FT%T'          # Date format string
DATETIME="$2"            # Datetime string, "2003-03-31T08:00:00"
# Use parameter expansion to parse datetime string since it's cheap
DATE="${DATETIME:0:10}"  # Date string
YYYY="${DATETIME:0:4}"   # Year 
MM="${DATETIME:5:2}"     # Month
HH="${DATETIME:11:2}"    # Hour
H="${HH#0}"              # Hour integer (without 0 pad, i.e. 1-24)


case $1 in
  NOW) now "$DATETIME" "2" ;;
  ASAP) asap "$DATE" "$H" ;;
  EOW) eow "$DATE" ;;
  *M) nm "$YYYY" "$MM" "$1" ;;
  Q*) qn "$DATE" "$1" ;;
esac
