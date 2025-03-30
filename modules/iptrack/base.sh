#!/bin/bash

# ======================================
# |       PUNISHER MODULE - IPTRACK    |
# ======================================
# | Vers |         V1.1                |
# --------------------------------------
# | Type |     Open Source              |
# --------------------------------------
# | Date |      2025-03-30              |
# ======================================

# Color codes
red="\e[1;31m"
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
purple="\e[35m"
cyan="\e[36m"
clean="\e[0m"

# Toolkit Banner
echo -e "${purple}====================================="
echo -e "${cyan}        🔍 IP TRACKER MODULE 🔍      "
echo -e "${purple}=====================================${clean}"

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
    
    if [[ $(echo "$data" | jq -r '.status') == "fail" ]]; then
        echo -e "${red}[ERROR]${clean} Invalid IP address."
        exit 1
    fi
    
    echo -e "${yellow}--------------------------------------${clean}"
    echo -e "${green}[INFO]${clean} IP Address  : ${cyan}$(echo "$data" | jq -r '.query')${clean}"
    echo -e "${green}[INFO]${clean} Country     : ${cyan}$(echo "$data" | jq -r '.country')${clean}"
    echo -e "${green}[INFO]${clean} Region      : ${cyan}$(echo "$data" | jq -r '.regionName')${clean}"
    echo -e "${green}[INFO]${clean} City        : ${cyan}$(echo "$data" | jq -r '.city')${clean}"
    echo -e "${green}[INFO]${clean} ISP         : ${cyan}$(echo "$data" | jq -r '.isp')${clean}"
    echo -e "${green}[INFO]${clean} Latitude    : ${cyan}$(echo "$data" | jq -r '.lat')${clean}"
    echo -e "${green}[INFO]${clean} Longitude   : ${cyan}$(echo "$data" | jq -r '.lon')${clean}"
    echo -e "${yellow}--------------------------------------${clean}"
}

# Menu Options
echo -e "${blue}( [M] -> Track My IP || [O] -> Track Other IP )${clean}"
read -rp "Select an option: " track_option

if [[ "$track_option" == "m" || "$track_option" == "M" ]]; then
    get_ip_location "$(get_public_ip)"
else
    read -rp "IP: " ipaddr
    get_ip_location "$ipaddr"
fi
