#!/bin/bash

# Step 1: Create the 'cyber' user with sudo privileges
sudo useradd -m -s /bin/bash cyber
echo "cyber:cyber" | sudo chpasswd
sudo usermod -aG sudo cyber

# Step 2: Ensure the 'cyber' user has a home directory with appropriate permissions
sudo mkdir -p /home/cyber
sudo chown cyber:cyber /home/cyber

# Step 3: Ensure the 'cyber' user has sufficient privileges
echo "cyber ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/cyber

echo "User 'cyber' has been created with appropriate privileges."
