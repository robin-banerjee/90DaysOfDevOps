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
