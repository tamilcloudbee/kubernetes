#!/usr/bin/bash


read -p "Enter the hostname to be set for this computer: " host_name
USER=$(whoami)
if ! sudo grep -q "^$USER ALL=(ALL) NOPASSWD:ALL" /etc/sudoers; then
    echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
else
    echo "User $USER is already in sudoers with NOPASSWD."
fi

sudo hostnamectl set-hostname $host_name
sudo timedatectl set-timezone Asia/Kolkata

# check whether Swap is on or not - turn off swap if it is ON

if sudo swapon --show | grep -q .; then
    echo "Swap is active. Turning it off..."
    sudo swapoff -a
    echo "Swap has been turned off."
else
    echo "Swap is already off."
fi

# Turn off swap permanently by commenting the line containing swap in /etc/fstab
sudo sed -i '/swap/s/^/#/' /etc/fstab

# Disable Firewall
sudo ufw disable


sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/modules-load.d/k8s.conf <<EOF
overlay
br_netfilter
EOF

# Kubernetes networking - update the sysctl settings 

sudo tee /etc/sysctl.d/kubernetes.conf <<EOT
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOT
