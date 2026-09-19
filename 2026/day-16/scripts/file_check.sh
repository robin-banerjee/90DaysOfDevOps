#!/bin/bash
# ==============================================================================
# Looks for a filename and checks if it exists as a regular file.
# ==============================================================================
read -p "Please enter any file name: " fname
# Always quote variables in test brackets to handle spaces safely
if [ -f "$fname" ]; then
    echo "The file '$fname' exists."
else
    echo "The file '$fname' does not exist."
fi

exit 0
