#!/bin/bash

# Install necessary packages
sudo apt-get update
sudo apt-get install -y git amazon-efs-utils vim-nox neofetch htop tmux curl wget 

# Create new user with sudo privileges
sudo useradd -m -s /bin/bash greg
sudo usermod -aG sudo greg

# Add authorized keys for your public key
sudo mkdir -p /home/greg/.ssh
sudo touch /home/greg/.ssh/authorized_keys
sudo chmod 700 /home/greg/.ssh
sudo chmod 600 /home/greg/.ssh/authorized_keys
sudo chown -R greg:greg /home/greg/.ssh

# Add your public key to authorized_keys
sudo echo "" >> /home/greg/.ssh/authorized_keys

# Set hostname
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
HOSTNAME="$INSTANCE_ID-$AVAILABILITY_ZONE"
sudo hostnamectl set-hostname $HOSTNAME

# Run cloud-init.sh script
sudo sh /path/to/cloud-init.sh
