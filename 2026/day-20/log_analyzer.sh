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
