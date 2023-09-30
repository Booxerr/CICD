#!/bin/bash

# Check if the script is run as root or with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

# Install kubectl
if ! [ -x "$(command -v kubectl)" ]; then
  echo "Installing kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  mv kubectl /usr/local/bin/
  echo "kubectl installed successfully."
else
  echo "kubectl is already installed."
fi

# Install minikube
if ! [ -x "$(command -v minikube)" ]; then
  echo "Installing minikube..."
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  install minikube-linux-amd64 /usr/local/bin/minikube
  echo "minikube installed successfully."
else
  echo "minikube is already installed."
fi

# Verify installation
echo "Verifying kubectl and minikube installation..."
kubectl version --client
minikube version

echo "Kubectl and minikube installation completed."
