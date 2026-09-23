# Day 20 - Bash Scripting Challenge: Log Analyzer and Report Generator

## Overview

In this challenge, I built a **Log Analyzer and Report Generator** using Bash scripting. The script automates log analysis by identifying errors, detecting critical events, generating summary reports, and archiving processed logs.

This project simulates a real-world DevOps/System Administration task where engineers analyze application and system logs to troubleshoot issues and monitor infrastructure health.

---

## Objectives

* Accept a log file as input.
* Validate user input and file existence.
* Count total ERROR or Failed events.
* Detect CRITICAL events with line numbers.
* Identify the top 5 most common ERROR messages.
* Generate a summary report automatically.
* Archive processed log files.

---

## Pre-requisite: Generating sample_log.log using sample_logs_generator.sh
```bash
raspberry@Pi:~/90DaysOfDevOps/2026/day-20$ ./sample_logs_generator.sh /home/user/Documents/TWS/90days-of-devops/90DaysOfDevOps/2026/day-20/sample_log.log 1000
Log file created at: /home/user/Documents/TWS/90days-of-devops/90DaysOfDevOps/2026/day-20/sample_log.log with 1000 lines.

raspberry@Pi:~/90DaysOfDevOps/2026/day-20$ head sample_log.log
2026-09-23 06:22:51 [CRITICAL]  - 31601
2026-09-23 06:22:51 [ERROR] Failed to connect - 17052
2026-09-23 06:22:51 [DEBUG]  - 29876
2026-09-23 06:22:51 [CRITICAL]  - 4535
2026-09-23 06:22:51 [INFO]  - 30390
2026-09-23 06:22:51 [ERROR] Segmentation fault - 8502
2026-09-23 06:22:51 [DEBUG]  - 7556
2026-09-23 06:22:51 [INFO]  - 25122
2026-09-23 06:22:51 [DEBUG]  - 26255
2026-09-23 06:22:51 [DEBUG]  - 29090
```
---

## Initial Project Structure

```bash
day-20/
├── day-20-solution.md
├── log_analyzer.sh
├── README.md
├── sample_log.log
└── sample_logs_generator.sh
```

## Task 1: Input and Validation
Your script should:
1. Accept the path to a log file as a command-line argument
2. Exit with a clear error message if no argument is provided
3. Exit with a clear error message if the file doesn't exist

```
usage(){
	echo "Usage: ./log_analyzer.sh /path/to/logfile"
	echo "Provide the log file that you want to analyze."
	exit 1
}
check(){
	if [ -f "$fname" ];then
		:
	else
		echo "File doesn't exists"
        exit 1
	fi
}

# Task 1: Input and Validation
if [ $# -eq 0 ];then
	usage
fi
fname=$1
check
```

---

## Task 2: Error Count
1. Count the total number of lines containing the keyword `ERROR` or `Failed`
2. Print the total error count to the console

```
err_count(){
	echo "==========TOTAL ERROR COUNT=========="
	grep -icE "ERROR|Failed" "$fname"
}

# Task 2: Error Count
err_count
```

---

## Task 3: Critical Events
1. Search for lines containing the keyword `CRITICAL`
2. Print those lines along with their line number

```
critical_events(){
	echo -e "\n==========CRITICAL Events=========="
	grep -n "CRITICAL" "$fname" | while IFS=':' read -r line_num content; 
    do
        echo "Line $line_num:$content"
    done
}

# Task 3: Critical Events
critical_events
```

---

## Task 4: Top Error Messages
1. Extract all lines containing `ERROR`
2. Identify the **top 5 most common** error messages
3. Display them with their occurrence count, sorted in descending order

```
top_5(){
	echo -e "\n==========TOP 5 ERROR MESSAGES=========="
	grep "ERROR" "$fname" | awk '{$1=$2=$3=$NF=""; print}' | sort | uniq -c | sort -nr | head -5
}

# Task 4: Top Error Messages
top_5
```

---

## Task 5: Summary Report
Generate a summary report to a text file named `log_report_<date>.txt`. The report should include:
1. Date of analysis
2. Log file name
3. Total lines processed
4. Total error count
5. Top 5 error messages with their occurrence count
6. List of critical events with line numbers

