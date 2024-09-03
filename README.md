# kubernetes
## Installing kubernetes in Ubuntu 24.04 LTS Server

| Hostname   | IP address  | OS Verion  | RAM | CPU |
|------------|------------|------------|------------|------------|
| kmaster |  172.51.51.50 | Ubuntu 24.04 LTS Server | 4  | 2 |
| node1   |  172.51.51.60 | Ubuntu 24.04 LTS Server | 8  | 2 |
| node2   |  172.51.51.70 | Ubuntu 24.04 LTS Server | 8  | 2 |


### The following Block 1 & Block 2 is common for all Nodes
### NOTE : Change / Modify the host_name value when running the following block in different machines

### Block 1
```
host_name="kmaster"
USER=$(whoami)
if ! sudo grep -q "^$USER ALL=(ALL) NOPASSWD:ALL" /etc/sudoers; then
    echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
else
    echo "User $USER is already in sudoers with NOPASSWD."
fi

sudo hostnamectl set-hostname kmaster
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
ufw disable


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

```
## Install Docker (CE) in all the nodes 

### Follow installation steps given in the followin Docker website

### Reference : https://docs.docker.com/engine/install/ubuntu/

### Block 2

```
# Add Docker's official GPG key:

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

 sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


```
