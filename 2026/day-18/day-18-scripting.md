# Day 18 – Shell Scripting: Functions & Slightly Advanced Concepts

## Task 1: Basic Functions
1. Create `functions.sh` with:
   - A function `greet` that takes a name as argument and prints `Hello, <name>!`
   - A function `add` that takes two numbers and prints their sum
   - Call both functions from the script
   
   [Here is the script functions.sh](scripts/functions.sh)
   
```bash
raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ ./functions.sh
Enter your name : Robin
Hello, Robin!
Enter any two number : 3 5
8

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ ./functions.sh
Enter your name : Banerjee
Hello, Banerjee!
Enter any two number : 3 five
Enter valid numbers

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ ./functions.sh
Enter your name : infraRanger
Hello, infraRanger!
Enter any two number : 3
./functions.sh: line 11: $2: unbound variable

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ cat functions.sh
#!/bin/bash
set -u

# takes a name as argument and prints `Hello, <name>!`
greet() {
	echo "Hello, $1!"
}

# takes two numbers and prints their sum
add(){
	echo $(($1 + $2))
}

read -p "Enter your name : " name
greet $name     # greet() function call

read -p "Enter any two number : " num1 num2
if [ $num1 -eq $num1 ] &>/dev/null && [ $num2 -eq $num2 ] &>/dev/null;then
        add $num1 $num2     # add() function call
else
        echo "Enter valid numbers"
        exit 1
fi
```

---

## Task 2: Functions with Return Values
1. Create `disk_check.sh` with:
   - A function `check_disk` that checks disk usage of `/` using `df -h`
   - A function `check_memory` that checks free memory using `free -h`
   - A main section that calls both and prints the results
   
   [Here is the script disk_check.sh](scripts/disk_check.sh)
   
```bash
raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ ./disk_check.sh
Disk usage of / :
Total:120G  Used:68G  Available:51G
Free memory : 5Gi

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ df -h
Filesystem             Size  Used Avail Use% Mounted on
...               
...              
/path/to/root          120G  68G  51G   19%  /
...
...

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ free -h
               total        used        free      shared  buff/cache   available
Mem:                                    5Gi                   
Swap:                            

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ cat disk_check.sh
#!/bin/bash

check_disk(){
	echo "Disk usage of / : "   # checks disk usage of `/`
	df -h | awk 'NR==4{print "Total:" $2," Used:" $3," Available:"$4}'
}

check_memory(){
	free -h | awk 'NR==2{print "Free memory : " $4}'    # checks free memory
}

main(){
	check_disk
	check_memory
}
main
```

---

## Task 3: Strict Mode — `set -euo pipefail`
1. Create `strict_demo.sh` with `set -euo pipefail` at the top
2. Try using an **undefined variable** — what happens with `set -u`?
3. Try a command that **fails** — what happens with `set -e`?
4. Try a **piped command** where one part fails — what happens with `set -o pipefail`?

**Document:** What does each flag do?
- `set -e` → If a commands fails it exits the script.
- `set -u` → It throws unbound variable error and exits the script.
- `set -o pipefail` → Makes pipeline fail if any command fails.

    [Here is the script strict_demo.sh](scripts/strict_demo.sh)
   
```bash
raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ cat strict_demo.sh
#!/bin/bash

set -euo pipefail

echo -u "\n"
echo "Undefined variable -u"
echo $a
echo "After using undefined variable script running without set -u"

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ ./strict_demo.sh
-u \n
Undefined variable -u
./strict_demo.sh: line 7: a: unbound variable
```
```bash
raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ vim strict_demo.sh
raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ cat strict_demo.sh
#!/bin/bash

set -euo pipefail

echo -e "\n"
echo "Failed command -e"
mkdir ../scripts
echo "After failing command script running without using -e"

echo -u "\n"
echo "Undefined variable -u"
echo $a
echo "After using undefined variable script running without set -u"

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ ./strict_demo.sh

Failed command -e
mkdir: cannot create directory ‘../scripts’: File exists
```
```bash
raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ vim strict_demo.sh

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ cat strict_demo.sh
#!/bin/bash

set -euo pipefail

echo "Check set -o pipefail"
cat count.txt | grep "total"
echo "After failing script running without set -o"

echo -e "\n"
echo "Failed command -e"
mkdir ../scripts
echo "After failing command script running without using -e"

echo -u "\n"
echo "Undefined variable -u"
echo $a
echo "After using undefined variable script running without set -u"

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ ./strict_demo.sh
Check set -o pipefail
cat: count.txt: No such file or directory
```
   
