#!/usr/bin/env bash

# Capture a thought/question/mystery in a "card" file for later follow-up

QCPATH="$HOME/notes/dev/query-cards/"

note=$(vipe)

# Update file if we got something from the editor
if [[ -n $note ]]; then 

    # Hash note for filename prefix:  453d1_whatever_was_in_firstline.md
    # Note:  not trying to avoid collisions; simply looking for a short handle
    # (I expect a lot of card files will share starting words; this should make
    # handling them individually easier.)
    hashed=$(sha1sum <<< "$note")
    shortHash=${hashed:0:5}

    # first line of text --> filename
    # Note:  doesn't check for visible characters; blank-ish filename possible
    firstLine=$(echo "$note" | head -1)

    # Ellis Island-ify some characters that would require escapes or quotes
    filename="${firstLine// /_}"
    filename="${filename//[^a-zA-Z0-9._-]/}"
    filename="$filename".md

    filepath="$QCPATH$shortHash"_"$filename"

    echo "$note" >> "$filepath"
fi
