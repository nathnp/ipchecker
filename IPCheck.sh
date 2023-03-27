#!/bin/bash

# Check if there is internet connectivity
ping -q -c 1 google.com >/dev/null 2>&1

if [ $? -eq 0 ]; then
  # If there is internet connectivity, print both local and public IPv4 addresses
  local_ip=$(hostname -I | awk '{print $1}')
  if [ -z "$local_ip" ]; then
    echo "Error: No local IP address found"
    exit 1
  fi
  public_ip=$(curl -s http://checkip.dyndns.org | sed 's/[a-zA-Z/<> :]//g')
  echo "Local IP: $local_ip"
  echo "Public IP: $public_ip"
else
  # If there is no internet connectivity, print local IPv4 address and error for public IPv4 address
  local_ip=$(hostname -I | awk '{print $1}')
  if [ -z "$local_ip" ]; then
    echo "Error: No local IP address found"
    exit 1
  fi
  echo "Local IP: $local_ip"
  echo "Error: No internet connection, public IP address unavailable"
fi

exit 0