---

## Task 4: Local Variables
1. Create `local_demo.sh` with:
   - A function that uses `local` keyword for variables
   - Show that `local` variables don't leak outside the function
   - Compare with a function that uses regular variables
   
   [Here is the script local_demo.sh](scripts/local_demo.sh)
   
```bash
raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ ./local_demo.sh
Local variable inside the function : local
Global/Regular variable inside another function : global
Local variable outside the function :
Global/Regular variable outside the function : global

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ cat local_demo.sh
#!/bin/bash

name="global"
func_a(){
	local var_name="local"
	echo "Local variable inside the function : $var_name"
}

func_b(){
	echo "Global/Regular variable inside another function : $name"
}

func_a
func_b
echo "Local variable outside the function : $loc_var"
echo "Global/Regular variable outside the function : $name"
```

---

## Task 5: Build a Script — System Info Reporter
Create `system_info.sh` that uses functions for everything:
1. A function to print **hostname and OS info**
2. A function to print **uptime**
3. A function to print **disk usage** (top 5 by size)
4. A function to print **memory usage**
5. A function to print **top 5 CPU-consuming processes**
6. A `main` function that calls all of the above with section headers
7. Use `set -euo pipefail` at the top

    [Here is the script system_info.sh](scripts/system_info.sh)
   
```bash
raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ vim system_info.sh
raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ ./system_info.sh
 ...HOST NAME & SYS INFO...
HostName : pi
Kernel   : ...
OS       : NAME="Raspbian"
VERSION=...

 ...SYSTEM UPTIME...
up 1 hour, 47 minutes

 ...DISK USAGE...
Filesystem             Size  Used Avail Use% Mounted on
/path/to/root          120G  68G  51G   19%  /
...

 ...MEMORY USAGE...
Total : 7Gi 	Used : 5Gi 	Available : 2Gi

 ...CPU-CONSUMING PROCESSES...
    PID USER          COMMAND         %CPU %MEM
   2965 respberry     ...
   4284 respberry     ...
   4219 respberry     ...
  15347 respberry     ...
   4363 respberry     ...

raspberry@pi:~/90DaysOfDevOps/2026/day-18/scripts$ cat system_info.sh
#!/bin/bash
set -euo pipefail

sys_info(){
	echo " ...HOST NAME & SYS INFO... "
	echo "HostName : $(hostname)"
	echo "Kernel   : $(uname -r)"
	echo "OS       : $(grep -E '^(NAME|VERSION)=' /etc/os-release)"
}

sys_uptime(){
	echo -e "\n ...SYSTEM UPTIME... "
	uptime -p
}

disk_usage(){
	echo -e "\n ...DISK USAGE... "
	df -h | awk 'NR==1'
	df -h | sort -hr -k3 | head -5
}

mem_usage(){
	echo -e "\n ...MEMORY USAGE... "
	free -h | awk 'NR==2{print "Total : "$2,"\tUsed : "$3,"\tAvailable : "$4}'
}

cpu_consuming_processes(){
	echo -e "\n ...CPU-CONSUMING PROCESSES... "
	#echo -e "PID\tUSER\t%CPU\tCOMMAND"
	#top -bn 1 | awk 'NR>=8' | sort -hr -k9 | awk 'NR<=5 {print $1,"\t"$2,"\t"$9,"\t"$12}'
	ps -eo pid,user,comm,%cpu,%mem --sort=-%cpu | head -n 6
}

main(){
	sys_info
	sys_uptime
	disk_usage
	mem_usage
	cpu_consuming_processes
}

main
```