#!/bin/bash

# Define variables
THRESHOLD_CPU=80
THRESHOLD_MEM=80
THRESHOLD_DISK=90
ALERT_EMAIL="admin@example.com"
LOG_FILE="/path/to/health_monitor.log"
DATE=$(date +%Y%m%d_%H%M%S)

# Function to check CPU usage
check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$CPU_USAGE > $THRESHOLD_CPU" | bc -l) )); then
        echo "High CPU usage detected: $CPU_USAGE%" >> "$LOG_FILE"
        echo "High CPU usage detected: $CPU_USAGE%" | mail -s "CPU Alert" "$ALERT_EMAIL"
    fi
}

# Function to check memory usage
check_mem() {
    MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$MEM_USAGE > $THRESHOLD_MEM" | bc -l) )); then
        echo "High memory usage detected: $MEM_USAGE%" >> "$LOG_FILE"
        echo "High memory usage detected: $MEM_USAGE%" | mail -s "Memory Alert" "$ALERT_EMAIL"
    fi
}

# Function to check disk usage
check_disk() {
    DISK_USAGE=$(df -h | grep -E '^/dev/root' | awk '{print $5}' | sed 's/%//')
    if (( DISK_USAGE > THRESHOLD_DISK )); then
        echo "High disk usage detected: $DISK_USAGE%" >> "$LOG_FILE"
        echo "High disk usage detected: $DISK_USAGE%" | mail -s "Disk Alert" "$ALERT_EMAIL"
    fi
}

# Log the date and time of the check
echo "Health check started: $DATE" >> "$LOG_FILE"

# Perform the health checks
check_cpu
check_mem
check_disk

# Log the completion of the check
echo "Health check completed: $DATE" >> "$LOG_FILE"

