#!/bin/bash

# Function to kill process if running on a specific port
kill_if_running() {
  port=$1
  pid=$(lsof -t -i:$port)
  if [ -n "$pid" ]; then
    kill $pid
    echo "Killed process on port $port (PID: $pid)"
  else
    echo "No process running on port $port"
  fi
}

# Kill processes using ports 9101, 9102, 5555, and 5037 if they are running
kill_if_running 9101
kill_if_running 9102
kill_if_running 5555
kill_if_running 5037

# Remove all files in the current directory
# rm -rf *
echo "Removed all files in the current directory"

# Extract the last nameserver IP address from /etc/resolv.conf
nameserver_ip=$(cat /etc/resolv.conf | tail -n1 | cut -d " " -f 2)

# Set up a bidirectional data relay between TCP-LISTEN:5554 and the extracted nameserver IP on port 5554
socat -d -d TCP-LISTEN:5554,reuseaddr,fork TCP:$nameserver_ip:5554
