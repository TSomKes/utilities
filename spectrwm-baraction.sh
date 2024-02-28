#!/bin/sh

SLEEP_SEC=5

while :; do

    # Screen brightness
    MAX_BRIGHT=`cat /sys/class/backlight/intel_backlight/max_brightness`
    BRIGHT=`cat /sys/class/backlight/intel_backlight/actual_brightness`
    RELATIVE_BRIGHT=$((100 * $BRIGHT / $MAX_BRIGHT))

    # Volume
    V_LVL=`amixer sget Master | \
        awk -F"[][]" '/Left:/ { print $2 }'`

    V_MUTE=''
    V_STATE=`amixer sget Master \
        | awk '/Left:/ {print $6}' \
        | sed "s/[^a-z]//g"`
    if [ $V_STATE = 'off' ]; then
        V_MUTE='m'
    fi

    # Battery (e.g. -75%, +42%)
    B_CAP=`cat /sys/class/power_supply/BAT0/capacity`

    B_SYM=''
    B_STATE=`cat /sys/class/power_supply/BAT0/status`
    if [ $B_STATE = 'Disharging' ]; then
        B_SYM='-'
    elif [ $B_STATE = 'Charging' ]; then
        B_SYM='+'
    else
        # both 'Charging' and 'Unknown' seem to indicate charging
        # ...except recent experience has shown it happening while discharging
        B_SYM='?'
    fi

    echo " ${RELATIVE_BRIGHT}% | v ${V_MUTE}${V_LVL} | b ${B_SYM}${B_CAP}% | "

    sleep $SLEEP_SEC

done
