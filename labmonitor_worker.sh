#!/bin/sh
###############################################################################
#Script Name    : labmonitor_worker.sh
#Description    : Tool used in labmonitor script to monitor specific machine
#Author         : Lukas Bastian
#Github         : https://github.com/bastianluk
###############################################################################

#DEBUG
#set -euo pipefail
#set -x

#ARGs
fileName=$(echo "res_"$(hostname -f))

#FUNC


#MAIN
echo "$1" > "$filename"
hostname >> "$filename"

#Send results
scp "$filename" bastianl@u-pl13.ms.mff.cuni.cz:/tmp

#Cleanup
rm "$filename"
