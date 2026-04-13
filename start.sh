#!/bin/sh
ip_file="local_ip.txt"

if [ ! -f "$ip_file" ]; then
    echo "$ip_file not found. Generating via get_ip.sh..."
    ./get_ip.sh
    if [ ! -f "$ip_file" ]; then
        echo "Failed to create $ip_file."
        exit 1
    fi
fi

local_ip=$(<"$ip_file")

hugo server build --disableFastRender --port 3000 --bind=0.0.0.0 --baseURL=http://${local_ip}:3000 --panicOnWarning --forceSyncStatic --gc
