# Shell Scripting Basics

## What is Shell Scripting?

Shell scripting is the process of writing commands in a file and executing them automatically using a shell interpreter like Bash.

Benefits:
- Automation
- Reduced manual work
- Faster system administration
- Core DevOps skill

Shebang
```bash
#!/bin/bash
```
Purpose:
- Tells Linux which interpreter should run the script.
- Usually placed on the first line of every Bash script.

---

## Task 1: First Script
1. Create a file `hello.sh`
2. Add the shebang line `#!/bin/bash` at the top
3. Print `Hello, DevOps!` using `echo`
4. Make it executable and run it
```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-16$ vim hello.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-16$ cat hello.sh
#!/bin/bash
echo "Hello, DevOps!"

rasberry@pi:~/90DaysOfDevOps/2026/day-16$ ./hello.sh
bash: ./hello.sh: Permission denied
rasberry@pi:~/90DaysOfDevOps/2026/day-16$ chmod +x hello.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-16$ bash hello.sh
Hello, DevOps!

rasberry@pi:~/90DaysOfDevOps/2026/day-16$ mkdir -p scripts
rasberry@pi:~/90DaysOfDevOps/2026/day-16$ ls
day-16-shell-scripting.md  hello.sh  README.md  scripts
rasberry@pi:~/90DaysOfDevOps/2026/day-16$ mv hello.sh scripts/
rasberry@pi:~/90DaysOfDevOps/2026/day-16$ ls
day-16-shell-scripting.md  README.md  scripts
rasberry@pi:~/90DaysOfDevOps/2026/day-16$ cd scripts/
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ls -l
total 4
-rwxrwxr-x 1 rasberry rasberry 35 Sep 19 10:36 hello.sh
```

[Here is the script hello.sh](scripts/hello.sh)

