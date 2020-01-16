#!/bin/bash

# Internal IP
IP=$(hostname -I | awk {'print $1}')

# Packet loss check
timeout 7s ping -c 5 google.com | grep 'loss' | awk '{print $6}' > /dev/null 2>&1
if [[ $? -eq 0 ]]
    then
        PL=$(ping -c 5 google.com | grep 'loss' | awk '{print $6}')
        PL+=" p/l"
    else
        PL=""
fi

# Speedtest
DL=$(speedtest-cli --simple | awk 'NR==2{print $2}')
UP=$(speedtest-cli --simple | awk 'NR==3{print $2}')

PUBLIC_IP=$(curl -4 ifconfig.co)

if [[ "$PUBLIC_IP" = ";; connection timed out; no servers could be reached" ]]; then 
    PUBLIC_IP="Not Available"
elif [[ "$PUBLIC_IP" = "" ]]; then
    PUBLIC_IP="No external access"
else 
    PUBLIC_IP=$(curl -4 ifconfig.co)
fi
 
INTERNET=''

#internet_info=`iwconfig eth0 | grep "Signal level" | awk '{print $2}' | sed 's/-//g'`

# if [[ $internet_info -lt 20 ]]; then
#     echo -n '#[fg=colour150]'
# elif [[ $internet_info -lt 30 ]]; then
#     echo -n '#[fg=colour155]'
# elif [[ $internet_info -lt 40 ]]; then
#     echo -n '#[fg=colour160]'
# elif [[ $internet_info -lt 50 ]]; then
#     echo -n '#[fg=colour163]'
# else
#     echo -n '#[fg=colour150]'
# fi

echo -n "#[fg=colour150]$INTERNET #[fg=colour197]$IP | $PUBLIC_IP"