```
total_lines(){
	echo -e "\n==========TOTAL LINES PROCESSED=========="
        wc -l < "$fname"
}

report(){
	report="log_report_$(date +%Y-%m-%d-%H-%M).txt"
	echo "Date Of Analysis : $(date +%Y-%m-%d" Time : "%H:%M)" >> "$report"
	echo "Name Of Log File : $fname" >> "$report"
	total_lines >> "$report"
	err_count >> "$report"
	top_5 >> "$report"
	critical_events >> "$report"
}

# Task 5: Summary Report
report
```
---

## Task 6 (Optional): Archive Processed Logs
Add a feature to:
1. Create an `archive/` directory if it doesn't exist
2. Move the processed log file into `archive/` after analysis
3. Print a confirmation message

```
archive_logs(){
    mkdir -p archive
    mv "$fname" archive/
    echo -e "\nProcessed log file '$fname' successfully moved to archive/."
}

# Task 6: Archive Processed Logs
archive_logs
```

---

[Here is the script log_analyzer.sh](log_analyzer.sh)

```
#!/bin/bash

set -euo pipefail

: '
Objectives: 
* Accept a log file as input.
* Validate user input and file existence.
* Count total ERROR or Failed events.
* Detect CRITICAL events with line numbers.
* Identify the top 5 most common ERROR messages.
* Generate a summary report automatically.
* Archive processed log files.
'
##############################################################
# Task 1: Check for input argument
usage(){
	echo "Usage: ./log_analyzer.sh /path/to/logfile"
	echo "Provide the log file that you want to analyze."
	exit 1
}
# Check if file exists
check(){
	if [ -f "$fname" ];then
		:
	else
		echo "File doesn't exists"
        exit 1
	fi
}
##############################################################
# Task 2: Total Error Count
err_count(){
	echo "==========TOTAL ERROR COUNT=========="
	grep -icE "ERROR|Failed" "$fname"
}
##############################################################
# Task 3: Critical Events
critical_events(){
	echo -e "\n==========CRITICAL Events=========="
	grep -n "CRITICAL" "$fname" | while IFS=':' read -r line_num content; 
    do
        echo "Line $line_num:$content"
    done
}
##############################################################
# Task 4: Top Error Messages
top_5(){
	echo -e "\n==========TOP 5 ERROR MESSAGES=========="
	grep "ERROR" "$fname" | awk '{$1=$2=$3=$NF=""; print}' | sort | uniq -c | sort -nr | head -5
}
##############################################################
# Helper for counting total lines
total_lines(){
	echo -e "\n==========TOTAL LINES PROCESSED=========="
        wc -l < "$fname"
}
# Task 5: Generate summary Report
report(){
	report="log_report_$(date +%Y-%m-%d-%H-%M).txt"
	echo "Date Of Analysis : $(date +%Y-%m-%d" Time : "%H:%M)" >> "$report"
	echo "Name Of Log File : $fname" >> "$report"
	total_lines >> "$report"
	err_count >> "$report"
	top_5 >> "$report"
	critical_events >> "$report"
}
##############################################################
# Task 6: Archive Processed Logs
archive_logs(){
    mkdir -p archive
    mv "$fname" archive/
    echo -e "\nProcessed log file '$fname' successfully moved to archive/."
}
##############################################################

# Task 1: Input and Validation
if [ $# -eq 0 ];then
	usage
fi
fname=$1
check

# --- Execution Flow ---

# Task 2: Error Count
err_count

# Task 3: Critical Events
critical_events

# Task 4: Top Error Messages
top_5

# Task 5: Summary Report
report

# Task 6: Archive Processed Logs
archive_logs

```

---

