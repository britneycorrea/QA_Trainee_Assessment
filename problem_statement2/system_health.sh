#!/bin/bash

# Define thresholds
CPU_THRESHOLD=80  # CPU usage threshold in percentage
MEMORY_THRESHOLD=80  # Memory usage threshold in percentage
DISK_THRESHOLD=80  # Disk usage threshold in percentage
LOG_FILE="system_health.log"

# Function to log alerts
log_alert() {
  local message=$1
  echo "$(date +'%Y-%m-%d %H:%M:%S') - ALERT: $message" >> $LOG_FILE
}

# Check CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "CPU Usage: $CPU_USAGE%"
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
  log_alert "CPU usage is above $CPU_THRESHOLD% (Current: $CPU_USAGE%)"
fi

# Check Memory usage
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo "Memory Usage: $MEMORY_USAGE%"
if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
  log_alert "Memory usage is above $MEMORY_THRESHOLD% (Current: $MEMORY_USAGE%)"
fi

# Check Disk usage
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
echo "Disk Usage: $DISK_USAGE%"
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
  log_alert "Disk usage is above $DISK_THRESHOLD% (Current: $DISK_USAGE%)"
fi

# Log running processes
echo "$(date +'%Y-%m-%d %H:%M:%S') - Running processes:" >> $LOG_FILE
ps -e >> $LOG_FILE

echo "System health check completed. Alerts (if any) logged to $LOG_FILE."
