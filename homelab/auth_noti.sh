#!/bin/bash

# Discord webhook URL
WEBHOOK_URL="https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"

# Parameters
EVENT_TYPE=$1          # "Login" or "Logout"
USERNAME=$2            # Username
IP_ADDRESS=$3          # IP address of the user
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")  # Current timestamp in ISO 8601 format

# Determine the embed color (Green for Login, Red for Logout)
if [ "$EVENT_TYPE" == "Login" ]; then
  COLOR=65280
else
  COLOR=16711680
fi

# Create JSON payload
JSON_PAYLOAD=$(cat <<EOF
{
  "embeds": [
    {
      "title": "🔔 User Authentication Notification",
      "description": "A user has ${EVENT_TYPE,,}ed to the server.",
      "color": $COLOR,
      "fields": [
        {
          "name": "👤 Username",
          "value": "$USERNAME",
          "inline": true
        },
        {
          "name": "🌐 IP Address",
          "value": "$IP_ADDRESS",
          "inline": true
        },
        {
          "name": "🕒 Timestamp",
          "value": "$TIMESTAMP",
          "inline": false
        }
      ],
      "footer": {
        "text": "Homelab Authentication System"
      }
    }
  ]
}
EOF
)

# Send the notification to Discord
curl -H "Content-Type: application/json" -X POST -d "$JSON_PAYLOAD" "$WEBHOOK_URL"
