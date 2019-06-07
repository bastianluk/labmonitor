#!/bin/sh
###############################################################################
#Script Name    : labmonitor_worker.sh
#Description    : Tool used in labmonitor script to monitor specific machine
#Author         : Lukas Bastian
#Github         : https://github.com/bastianluk
###############################################################################

usage() {
  cat <<EOF
SYNTAX
        ./labmonitor_worker.sh RETURN_ADDRESS
DESCRIPTION
        Monitors logins for the duration of a run and send results back to 
        RETURN_ADDRESS
  EOF
}

#DEBUG
#set -euo pipefail
#set -x

#ARGs
fileName=$(echo "res_"$(hostname -f))

#FUNC
#Login check
checkNew() {
  
}

#Finish
finish() {
  #Send results
  scp "$filename" "$1"

  #Cleanup
  rm "$filename"
}

#MAIN
echo "$1" > "$filename"
hostname >> "$filename"

#Before kill or end time - call finish
finish
