# vuln_hr
Vulnerable HR Machine

# Description of the Vulnerable Machine

## Overview
The vulnerable machine is a simulated environment designed to mimic a compromised server within our network. It is built on an Ubuntu 24.04 server and incorporates various elements that simulate a real-world cybersecurity threat. This machine serves as a practical training ground for cybersecurity operators to identify, analyse, and mitigate potential security incidents.

## Key Features

1. **Malware Simulation:**
    - **Malware Scripts:** Two scripts (`malware.sh` and `exploit.py`) are created in the `/opt/vulnerable` directory. These scripts simulate malicious activities such as executing commands and making unauthorised connections.
    - **Cron Jobs:** These scripts are scheduled to run at regular intervals using cron jobs, mimicking persistent malware that continuously attempts to execute harmful actions.
2. **Network Traffic Simulation:**
    - **Fake Network Connections:** The machine simulates network traffic by periodically executing `curl` commands to fetch data from fake malicious servers (`malicious-server.com` and `another-malicious-server.com`). This activity is logged, providing realistic traces of outbound traffic that can be analysed by the cybersecurity team.
3. **SSH Log Simulation:**
    - **Fake SSH Entries:** The machine's authentication logs (`/var/log/auth.log`) are populated with entries indicating successful SSH connections from suspicious IP addresses. This helps in identifying unauthorised access attempts.
4. **Log Rotation Configuration:**
    - **Continuous Log Activity:** A log rotation configuration is set up to simulate continuous log activity. This ensures that the logs grow and rotate as they would on an active server, providing a realistic logging environment for analysis.
5. **Firewall Configuration:**
    - **Security Hardening:** The machine's firewall (UFW) is enabled and configured to allow SSH access while blocking specific suspicious IP addresses. This simulates a scenario where certain IPs are identified and blocked as part of incident response.

## Purpose

The primary objective of this vulnerable machine is to provide a controlled environment for cybersecurity training. It allows operators to practise detecting and responding to various security incidents, including malware infection, unauthorised access, and suspicious network activity. By working through this simulated scenario, operators can enhance their skills in log analysis, network traffic inspection, malware identification, and system hardening.

## Use Case

During training, the cybersecurity operators will:

1. **Analyse Logs:** Identify unauthorised SSH connections and unusual network traffic by examining the system logs.
2. **Inspect and Remove Cron Jobs:** Detect and remove the cron jobs that are scheduling the execution of malicious scripts.
3. **Isolate and Remove Malware:** Stop the running malicious processes and remove the malware files from the system.
4. **Apply System Hardening:** Update the system, configure the firewall, and block identified malicious IP addresses to secure the machine.
5. **Verify Security:** Continuously monitor the logs to ensure that no further malicious activities are occurring.

This vulnerable machine provides a comprehensive, hands-on training experience that prepares cybersecurity operators to handle real-world security incidents effectively.

By simulating a realistic threat environment, the machine helps in improving the team's ability to respond to and mitigate cybersecurity threats, ultimately enhancing the overall security posture of our organisation.
