# Day 17: Shell Scripting - Loops, Arguments & Error Handling

## Task 1: For Loop
1. Create `for_loop.sh` that:
   - Loops through a list of 5 fruits and prints each one
   
   [Here is the script for_loop.sh](scripts/for_loop.sh)
   
```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ vim for_loop.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ cat for_loop.sh
#!/bin/bash

fruits=("Apple" "Musk Melon" "Banana" "Orange" "Grapes")
for fruit in "${fruits[@]}";do
	echo "$fruit"
done

rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./for_loop.sh
Apple
Musk Melon
Banana
Orange
Grapes
```

2. Create `count.sh` that:
   - Prints numbers 1 to 10 using a for loop
   
   [Here is the script count.sh](scripts/count.sh)
   
```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ vim count.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./count.sh
1
2
3
4
5
6
7
8
9
10

rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ cat count.sh
#!/bin/bash

for num in {1..10};
do
	echo "$num"
done
```

---

## Task 2: While Loop
1. Create `countdown.sh` that:
   - Takes a number from the user
   - Counts down to 0 using a while loop
   - Prints "Done!" at the end

   [Here is the script countdown.sh](scripts/countdown.sh)
   
```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ vim countdown.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./countdown.sh
Enter any number : 3
3
2
1
0
Done!
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./countdown.sh
Enter any number : -3
-3
-2
-1
0
Done!
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./countdown.sh
Enter any number : any
Invalid input
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./countdown.sh
Enter any number : 0
0
Done!
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ cat countdown.sh
#!/bin/bash

read -p "Enter any number : " num

if [ $num -eq $num ] &>/dev/null; then
    :
else
    echo "Invalid input"
    exit 1
fi

if [ $num -gt 0 ]; then
    while [ $num -ge 0 ]; do
        echo $num
        (( num-- ))
    done
elif [ $num -lt 0 ]; then
    while [ $num -le 0 ]; do
        echo "$num"
        (( num++ ))
    done
else
	echo $num
fi
echo "Done!"
```
   
---

## Task 3: Command-Line Arguments
1. Create `greet.sh` that:
   - Accepts a name as `$1`
   - Prints `Hello, <name>!`
   - If no argument is passed, prints "Usage: ./greet.sh <name>"
   
   [Here is the script greet.sh](scripts/greet.sh)
   
```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./greet.sh
Usage: ./greet.sh <name>
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./greet.sh Robin
Hello, Robin!
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ cat greet.sh
#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "Usage: ./greet.sh <name>"
else
    echo "Hello, $1!"
fi
```

2. Create `args_demo.sh` that:
   - Prints total number of arguments (`$#`)
   - Prints all arguments (`$@`)
   - Prints the script name (`$0`)

   Special Variables:

   | Variable | Description |
   |-----------|-------------|
   | `$0` | Script name |
   | `$1` | First argument |
   | `$2` | Second argument |
   | `$#` | Total arguments |
   | `$@` | All arguments |

   [Here is the script args_demo.sh](scripts/args_demo.sh)
   
```bash 
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./args_demo.sh
 Total number of arguments passed : 0
 Passed arguments :
 Name of the script : ./args_demo.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./args_demo.sh Robin Banerjee
 Total number of arguments passed : 2
 Passed arguments : Robin Banerjee
 Name of the script : ./args_demo.sh

rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ cat args_demo.sh
#!/bin/bash

echo " Total number of arguments passed : $# "
echo " Passed arguments : $@ "
echo " Name of the script : $0 "
```

---

## Task 4: Install Packages via Script
1. Create `install_packages.sh` that:
   - Defines a list of packages: `nginx`, `curl`, `wget`
   - Loops through the list
   - Checks if each package is installed (use `dpkg -s` or `rpm -q`)
   - Installs it if missing, skips if already present
   - Prints status for each package
   
   [Here is the script install_packages.sh](scripts/install_packages.sh)
   
```bash 
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ sudo ./install_packages.sh
 nginx is ALREADY INSTALLED!
curl installing...
wget installing...
 STATUS - nginx is INSTALLED
 STATUS - curl is INSTALLED
 STATUS - wget is INSTALLED
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ cat install_packages.sh
#!/bin/bash

package=("nginx" "curl" "wget")


for pkg in "${package[@]}";do
	dpkg -s $pkg &>/dev/null && echo " $pkg is ALREADY INSTALLED! " || { echo "$pkg installing..."; apt-get install -y "$pkg" 1>/dev/null; }
done

for pkg in "${package[@]}";do
	 dpkg -s $pkg &>/dev/null && echo " STATUS - $pkg is INSTALLED " || echo " STATUS - $pkg is NOT INSTALLED "
```

---

## Task 5: Error Handling
1. Create `safe_script.sh` that:
   - Uses `set -e` at the top (exit on error)
   - Tries to create a directory `/tmp/devops-test`
   - Tries to navigate into it
   - Creates a file inside
   - Uses `||` operator to print an error if any step fails
   
   [Here is the script safe_script.sh](scripts/safe_script.sh)
   
```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ cat safe_script.sh
#!/bin/bash

set -e

# Directory setup with suppressed stderr
mkdir /tmp/devops-test 2>/dev/null && echo "Directory created" || echo "Directory already exists"

cd /tmp/devops-test

# File setup using file existence check with short-circuit
[ -f "demo.txt" ] && echo "demo.txt file already exists" || { echo "this is test file" > demo.txt; echo "File created"; }

rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./safe_script.sh
Directory created
File created
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./safe_script.sh
Directory already exists
demo.txt file already exists
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ cat /tmp/devops-test/demo.txt
this is test file
```

2. Modify your `install_packages.sh` to check if the script is being run as root — exit with a message if not.

   [Here is the script modified_install_packages.sh](scripts/modified_install_packages.sh)
   
```bash 
rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ ./modified_install_packages.sh
ERROR: This script must be run as root. Try using sudo.

rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ sudo ./modified_install_packages.sh
Running as root...
 nginx is ALREADY INSTALLED!
curl installing...
wget installing...
 STATUS - nginx is INSTALLED
 STATUS - curl is INSTALLED
 STATUS - wget is INSTALLED

rasberry@pi:~/90DaysOfDevOps/2026/day-17/scripts$ cat modified_install_packages.sh
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
```

---

## What I learned

1. Loops (while,for) help automate repetitive tasks.
2. Command-line arguments make scripts dynamic.
3. Error handling prevents scripts from failing silently.
4. Root checks are important for system administration scripts.