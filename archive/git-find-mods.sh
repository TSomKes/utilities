#!/bin/bash

# Identifies git repos with uncommitted changes.
#
# Notes:
# - Assumes repos are stored in one directory
#   - Repos are immediately under the directory
# - Repo-containing directory is hard-coded
#
# Inspired by https://gist.github.com/mzabriskie/6631607.
# (Substantially changed from the original.)

# Hard-code-tastic!
reposDir=~/code

cd $reposDir

for f in $reposDir/*
do
	# Not a directory?  Skip.
	[ -d "${f}" ] || continue

	# Not a git repo?  Skip.
	[ -d "$f/.git" ] || continue

    cd $f

    modCount=0
    modCount=$(git status | grep modified -c)

    untrackedCount=0
    untrackedCount=$(git status | grep Untracked -c)

    # If any uncommitted files are found, show the repo's status
    if [ $modCount -ne 0 ] || [ $untrackedCount -ne 0 ]
    then
        echo "${f}"

        if [ $modCount -ne 0 ]
        then
            echo "  - mods"
        fi

        if [ $untrackedCount -ne 0 ]
        then
            echo "  - untracked"
        fi
    fi
done
