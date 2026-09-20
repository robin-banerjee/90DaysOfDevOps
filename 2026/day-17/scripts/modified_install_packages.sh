#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: This script must be run as root. Try using sudo." >&2
    exit 1
else
	echo "Running as root..."
fi

packages=("nginx" "curl" "wget")

for pkg in "${packages[@]}"; do
    dpkg -s "$pkg" &>/dev/null && echo " $pkg is ALREADY INSTALLED! " || { echo "$pkg installing..."; apt-get install -y "$pkg" 1>/dev/null; }
done

for pkg in "${packages[@]}"; do
     dpkg -s "$pkg" &>/dev/null && echo " STATUS - $pkg is INSTALLED " || echo " STATUS - $pkg is NOT INSTALLED "
done