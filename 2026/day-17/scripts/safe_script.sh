#!/bin/bash

set -e

# Directory setup with suppressed stderr
mkdir /tmp/devops-test 2>/dev/null && echo "Directory created" || echo "Directory already exists"

cd /tmp/devops-test

# File setup using file existence check with short-circuit
[ -f "demo.txt" ] && echo "demo.txt file already exists" || { echo "this is test file" > demo.txt; echo "File created"; }