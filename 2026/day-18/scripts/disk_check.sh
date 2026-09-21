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
