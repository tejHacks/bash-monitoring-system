#!/bin/bash

# ==============================
#  Real-Time System Monitor
# ==============================

LOG_FILE="system_monitor.log"
exec > >(tee -a "$LOG_FILE") 2>&1  # Save output and show on screen

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

while true; do
    clear
    echo "=============================="
    echo "   Real-Time System Monitor"
    echo "=============================="
    echo "Report Generated on: $(date)"
    echo ""

    # CPU Usage
    CPU=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    echo -e "${GREEN}🔥 CPU Usage: ${CPU}% used${NC}"
    
    # RAM Usage
    RAM=$(free | awk '/Mem/{print int($3/$2 * 100)}')
    echo -e "${CYAN}🧠 RAM Usage: ${RAM}% used${NC}"
    
    # Disk Space
    echo -e "${YELLOW}💾 Disk Space:${NC}"
    df -h | grep "^/dev"
    echo ""

    # Uptime
    echo -e "${RED}⏳ System Uptime:${NC}"
    uptime -p
    echo ""

    # Check for high CPU or RAM usage
    if (( $(echo "$CPU > 80" | bc -l) )); then
        echo -e "${RED}⚠️ WARNING: High CPU Usage: $CPU% ${NC}"
    fi

    if (( RAM > 80 )); then
        echo -e "${RED}⚠️ WARNING: High RAM Usage: $RAM% ${NC}"
    fi

    echo "=============================="
    echo "      Refreshing in 5s..."
    echo "=============================="
    sleep 5

done
