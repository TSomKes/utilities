#!/bin/sh
#

SLEEP_SEC=5  
while :; do

    # Battery (e.g. -75%, +42%)
    B_CAP=`cat /sys/class/power_supply/BAT0/capacity`

    B_SYM=' '
    B_STATE=`cat /sys/class/power_supply/BAT0/status`
    if [ $B_STATE = 'Charging' ]; then
        B_SYM='+'
    elif [ $B_STATE = 'Discharging' ]; then
        B_SYM='-'
    fi

    # Volume
    V_LVL=`amixer sget Master \
        | awk 'NR==5{print $4}' \
        | sed "s/[^0-9]//g"`

    V_MUTE=' '
    V_STATE=`amixer sget Master \
        | awk 'NR==5{print $6}' \
        | sed "s/[^a-z]//g"`
    if [ $V_STATE = 'off' ]; then
        V_MUTE='m'
    fi

    echo "${V_MUTE}${V_LVL}% | ${B_SYM}${B_CAP}%"

    sleep $SLEEP_SEC
done
