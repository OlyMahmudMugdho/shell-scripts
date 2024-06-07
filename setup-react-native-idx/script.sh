#!/bin/bash

# Kill processes using ports 9101, 9102, 5555, and 5037
kill $(lsof -t -i:9101)
kill $(lsof -t -i:9102)
kill $(lsof -t -i:5555)
kill $(lsof -t -i:5037)

# Remove all files in the current directory
rm -rf *

# Extract the last nameserver IP address from /etc/resolv.conf
nameserver_ip=$(cat /etc/resolv.conf | tail -n1 | cut -d " " -f 2)

# Set up a bidirectional data relay between TCP-LISTEN:5554 and the extracted nameserver IP on port 5554
socat -d -d TCP-LISTEN:5554,reuseaddr,fork TCP:$nameserver_ip:5554
