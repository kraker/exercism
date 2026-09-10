#!/usr/bin/env bash

# NOTE: Incomplete solution, as you can probably see I'm struggling with this
# one ...

# Strip out anything that's not a bracket
brackets="${1//[^\(\)\{\}\[\]]/}"

# op='('  "Open Paren"
# cp=')'  "Close Paren"
# osb='[' "Open Square Bracket"
# csb=']' "Close Square Bracket"
# ocb='{' "Open Curly Brace"
# ccb='}' "Close Curly Brace"

declare op=0 cp=0 osb=0 csb=0 ocb=0 ccb=0

# Loop over chars in string and count open and close brackets for each type.
# Test within the loop that there aren't more close brackets than open brackets.
# This means there's a close bracket without a corresponding open bracket.
# (i.e. ')(')
for ((i = 0; i < ${#brackets}; i++)); do 
  [[ "${brackets:i:1}" == ')' ]] && { (( cp += 1 )); continue; }
  [[ "${brackets:i:1}" == ']' ]] && { (( csb += 1 )); continue; }
  [[ "${brackets:i:1}" == '}' ]] && { (( ccb += 1 )); continue; }

  (( cp > op )) && { echo "false"; exit 0; }
  (( csb > osb )) && { echo "false"; exit 0; }
  (( ccb > ocb )) && { echo "false"; exit 0; }

  if [[ "${brackets:i:1}" == '(' && "${brackets:i+1:1}" =~ [^]}] ]]; then 
    (( op += 1 ))
    continue
  elif [[ "${brackets:i:1}" == '[' && "${brackets:i+1:1}" =~ [^\)}] ]]; then
    (( osb += 1 ))
    continue
  elif [[ "${brackets:i:1}" == '{' && "${brackets:i+1:1}" =~ [^]\)] ]]; then
    (( ocb += 1 ))
    continue
  else
    echo "false"
    exit 0
  fi
done

(( cp == op ))   || { echo "false"; exit 0; }
(( csb == osb )) || { echo "false"; exit 0; }
(( ocb == ccb )) || { echo "false"; exit 0; }

echo "true"
