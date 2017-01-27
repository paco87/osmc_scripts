#!/bin/bash
# Author: paco87


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
LOG_DIR="${SCRIPT_DIR}/make_movie_folders_readble_for_imdb.log"


function log (){
	now=$(date)
	
	if [[ "$1" == "[DEBUG]" ]] ; then
		# echo -e "${now} - $@" 1>&2 | tee -a $LOG_DIR	
		if [[ "${DEBUG}" == "true" ]]; then
			echo -e "${now} - $@" 1>&2 > >(tee -a $LOG_DIR) 2> >(tee -a $LOG_DIR >&2)
		fi
	elif [[ "$1" == "[ERROR]" ]] ; then
		echo -e "${now} - $@" 1>&2 > >(tee -a $LOG_DIR) 2> >(tee -a $LOG_DIR >&2)
	else
		echo -e "${now} [INFO] - $@" > >(tee -a $LOG_DIR) 2> >(tee -a $LOG_DIR >&2)
	fi

}

function helptext() {

local tab=$(echo -e "\t")
cat << EOF
$(usage)
This script finds all files bought from very cheap shop and removes unwanted charcters from the folder 
${tab} --path <path> to dir where you store movies


EOF

}

function usage(){
cat << EOF
USAGE: ${SCRIPT_NAME} --path <dir> --debug --help
EOF

}

function arg_handler(){

log [DEBUG] "Number of argumts passed" $#

if [ $# -lt 1 ];then
	usage
	exit 1
fi

while [ $# -ge 1 ] ; do
	log [DEBUG] "Proccessing argument $1"

	case $1 in
		--debug)
			DEBUG="true"
		;;
		--help)
			helptext
			exit 0
		;;
		--path)
			shift 
			if [ -d $1 ];then
				DIR_TO_PROCCESS=$1
			else
				log [ERROR] "given directory does not exists: $1"
				exit 1
			fi
			
			log [DEBUG] path set ${DIR_TO_PROCCESS}
		;;
		
		*)
		log [ERROR] "not supported arg"
		helptext
		exit 1
		;;
	
	esac


shift
done

}
#argument handling
arg_handler "$@"

#MAIN PROGRAM
log [DEBUG] " main variables set-
	SCRIPT_DIR=$SCRIPT_DIR
	SCRIPT_NAME=$SCRIPT_NAME
	LOG_DIR=$LOG_DIR"



	
# FilesFound=$( find ${DIR_TO_PROCCESS} -maxdepth 1 -name "[*" )
FilesFound=$( find ${DIR_TO_PROCCESS} -maxdepth 1 -type d ) || log [ERROR] "nothing found"

IFSbkp="$IFS"
IFS=$'\n'

counter=1;
for file in $FilesFound; do
	log [DEBUG] "Processing file ${counter}: ${file}"
	
	let counter++;
done
IFS="$IFSbkp"



