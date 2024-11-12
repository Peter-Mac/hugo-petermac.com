#!/bin/sh
# Define the IP file path
ip_file="local_ip.txt"

# Check if the file exists
if [ ! -f "$ip_file" ]; then
    echo "$ip_file not found. Executing detect_ip.sh to generate it..."
    
    # Run the detect_ip.sh script to create the file
    ./get_ip.sh
    
    # Verify if the file was created successfully
    if [ -f "$ip_file" ]; then
        echo "$ip_file successfully created."
    else
        echo "Failed to create $ip_file."
        exit 1  # Exit if file creation fails
    fi
else
    echo "$ip_file already exists. No action needed."
fi

local_ip=$(<"$ip_file")


rm -rf public
rm -rf static/pagefind && rm -rf static/_pagefind

hugo server build --disableFastRender --port 3000 --bind=0.0.0.0 --baseURL=http://${local_ip}:3000 --panicOnWarning --forceSyncStatic --gc

