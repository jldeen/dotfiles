#!/bin/bash

HEART='❤'

battery_info=`pmset -g batt`
current_charge=$(echo $battery_info | grep -o '[0-9]\+%' | awk '{sub (/%/, "", $1); print $1}')

if [[ $current_charge -lt 30 ]]; then
    echo -n '#[fg=colour31]'
elif [[ $current_charge -lt 50 ]]; then
    echo -n '#[fg=colour32]'
elif [[ $current_charge -lt 70 ]]; then
    echo -n '#[fg=colour33]'
elif [[ $current_charge -lt 90 ]]; then
    echo -n '#[fg=colour34]'
else
    echo -n '#[fg=colour35]'
fi

echo -n "$HEART $current_charge%"
