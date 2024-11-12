#!/bin/bash

# Define the output file
output_file="local_ip.txt"

# Get the active network interface with an IP address
# `ipconfig getifaddr` will automatically select the primary interface
ip_address=$(ipconfig getifaddr en0)  # Try Wi-Fi first

# If Wi-Fi doesn't have an IP, check the wired connection (usually en1 or similar on macOS)
if [ -z "$ip_address" ]; then
    ip_address=$(ipconfig getifaddr en1)
fi

# If there's still no IP (e.g., all interfaces down), log "Not Connected"
if [ -z "$ip_address" ]; then
    echo "Not Connected" > "$output_file"
else
    # Otherwise, log the IP address to the output file
    echo "$ip_address" > "$output_file"
fi

# Notify the user where the IP has been written
echo "Local IP address ($ip_address) has been written to $output_file"

