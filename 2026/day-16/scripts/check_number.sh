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
