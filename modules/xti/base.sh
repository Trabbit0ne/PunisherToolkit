#!/bin/bash

# Read URL
read -rp "Url: " url

# Use the XTI exploit
python3 modules/xti/xti.py "$url"
echo
