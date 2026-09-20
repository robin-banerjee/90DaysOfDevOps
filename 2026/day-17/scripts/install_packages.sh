#!/bin/bash

package=("nginx" "curl" "wget")


for pkg in "${package[@]}";do
	dpkg -s $pkg &>/dev/null && echo " $pkg is ALREADY INSTALLED! " || { echo "$pkg installing..."; apt-get install -y "$pkg" 1>/dev/null; }
done

for pkg in "${package[@]}";do
	 dpkg -s $pkg &>/dev/null && echo " STATUS - $pkg is INSTALLED " || echo " STATUS - $pkg is NOT INSTALLED "
done