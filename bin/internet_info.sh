#!/bin/bash

# Internal IP
IP=$(ipconfig getifaddr en0)

# Packet loss check
gtimeout 7s ping -c 5 google.com | grep 'loss' | awk '{print $7}' > /dev/null 2>&1
if [[ $? -eq 0 ]]
    then
        PL=$(ping -c 5 google.com | grep 'loss' | awk '{print $7}')
        PL+=" p/l"
    else
        PL=""
fi

# Speedtest
DL=$(cat ~/bin/bandwidth.log | awk 'NR==2{print $2}')
UP=$(cat ~/bin/bandwidth.log | awk 'NR==3{print $2}')

# # Public IP
PUB_IP=$(cat ~/bin/bandwidth.json | jq -r .client.ip)

if [[ "$PUB_IP" = ";; connection timed out; no servers could be reached" ]]; then 
    PUB_IP="Not Available"
elif [[ "$PUB_IP" = "" ]]; then
    PUB_IP="No external access"
else 
    PUB_IP=$(cat ~/bin/bandwidth.json | jq -r .client.ip)
fi
 
INTERNET=''

internet_info=`airport -I | grep agrCtlRSSI | awk '{print $2}' | sed 's/-//g'`

if [[ $internet_info -lt 20 ]]; then
    echo -n '#[fg=colour116]'
elif [[ $internet_info -lt 30 ]]; then
    echo -n '#[fg=colour117]'
elif [[ $internet_info -lt 40 ]]; then
    echo -n '#[fg=colour118]'
elif [[ $internet_info -lt 50 ]]; then
    echo -n '#[fg=colour119]'
else
    echo -n '#[fg=colour120]'
fi

echo -n "$INTERNET  -[$internet_info]db | #[fg=colour81]$PL #[fg=colour86]$DL Mbit/s $UP Mbit/s #[fg=colour197]$IP | $PUB_IP"
