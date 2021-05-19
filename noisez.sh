#!/usr/bin/sh

# Use sox to make brown noise
# (Some of this via https://gist.github.com/rsvp/1209835.)


# Fight with shell script!
#
# Rather than deal in the 0 - 1 range sox likes, let's just do 1-10.
VOL=${1:-5}

# Min 0.1, max 1.0, default to 0.5
if [ $VOL -gt 0 ]
then
    if [ $VOL -gt 10 ] 
    then 
        VOL=10
    fi

    if [ $VOL -lt 1 ]
    then 
        VOL=1
    fi
else
    VOL=5
fi

VOL=`echo "scale=1; $VOL / 10" | bc -l`

# Generate 1 minute; repeat for 4 hours.
play -c 2 -n synth 01:00 brownnoise vol $VOL repeat 240
