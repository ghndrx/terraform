#!/bin/bash

# Install necessary packages
sudo apt-get update
sudo apt-get install -y git amazon-efs-utils vim-nox neofetch htop tmux curl wget nginx

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
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCdOF80z0piQEnYzNCu2OGvOJdm7+3wfDuiC+Jzi8VbSC5VW4iJAQXOuDNGLzyqNi6uMjI77xpEL6Xzn29uJiQti6Y/LxhOZwNNIQiGUpFco1wkBYeBFbtgHQxsMLwumrxQGEj2fyCiSrACAPyy/l1fP4mlN7abBGD5aozBrYKxXPS/kfwO5nsWmw27RgTzfHJzie2dUU3ew/kd7td3wEdWrRXq8wNbu+yvAyiog54huUUWmYZwY3QVwXr6R1wsVudawM6BEl45QFq+hdB4t83azHG94XLy2NCAncohdU7zP40nsbvIDyh+4wIKeU90z6TLrXfHUYuBT6/ky7qOFm/Ym1QG4zCDz3jin8Qoa31PGaObzj/zoMJXgOXKcp16W0j9SZAenvnSfuWUEfBR1yBRR0T5Wg5v1vi7KGBTATaz8el802uliL+yZbGtMbNpAPGR5nK5C4yorf8yVYvIgo/LJaWCDND2O1e2mdut1WyRmvIwMnq7PFZT8zAsgGXfhDM= greg@ligma" >> /home/greg/.ssh/authorized_keys

# Set hostname
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
HOSTNAME="$INSTANCE_ID-$AVAILABILITY_ZONE"
sudo hostnamectl set-hostname $HOSTNAME

echo "hello world" >> /var/www/html/index.html
systemctm restart nginx

# Run cloud-init.sh script
# sudo sh /path/to/cloud-init.sh
