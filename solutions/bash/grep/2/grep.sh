#!/usr/bin/env bash

match() {
  local pattern="$1" string="$2"

  if ((caseinsensitive)); then
    pattern="${pattern,,}"
    string="${string,,}"
  fi

  if ((linematch)); then
    pattern="^${pattern}$"
  fi

  if ((invert)); then
    ! [[ "$string" =~ $pattern ]]
  else
    [[ "$string" =~ $pattern ]]
  fi
}

print_line() {
  local -i lineno="$1"
  local line="$2" file="$3" 

  if ((printfiles)); then
    printf '%s\n' "$file"
    return 1
  fi
  
  ((${#files[@]} > 1)) && printf '%s:' "$file"
  ((numberlines))      && printf '%s:' "$lineno"
  printf '%s\n' "$line"

  return 0
}

main() {
  local -i numberlines=0 printfiles=0 caseinsensitive=0 invert=0 linematch=0
  local opt OPTIND OPTARG

  while getopts ":nlivx" opt; do
    case "$opt" in
      n) numberlines=1 ;;
      l) printfiles=1 ;;
      i) caseinsensitive=1 ;;
      v) invert=1 ;;
      x) linematch=1 ;;
      ?) echo "Unknown option: $OPTARG" >&2 ;;
    esac
  done
  shift $((OPTIND - 1))
  
  local pattern="$1"
  local files=("${@:2}")
  local file
  local -i lineno

  for file in "${files[@]}"; do
    lineno=0
  
    while read -r line; do
      ((lineno++))
  
      if match "$pattern" "$line"; then
        print_line $lineno "$line" "$file" || break
      fi
    done < "$file"
  done
}

main "$@"
