#!/usr/bin/sh

# Open one or more terminal panes.
# Useful for my dev projects.

# Default to 1
NUM=${1:-1}

# Min 1, max 4, default to 1 (for bad value)
if [ $NUM -gt 0 ]
then
    if [ $NUM -gt 4 ] 
    then 
        NUM=4
    fi
else
    NUM=1
fi


# Make some windows
i=0
while [ $i -lt $NUM ]
do 
    kitty -d $PWD &
    i=$((i+1))
done
