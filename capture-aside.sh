#!/usr/bin/env bash

note=$(vipe)

if [ -z "${WSL_DISTRO_NAME}" ]; then
    asidefile="$HOME/notes/pa/asides-desky.md"
else
    asidefile="$HOME/notes/pa/asides-lappy.md"
fi

# Update file if we got something from the editor
if [[ -n $note ]]; then 
    output=$'## '$(date +"%Y-%m-%d %a %R")
    output+=$'\n'
    output+=$note
    output+=$'\n\n'
    echo "$output" >> "$asidefile"
fi
