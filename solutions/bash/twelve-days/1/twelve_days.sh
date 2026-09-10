#!/usr/bin/env bash

days=(
  ""
  "first"
  "second"
  "third"
  "fourth"
  "fifth"
  "sixth"
  "seventh"
  "eighth"
  "ninth"
  "tenth"
  "eleventh"
  "twelfth"
)

gifts=(
  ""
  "a Partridge in a Pear Tree."
  "two Turtle Doves, and"
  "three French Hens,"
  "four Calling Birds,"
  "five Gold Rings,"
  "six Geese-a-Laying,"
  "seven Swans-a-Swimming,"
  "eight Maids-a-Milking,"
  "nine Ladies Dancing,"
  "ten Lords-a-Leaping,"
  "eleven Pipers Piping,"
  "twelve Drummers Drumming,"
)

build_verse() {
  local n="$1"

  verse="On the ${days[$n]} day of Christmas my true love gave to me:"
  for ((i = n; i >= 1; i--)); do
    verse+=" ${gifts[i]}"
  done

  echo "$verse"
}

start="$1"
end="$2"

for ((j = start; j <= end; j++)); do
  build_verse "$j"
done