* What happens if you remove the shebang line?
   - The script runs after removing shebang line :
      - `./hello.sh` - Kernel looks for a shebang if not found it will use current shell to interpret the file. (What the Kernel Sees -> When you type ./hello.sh, the Linux kernel looks at the file headers to see if it's a compiled binary. Since it's a plain text file, the kernel technically throws an Exec format error. Due to the `Shell's Safety Net`: our interactive terminal shell (Bash) catches this error and says, "Ah, this is a text file, let me try running it with the default system shell (/bin/sh)", which is why it printed successfully. 
         ```
         But why the Shebang is still mandatory: in automated environments such as CI/CD pipeline runner, a Docker container or a Cron job that interactive safety net might not exist, or the default shell might change (dash instead of bash). Always keeping the shebang ensures our scripts are portable and deterministic)
         ```
```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ vim hello.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ cat hello.sh
echo "Hello, DevOps!"

rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./hello.sh
Hello, DevOps!
```
   - `bash hello.sh` - The shell explicitly uses bash.
   - `sh hello.sh` - It uses sh.
```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ bash hello.sh
Hello, DevOps!
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ sh hello.sh
Hello, DevOps!
```

---

## Task 2: Variables
1. Create `variables.sh` with:
   - A variable for our `NAME`
   - A variable for our `ROLE` (e.g., "DevOps Engineer")
   - Print: `Hello, I am <NAME> and I am a <ROLE>`
2. Try using single quotes vs double quotes — what's the difference?
   * Using double quote `" "` - Allow for variable expansion (interpolation) and command substitution. The shell looks inside them, recognizes the $ sign, and swaps the variable name for its actual value.
   * Using single quote `' '` - Treat everything strictly as literal text. Variable names and special characters lose their meaning and are printed exactly as written.

[Here is the script variables.sh](scripts/variables.sh)

```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ vim variables.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ cat variables.sh
#!/bin/bash
#
##########################################
# this script is for testing variables
##########################################
NAME="Robin Banerjee"
ROLE="DevOps Engineer"
##########################################
# variables with in double quotes
echo "Hello, I am $NAME and I am a $ROLE"
##########################################
# variables with in single quotes
echo 'Hello, I am $NAME and I am a $ROLE'
##########################################
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./variables.sh
Hello, I am Robin Banerjee and I am a DevOps Engineer
Hello, I am $NAME and I am a $ROLE
```

---

## Task 3: User Input with read
1. Create `greet.sh` that:
   - Asks the user for their name using `read`
   - Asks for their favourite tool
   - Prints: `Hello <name>, our favourite tool is <tool>`

[Here is the script greet.sh](scripts/greet.sh)

```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ vim greet.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ cat greet.sh
#!/bin/bash
##################################################################
# this script is for accepting input from users
##################################################################
# get user's name ->
read -p "Enter name: " name
##################################################################
# get user's favourite tool ->
read -p "Favourite DevOps tool? " tool
##################################################################
echo "Hi $name, glad to know your favourite DevOps tool is $tool."
##################################################################

rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ chmod +x greet.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./greet.sh
Enter name: Robin
Favourite DevOps tool? Docker
Hi Robin, glad to know your favourite DevOps tool is Docker.
```

---

## Task 4: If-Else Conditions
1. Create `check_number.sh` that:
   - Takes a number using `read`
   - Prints whether it is **positive**, **negative**, or **zero**

[Here is the script check_number.sh](scripts/check_number.sh)

```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ vim check_number.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ cat check_number.sh
#!/bin/bash
############
# this is for understanding if-else conditional statements in script
############
read -p "Enter any number: " num

# using regex validation to safely catch non-numbers before comparision
# ------------------------------------------------------------------------------
# Input Validation Block
# ------------------------------------------------------------------------------
# [[ ... ]] : Modern Bash conditional test construct
# !         : Logical NOT (reverses the result)
# =~        : Regular expression matching operator
# ^-?[0-9]+$: The regex pattern matching a valid integer:
#   ^      -> Matches the absolute start of the string
#   -?     -> Matches an optional minus sign (allows negative numbers like -5)
#   [0-9]+ -> Matches one or more digits (0 through 9)
#   $      -> Matches the absolute end of the string
# ------------------------------------------------------------------------------
if [[ ! $num =~ ^-?[0-9]+$ ]]; then
    echo "Given input is not a number!" >&2  # Print error message to standard error
    exit 1                                   # Exit the script with a failure code
fi

############
# checking if the given number is more, less or equal to 0
if [ "$num" -eq 0 ]; then
    echo "Given number is zero."
elif [ "$num" -gt 0 ]; then
    echo "Given number is greater than 0."
else
    echo "Given number is less than 0."
fi

exit 0
```
```
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./check_number.sh
Enter any number: number
Given input is not a number!
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./check_number.sh
Enter any number: 0
Given number is zero.
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./check_number.sh
Enter any number: 22
Given number is greater than 0.
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./check_number.sh
Enter any number: -5
Given number is less than 0.
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./check_number.sh
Enter any number: 100 100
Given input is not a number!
```


2. Create `file_check.sh` that:
   - Asks for a filename
   - Checks if the file **exists** using `-f`
   - Prints appropriate message

[Here is the script file_check.sh](scripts/file_check.sh)

```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ vim file_check.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ cat file_check.sh
#!/bin/bash
# ==============================================================================
# Looks for a filename and checks if it exists as a regular file.
# ==============================================================================

read -p "Please enter any file name: " fname

if [-f "$fname"]; then
    echo "The file '$fname' exists."
else
    echo "The file '$fname' does not exist."
fi

exit 0
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./file_check.sh
Please enter any file name: hello.sh
./file_check.sh: line 8: [-f: command not found
The file 'hello.sh' does not exist.
```
```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ vim file_check.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ cat file_check.sh
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
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./file_check.sh
Please enter any file name: greet.sh
The file 'greet.sh' exists.
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./file_check.sh
Please enter any file name: wrong-file.sh
The file 'wrong-file.sh' does not exist.
```

---

## Task 5: Combine It All
Create `server_check.sh` that:
1. Stores a service name in a variable (e.g., `nginx`, `sshd`)
2. Asks the user: "Do you want to check the status? (y/n)"
3. If `y` — runs `systemctl status <service>` and prints whether it's **active** or **not**
4. If `n` — prints "Skipped."

[Here is the script server_check.sh](scripts/server_check.sh)

```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ vim server_check.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ chmod +x server_check.sh
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ cat server_check.sh
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
```
```bash
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./server_check.sh
Do you want to check the status of nginx? (y/n): y
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/path/to/nginx.service; enabled; preset: enabled)
     Active: active (running) since Sat 2026-09-19 06:35:55 IST; 8h ago
       Docs: man:nginx(8)
       ...

Sep 19 06:35:55 Machine systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Sep 19 06:35:55 Machine systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./server_check.sh
Do you want to check the status of nginx? (y/n): n
Skipped.
rasberry@pi:~/90DaysOfDevOps/2026/day-16/scripts$ ./server_check.sh
Do you want to check the status of nginx? (y/n):
Error: Invalid input. Please enter 'y' or 'n'.
```

## What I learned

* How to write and run shell scripts with shebangs, variables, and user input using read.
* The difference between single vs double quotes, and how quoting affects variable expansion.
* Using conditional logic (if, elif, else) and test operators (-f, -gt, -lt) to handle files and numbers.
* Error redirection (>/dev/null, 2>/dev/null, &>/dev/null).

