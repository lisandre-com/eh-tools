#!/bin/bash
#------------------------------------------------------------------------------
# Name        : proxy.sh
# Description : Automate appropriate proxy configuration using cntlm
# Author      : Lisandre.com
# Date        : 2019-11-25
# Prereq      : Install cntlm and edit proxy configuration in /etc/cntlm.conf
#               eth1 is used. Edit script as needed.
#------------------------------------------------------------------------------
IP="`ifconfig eth1 | grep 'inet ' | awk '{print $2}'`"
echo "Current IP: $IP"

# Terminate any cntlm commands running
ps aux | grep [c]ntlm | awk '{print $2}' | xargs kill 2>&1
sleep 30s

# No proxy, start in foreground
if [[ "$IP" =~ "192.168." ]]; then
    echo "No proxy..."
    cntlm -f -N "*"

# Corporate proxy, start in foreground
else
    echo "Corporate proxy..."
    cntlm -f
fi
