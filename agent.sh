#!/bin/bash

# Persor AI Terminal Agent Client
# Usage: ./agent.sh [API_URL]

API_URL="${1:-https://persorai.com}"
CHAT_ENDPOINT="$API_URL/api/chat"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}
 ____                               _    ___ 
|  _ \ ___ _ __ ___  ___  _ __     / \  |_ _|
| |_) / _ \ '__/ __|/ _ \| '__|   / _ \  | | 
|  __/  __/ |  \__ \ (_) | |     / ___ \ | | 
|_|   \___|_|  |___/\___/|_|    /_/   \_\___|
${NC}"
echo -e "${BLUE}Connecting to Persor AI Node at $API_URL...${NC}"
echo "Type 'exit' to quit."
echo ""

while true; do
    echo -ne "${GREEN}root@persor:~$ ${NC}"
    read -r message

    if [[ "$message" == "exit" ]]; then
        echo "Disconnecting..."
        break
    fi

    if [[ -z "$message" ]]; then
        continue
    fi

    # Send request to API
    # We use curl to send POST request
    response=$(curl -s -X POST "$CHAT_ENDPOINT" \
        -H "Content-Type: application/json" \
        -d "{\"message\": \"$message\"}")

    # Parse JSON response using grep/sed (simple implementation to avoid jq dependency)
    # Ideally, install jq: pkg install jq
    
    if command -v jq &> /dev/null; then
        reply=$(echo "$response" | jq -r '.reply // empty')
        error=$(echo "$response" | jq -r '.error // empty')
    else
        # Fallback parsing
        reply=$(echo "$response" | grep -o '"reply":"[^"]*' | sed 's/"reply":"//')
        error=$(echo "$response" | grep -o '"error":"[^"]*' | sed 's/"error":"//')
        
        # Clean up escaped chars if needed (basic)
    fi

    if [[ -n "$error" ]]; then
         echo -e "${RED}System Error: $error${NC}"
    elif [[ -n "$reply" ]]; then
         echo -e "> $reply"
    else
         echo -e "${RED}Error: No response or invalid format.${NC}"
         echo "Raw: $response"
    fi

done
