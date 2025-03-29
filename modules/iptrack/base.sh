#!/bin/bash

# Color codes
red="\e[1;31m"
green="\e[32m"
yellow="\e[33m"
clean="\e[0m"

# Check required commands
for cmd in curl jq; do
    command -v "$cmd" &> /dev/null || { echo -e "${red}[ERROR]${clean} $cmd is required but not installed."; exit 1; }
done

# Get public IP
get_public_ip() {
    curl -s https://api.my-ip.io/v2/ip.json | jq -r '.ip'
}

# Get IP location details
get_ip_location() {
    ip="$1"
    data=$(curl -s "http://ip-api.com/json/$ip")
    [[ $(echo "$data" | jq -r '.status') == "fail" ]] && { echo -e "${red}[ERROR]${clean} Invalid IP."; exit 1; }

    echo -e "${green}[INFO]${clean} IP Address: $(echo "$data" | jq -r '.query')"
    echo -e "${green}[INFO]${clean} Country: $(echo "$data" | jq -r '.country')"
    echo -e "${green}[INFO]${clean} Region: $(echo "$data" | jq -r '.regionName')"
    echo -e "${green}[INFO]${clean} City: $(echo "$data" | jq -r '.city')"
    echo -e "${green}[INFO]${clean} ISP: $(echo "$data" | jq -r '.isp')"
    echo -e "${green}[INFO]${clean} Latitude: $(echo "$data" | jq -r '.lat')"
    echo -e "${green}[INFO]${clean} Longitude: $(echo "$data" | jq -r '.lon')"
}

read -rp "[m] // [e]: " track_option

# Argument handling
if [[ "$track_option" == "m" || "$track_option" == "M" ]]; then
    get_ip_location "$(get_public_ip)"
else
    read -rp "IP): " ipaddr
    get_ip_location "$ipaddr"
fi
