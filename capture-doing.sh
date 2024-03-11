#!/usr/bin/env bash

read -p "Whatcha doin'?  " -r doing
trimmed=$(echo "$doing" | xargs)

if [ -n "${WSL_DISTRO_NAME}" ]; then
    doingfile="$HOME/notes/pa/doing-desky.md"
else
    doingfile="$HOME/notes/pa/doing-lappy.md"
fi

# Update file if we got something from the editor
if [[ -n $trimmed ]]; then 
    output=$(date +"%Y-%m-%d %a %R")
    output+=': '
    output+=$trimmed
    echo "$output" >> "$doingfile"
fi
