#!/bin/bash
#------------------------------------------------------------------------------
# Name        : dns_transfer.sh
# Description : Discover and attempt a zone transfer on each DNS server found
# Author      : Lisandre.com
# Date        : 2018-08-28
#------------------------------------------------------------------------------

# If the wrong number of arguments was provided
if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "$0 DOMAIN"
    echo "Example:"
    echo "$0 megacorpone.com"

# If the right number of argument was provided
else
    DOMAIN="$1"

    # List DNS servers for the domain
    for server in $(host -t ns $DOMAIN | cut -d " " -f4); do

        # For each of these servers, attempt a zone transfer
        host -l $DOMAIN $server | grep "has address"
    done
fi
