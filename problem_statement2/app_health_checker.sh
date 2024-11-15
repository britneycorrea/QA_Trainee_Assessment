#!/bin/bash

# Application URL
APP_URL="http://your-application-url.com"  # Replace with the actual application URL
LOG_FILE="app_health.log"

# Check HTTP status code
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)

# Determine application status and log if down
if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Application is up."
else
  echo "$(date +'%Y-%m-%d %H:%M:%S') - ALERT: Application is down. Status code: $HTTP_STATUS" >> $LOG_FILE
fi

echo "Application health check completed. Alerts (if any) logged to $LOG_FILE."
