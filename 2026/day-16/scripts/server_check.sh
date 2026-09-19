#!/bin/bash
# ==============================================================================
# Script Name: server_check.sh
# Description: Prompts the user and safely checks the systemd status of a service.
# Author: Robin Banerjee
# Date: 2026-09-18
# ==============================================================================

# configures the shell to exit immediately upon  
# encountering errors, undefined variables, or pipeline failures
set -euo pipefail

# variable that defines the target system service name for the check
SERVICE="nginx"

# user choice regarding status check
read -p "Do you want to check the status of $SERVICE? (y/n): " choice

# conditional block evaluates the user input to determine the execution path
if [[ $choice == 'y' || $choice == 'Y' ]]; then
    # while query for systemd status of the service, the '|| true' expression 
    # prevents 'set -e' from terminating the script if the service happens to be inactive
    systemctl status "$SERVICE" || true

elif [[ $choice == 'n' || $choice == 'N' ]]; then
    # negative response means terminate successfully
    echo "Skipped."
    exit 0

else
    # invalid inputs, routes an error message to standard error, 
    # and exits with a failure status
    echo "Error: Invalid input. Please enter 'y' or 'n'." >&2
    exit 1
fi