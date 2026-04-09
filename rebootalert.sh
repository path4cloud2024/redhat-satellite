#!/bin/bash 
#######################################################################################
#Script Name    :rebootalert.sh                                                       #
#Description    :send email alert when server gets rebooted                           # 
#######################################################################################

## get uptime value of server  
uptime=$(echo $(awk '{print $1}' /proc/uptime) / 60 | bc)

## check if uptime value is less or equals to 10 minutes 
if [[ "$uptime" -le 10  ]]; then
        
## send email if system rebooted
mail -s 'Server Reboot Alert' surender.rawat@standard.com <<< "This is an automated message to notify you that "`hostname`" is recently rebooted"
fi

exit 0
