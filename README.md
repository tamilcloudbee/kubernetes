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

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

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
