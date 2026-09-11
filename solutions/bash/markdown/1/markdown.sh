#!/usr/bin/env bash

((inside_a_list = 0))
while IFS= read -r line; do
  # Parse and render __bold__ segments
  if [[ $line =~ ^(.*)__(.+)__(.*)$ ]]; then
    pre=${BASH_REMATCH[1]}
    bold=${BASH_REMATCH[2]}
    post=${BASH_REMATCH[3]}
    line="${pre}<strong>${bold}</strong>${post}"
  fi

  # Parse and render _italicized_ segments
  if [[ $line =~ ^(.*)_(.+)_(.*)$ ]]; then
    pre=${BASH_REMATCH[1]}
    italic=${BASH_REMATCH[2]}
    post=${BASH_REMATCH[3]}
    line="${pre}<em>${italic}</em>${post}"
  fi

  # Parse and render headers <h1> ... <h6>
  if [[ $line =~ ^(#{1,6})[[:space:]]+(.+)$ ]]; then
    n=${#BASH_REMATCH[1]}
    header=${BASH_REMATCH[2]}
    html+="<h${n}>${header}</h${n}>"
  # Parse and render list items
  elif [[ "$line" =~ ^\*[[:space:]]+(.+)$  ]]; then
    item=${BASH_REMATCH[1]}
    # If not already in a list, start the list
    if ((! inside_a_list)); then
      html+="<ul>"
      ((inside_a_list = 1))
    fi
    html+="<li>${item}</li>"
  else
    # If we started a list, end the list since we're no longer in a list
    if ((inside_a_list)); then
      html+="</ul>"
      ((inside_a_list = 0))
    fi

    # Anything that's not a header or list item is a paragraph
    html+="<p>$line</p>"
  fi
done < "$1"

# If no longer in a list and we've processed all the lines, end the list
if ((inside_a_list)); then
  html+="</ul>"
fi

echo "$html"
