#!/usr/bin/env bash

# borrowed from @glennj's solution
declare -a items that

items+=("house")                           ; that+=("Jack built")
items+=("malt")                            ; that+=("lay in")
items+=("rat")                             ; that+=("ate")
items+=("cat")                             ; that+=("killed")
items+=("dog")                             ; that+=("worried")
items+=("cow with the crumpled horn")      ; that+=("tossed")
items+=("maiden all forlorn")              ; that+=("milked")
items+=("man all tattered and torn")       ; that+=("kissed")
items+=("priest all shaven and shorn")     ; that+=("married")
items+=("rooster that crowed in the morn") ; that+=("woke")
items+=("farmer sowing his corn")          ; that+=("kept")
items+=("horse and the hound and the horn"); that+=("belonged to")

build_stanza() {
  local -i verse="$1"

  local stanza=""
  for ((j = verse - 1; j >= 0; j--)); do
    stanza+=" the ${items[$j]} that ${that[$j]}"
  done

  echo "This is${stanza}."
}

build_rhyme() {
  local -i start="$1"
  local -i end="$2"

  for ((i = start; i <= end; i++)); do
    build_stanza "$i"
  done
}

(($1 < 1 || $1 > 12 || $2 < 1 || $2 > 12)) && echo "invalid" >&2 && exit 1

build_rhyme "$1" "$2"
