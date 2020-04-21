#!/usr/bin/bash

#STEP=0

while true; do
    
    # Things done every cycle

    # /sys/class battery info via https://askubuntu.com/a/309146/19202
    BATT_STAT=`cat /sys/class/power_supply/BAT0/status`
    BATT_STAT_SYMBOL=''

    if [[ $BATT_STAT == 'Charging' ]]; then
        BATT_STAT_SYMBOL='+'
    elif [[ $BATT_STAT == 'Discharging' ]]; then
        BATT_STAT_SYMBOL='-'
    fi

    BATT_CAP=`cat /sys/class/power_supply/BAT0/capacity`

    BATT=${BATT_STAT_SYMBOL}${BATT_CAP}

    DATETIME="$(date +'%Y-%M-%d %a %R')"

    # Things done every 4th cycle
#    if [[ $STEP -eq 0 ]]; then
#        BATTERY="battery"
#    fi

#    ((STEP++))

    xsetroot -name "${BATT}% | ${DATETIME}"

    # Reset 
#    if [[ $STEP -ge 3 ]]; then
#        STEP=0
#    fi

    # Run every 15 seconds
    sleep 15 

done
