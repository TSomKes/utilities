#!/usr/bin/sh

# Render Markdown locally.
# - For previewing .md files destined for GitHub, etc.


# Verify temp directory
mkdir --parents ~/.temp

# No stdin, just file path argument
input="${@}"

# Grab arguments
# - Arguments plural:  multiple .md files is okay, they'll be concatenated
# - No arguments = exit
# - Maybe someday allow input from stdin, for shell-repl-like behavior?
#   - https://zwbetz.com/passing-input-to-a-bash-function-via-arguments-or-stdin/
if [ -z "${input}" ]; then
    return 1
fi

# Markdown --> temp HTML via Pandoc
pandoc --from=markdown --to=html $input > ~/.temp/temp.html

# temp HTML --> Firefox
firefox ~/.temp/temp.html

# Clean up
rm ~/.temp/temp.html
