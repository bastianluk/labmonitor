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
        ./labmonitor_worker.sh RETURN_ADDRESS [END_TIME]
DESCRIPTION
        Monitors logins for the duration of a run and send results back to
        RETURN_ADDRESS
EOF
}

#DEBUG
#set -euo pipefail
#set -x

#ARGs
dateStart=$(date +%Y-%m-%d\ %H:%M)
dateEndDay=''
dateEnd=''
file1=$(echo "tmp_labwork_"$(hostname -f)"1")
file2=$(echo "tmp_labwork_"$(hostname -f)"2")
fileName=$(echo "res_"$(hostname -f))
address="$1"

#FUNC
killHandle(){
  getResults

  finish
}

timeHandle(){
  diff=$(echo "$(date -d "$dateEnd" "+%s")-$(date -d "$dateStart" "+%s")" | bc)

  if [ "$diff" -ge 0 ]
  then
    sleep "$diff"
  fi

  getResults

  finish
}

getResults(){
  last -s "$dateStart" | tr -s ' ' | cut -d ' ' -f1,5- > "$file1"
  lines=$(cat tmp_labwork1 | wc -l)
  for n in $(seq 1 1 "$lines")
  do
    echo $(hostname -f) >> "$file2"
  done
  paste -d' ' "$file2" "$file1" > "$fileName"
}

#Finish
finish() {
  #Send results
  scp "$fileName" "$address"

  #Cleanup
  rm "$file1"
  rm "$file2"
  rm "$fileName"
}


#MAIN
trap killHandle 9
if [ "$#" -eq 1 ]
then
echo "I ended in here"
#  while :
#  do
#    :
    #Waiting for the program to finish via trap ~ PC turn off or ps kill
#  done
elif [ "$#" -eq 2 ]
then
  dateEndDay=$(date +%Y\-%m\-%d)
  dateEnd=$(echo "$dateEndDay" "$2")
  timeHandle
fi