## OUTPUT


    
```
raspberry@Pi:~/90DaysOfDevOps/2026/day-20$ ./log_analyzer.sh
Usage: ./log_analyzer.sh /path/to/logfile
Provide the log file that you want to analyze.
raspberry@Pi:~/90DaysOfDevOps/2026/day-20$ echo $?
1

raspberry@Pi:~/90DaysOfDevOps/2026/day-20$ ./log_analyzer.sh non_existent.log
File doesn't exists
raspberry@Pi:~/90DaysOfDevOps/2026/day-20$ echo $?
1

raspberry@Pi:~/90DaysOfDevOps/2026/day-20$ ./log_analyzer.sh sample_log.log
==========TOTAL ERROR COUNT==========
227

==========CRITICAL Events==========
Line 1:2026-09-23 06:22:51 [CRITICAL]  - 31601
Line 4:2026-09-23 06:22:51 [CRITICAL]  - 4535
Line 14:2026-09-23 06:22:51 [CRITICAL]  - 1208
Line 15:2026-09-23 06:22:51 [CRITICAL]  - 9516
Line 16:2026-09-23 06:22:51 [CRITICAL]  - 10320
Line 25:2026-09-23 06:22:51 [CRITICAL]  - 24946
Line 32:2026-09-23 06:22:51 [CRITICAL]  - 8421
Line 42:2026-09-23 06:22:51 [CRITICAL]  - 14829
Line 43:2026-09-23 06:22:51 [CRITICAL]  - 26274
Line 44:2026-09-23 06:22:51 [CRITICAL]  - 6324
Line 50:2026-09-23 06:22:51 [CRITICAL]  - 7921
Line 55:2026-09-23 06:22:51 [CRITICAL]  - 25692
Line 70:2026-09-23 06:22:52 [CRITICAL]  - 13844
Line 88:2026-09-23 06:22:52 [CRITICAL]  - 14679
Line 92:2026-09-23 06:22:52 [CRITICAL]  - 14637
Line 97:2026-09-23 06:22:52 [CRITICAL]  - 1976
...
...

==========TOP 5 ERROR MESSAGES==========
     53    Failed to connect -
     50    Disk full -
     48    Segmentation fault -
     38    Out of memory -
     38    Invalid input -

Processed log file 'sample_log.log' successfully moved to archive/.
```
   
[Here is the report file generated. ](log_report_2026-09-23-10-35.txt)
   
```
raspberry@Pi:~/90DaysOfDevOps/2026/day-20$ cat log_report_*.txt
Date Of Analysis : 2026-09-23 Time : 10:35
Name Of Log File : sample_log.log

==========TOTAL LINES PROCESSED==========
1000
==========TOTAL ERROR COUNT==========
227

==========TOP 5 ERROR MESSAGES==========
     53    Failed to connect -
     50    Disk full -
     48    Segmentation fault -
     38    Out of memory -
     38    Invalid input -

==========CRITICAL Events==========
Line 1:2026-09-23 06:22:51 [CRITICAL]  - 31601
Line 4:2026-09-23 06:22:51 [CRITICAL]  - 4535
Line 14:2026-09-23 06:22:51 [CRITICAL]  - 1208
Line 15:2026-09-23 06:22:51 [CRITICAL]  - 9516
Line 16:2026-09-23 06:22:51 [CRITICAL]  - 10320
Line 25:2026-09-23 06:22:51 [CRITICAL]  - 24946
Line 32:2026-09-23 06:22:51 [CRITICAL]  - 8421
Line 42:2026-09-23 06:22:51 [CRITICAL]  - 14829
Line 43:2026-09-23 06:22:51 [CRITICAL]  - 26274
Line 44:2026-09-23 06:22:51 [CRITICAL]  - 6324
Line 50:2026-09-23 06:22:51 [CRITICAL]  - 7921
Line 55:2026-09-23 06:22:51 [CRITICAL]  - 25692
Line 70:2026-09-23 06:22:52 [CRITICAL]  - 13844
Line 88:2026-09-23 06:22:52 [CRITICAL]  - 14679
Line 92:2026-09-23 06:22:52 [CRITICAL]  - 14637
Line 97:2026-09-23 06:22:52 [CRITICAL]  - 1976
...
...
```

---

## Final Project Structure

```bash
day-20/
├── archive
│   └── sample_log.log
├── day-20-solution.md
├── log_analyzer.sh
├── log_report_2026-09-23-10-35.txt
├── README.md
└── sample_logs_generator.sh
```

---

## What I learned
- **Modular Scripting & Code Reusability**: I learned how to break down a complex automation workflow into logical, single-purpose functions (err_count, critical_events, top_5, report, archive_logs). This embraced the DRY (Don't Repeat Yourself) principle, making my script much cleaner, easier to debug, and simple to maintain.
- **Advanced CLI Text Manipulation**: I mastered chaining powerful Unix text-processing utilities together (grep, awk, sort, uniq, wc) to transform raw, unstructured log data into clear analytical metrics—like tracking exact line numbers and ranking error frequencies.
- **Robust Error Handling & Production Readiness**: I built production-grade reliability into my script by implementing set -euo pipefail, rigorous input validation for missing arguments and invalid paths, and dynamic file management with timestamped reports and automated archiving.
