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
