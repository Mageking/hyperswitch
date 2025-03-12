#!/bin/bash

# Fetch the EC2 public IP
EC2_PUBLIC_IP=$(curl -s ifconfig.me)

# Ensure the IP is retrieved
if [[ -z "$EC2_PUBLIC_IP" ]]; then
  echo "Failed to retrieve EC2 public IP."
  exit 1
fi

echo "EC2 Public IP: $EC2_PUBLIC_IP"

# Add to /etc/environment for system-wide persistence
if grep -q "EC2_PUBLIC_IP=" /etc/environment; then
  sudo sed -i "s|EC2_PUBLIC_IP=.*|EC2_PUBLIC_IP=$EC2_PUBLIC_IP|" /etc/environment
else
  echo "EC2_PUBLIC_IP=$EC2_PUBLIC_IP" | sudo tee -a /etc/environment
fi

# Apply the variable immediately for the current session
export EC2_PUBLIC_IP=$EC2_PUBLIC_IP

echo "EC2_PUBLIC_IP has been set and will persist across reboots."
