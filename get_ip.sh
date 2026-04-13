#!/bin/sh
# Writes the active LAN IP to local_ip.txt, used by start.sh as the
# baseURL for the local Hugo preview server.

output_file="local_ip.txt"
ip_address=""

case "$(uname -s)" in
    Darwin)
        ip_address=$(ipconfig getifaddr en0)
        [ -z "$ip_address" ] && ip_address=$(ipconfig getifaddr en1)
        ;;
    Linux)
        # Ask the kernel which source IP it would use to reach a public address.
        ip_address=$(ip route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if ($i=="src") print $(i+1)}')
        [ -z "$ip_address" ] && ip_address=$(hostname -I 2>/dev/null | awk '{print $1}')
        ;;
esac

if [ -z "$ip_address" ]; then
    echo "Not Connected" > "$output_file"
    echo "No active LAN IP detected; wrote 'Not Connected' to $output_file"
else
    echo "$ip_address" > "$output_file"
    echo "Local IP address ($ip_address) written to $output_file"
fi
