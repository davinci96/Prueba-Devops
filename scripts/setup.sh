#!/bin/bash

# Write the setup script
cat <<'EOF' > /tmp/setup.sh
#!/bin/bash

# Update the system
sudo apt-get update

# Install necessary packages
sudo apt-get install -y nginx ca-certificates curl stress python3-pip awscli

# Start the SSM agent
sudo systemctl start amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent

# Stop any conflicting web servers
sudo systemctl stop apache2

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Restart and check Nginx status
sudo systemctl restart nginx
sudo systemctl status nginx

EOF

# Make the setup script executable
chmod +x /tmp/setup.sh

# Write the monitoring script
cat <<'EOF' > /tmp/monitor.sh
#!/bin/bash

# Function to simulate high CPU load (optimized for t2.micro with 1 vCPU)
stress_test() {
    echo "Starting CPU stress test for 1 minute on a single CPU core..."
    stress --cpu 1 --timeout 60
    echo "CPU stress test completed."
}

# Function to collect system metrics
collect_metrics() {
    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    OUTPUT_FILE="/tmp/system_metrics_$TIMESTAMP.txt"

    echo "Collecting system metrics at $TIMESTAMP..."
    echo "=== CPU and Memory Usage ===" > $OUTPUT_FILE
    top -b -n 1 | head -10 >> $OUTPUT_FILE

    echo -e "\n=== Disk Usage ===" >> $OUTPUT_FILE
    df -h >> $OUTPUT_FILE

    echo -e "\n=== Network Usage ===" >> $OUTPUT_FILE
    ifconfig >> $OUTPUT_FILE

    echo -e "\n=== Running Processes ===" >> $OUTPUT_FILE
    ps aux --sort=-%mem | head -10 >> $OUTPUT_FILE

    echo "System metrics collected in $OUTPUT_FILE."
}

# Run stress test and collect metrics
stress_test
collect_metrics
EOF

# Make the monitoring script executable
chmod +x /tmp/monitor.sh
