#!/bin/bash

#IP=$(ipconfig getifaddr wifi0)
IP=$(hostname -I | awk {'print $1}')
PUB_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

INTERNET=''

#internet_info=`airport -I | grep agrCtlRSSI | awk '{print $2}' | sed 's/-//g'`

if [[ $internet_info -lt 20 ]]; then
    echo -n '#[fg=colour150]'
elif [[ $internet_info -lt 30 ]]; then
    echo -n '#[fg=colour155]'
elif [[ $internet_info -lt 40 ]]; then
    echo -n '#[fg=colour160]'
elif [[ $internet_info -lt 50 ]]; then
    echo -n '#[fg=colour163]'
else
    echo -n '#[fg=colour150]'
fi

echo -n "#[fg=colour60]$INTERNET  -[$internet_info]db #[fg=colour60]$IP | $PUB_IP"


