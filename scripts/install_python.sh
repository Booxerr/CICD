#!/bin/bash

# Check if the script is run as root or with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    source /etc/os-release
else
    echo "Unable to detect the Linux distribution. Please install Python manually."
    exit 1
fi

# Install Python based on the distribution
if [ "$ID" == "ubuntu" ] || [ "$ID" == "debian" ]; then
    apt update
    apt install -y python3
elif [ "$ID" == "centos" ] || [ "$ID" == "rhel" ]; then
    yum install -y python3
elif [ "$ID" == "fedora" ]; then
    dnf install -y python3
else
    echo "Unsupported Linux distribution. Please install Python manually."
    exit 1
fi

# Check Python version
python3 --version

echo "Python installation completed."
