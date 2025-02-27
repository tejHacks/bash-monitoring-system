#!/bin/bash

echo "=============================="
echo "   System Monitor Script"
echo "=============================="
echo ""

# CPU Usage
echo "🔥 CPU Usage:"
top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4 "% used"}'
echo ""

# RAM Usage
echo "🧠 RAM Usage:"
free -h | awk '/Mem/{print $3 " used / " $2 " total"}'
echo ""

# Disk Space
echo "💾 Disk Space:"
df -h | grep "^/dev"
echo ""

# Uptime
echo "⏳ System Uptime:"
uptime -p
echo ""

# Top 5 Running Processes
echo "🔝 Top 5 Running Processes:"
ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -6
echo ""

echo "=============================="
echo "      End of Report"
echo "=============================="

