#!/bin/bash
# Author: paco87

function log (){
	now=$(date)
	
	if [[ "$1" == "DEBUG" ]] ; then
		echo -e "${now} - $@" 1>&2
	else
		echo -e "${now} - $@"
	fi
	
	

}


function arg_handler

while [ $# -gt 1 ] ; do

log DEBUG $1

log test

shift
done
