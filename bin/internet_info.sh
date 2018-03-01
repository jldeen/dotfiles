#!/bin/bash

#IP=$(ipconfig getifaddr wifi0)
IP=$(hostname -I | awk {'print $1}')

# # Public IP
PUB_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

if [[ "$PUB_IP" = ";; connection timed out; no servers could be reached" ]]; then 
    PUB_IP="Not Available"
elif [[ "$PUB_IP" = "" ]]; then
    PUB_IP="No external access"
else 
    PUB_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
fi

INTERNET=''

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

echo -n "#[fg=colour60]$INTERNET #[fg=colour60]$IP | $PUB_IP"