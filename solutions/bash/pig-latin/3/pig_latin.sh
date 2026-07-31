#!/usr/bin/env bash

#!/usr/bin/env bash

# Mostly stolen from @glennj's elegant use of regex capture groups.

regex=(
    '^([aeiou]|yt|xr)'   # apple, xray
    '^(.?qu)(.*)'        # square, quit
    '^([^aeiou]+)(y.*)'  # rhythm, my
    '^([^aeiou]+)(.*)'   # square
)

igpay_aysay() {
    local word="$1"

    if [[ "$word" =~ ${regex[0]} ]]; then
        printf "%say\n" "$word"
    elif [[ "$word" =~ ${regex[1]} ]] ||
         [[ "$word" =~ ${regex[2]} ]] ||
         [[ "$word" =~ ${regex[3]} ]]
    then
        printf "%s%say\n" "${BASH_REMATCH[2]}" "${BASH_REMATCH[1]}"
    fi
}

main() {
    local words=()
    read -ra words <<< "$@"

    local igpays=()
    for word in "${words[@]}"; do
        igpays+=("$(igpay_aysay "$word")")
    done

    echo "${igpays[*]}"
}

main "$@"
