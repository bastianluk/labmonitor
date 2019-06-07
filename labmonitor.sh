#!/bin/sh
###############################################################################
#Script Name    : labmonitor.sh
#Description    : Student project used for monitoring logins on specified
#                 machines
#Author         : Lukas Bastian
#Github         : https://github.com/bastianluk
###############################################################################

#DEBUG
set -euo pipefail

usage(){
  cat <<EOF
SYNTAX
        ./labmonitor.sh [OPTIONS] [-t=TIME] -d=FILE
DESCRIPTION
        The scripts spreads to assigned addresses in FILE and mointors users
        logging on to each of the assigned adresses in FILE and after the end
        of its run it returns a table of logins with the time they logged in at
        and the duration they were logged in for

        OPTIONS:
        -d
                Destination list - list of addresses of machines to monitor
                One address per line
        -v
                Verbose - prints all executed commands (set -x)
        -t
                End time
                Time format:
                %H:%M
EOF
}


#ARGs
file=''
resultFile=$(echo "labmonitor_result_"$(date +%H_%M_%S))
resultFolder=$(echo $(pwd)"/.tmp_labmonitor_"$(date +%H_%M_%S))
address=$(echo $(whoami)"@"$(hostname -f)":""$resultFolder")
#Time
timeParam=''
#Verbose
v=0

#FUNC
#Spread
spreadToMachines() {
  while read line
  do
    if [ "$timeParam" = "" ]
    then
      $(ssh "$line" "sh -s" < labmonitor_worker.sh "$v $address") & pid=$!
      PID_LIST+=" $pid"
    else
      $(ssh "$line" "sh -s" < labmonitor_worker.sh "$v $address $timeParam") & pid=$!
      PID_LIST+=" $pid"
    fi
  done < "$file"

  #TRAP
  trap "kill $PID_LIST" 2 3 9 15

  wait $PID_LIST
}

#Finish
finish() {
  tmpFile=$(echo "tmp_labFormat$resultFile")

  cd "$resultFolder" && ls -v | xargs tac >> "../$tmpFile" && cd ..

  echo -e 'Address\tLogin\tTime Stamps' > "$resultFile"
  cat "$tmpFile" |  sed 's/\([^ ]*\) \([^ ]*\) \([^ ]*\)/\1\t\2\t\3/' >> "$resultFile"

  #Cleanup
  rm "$tmpFile"
  rm -r "$resultFolder"
}

#MAIN
#Print help if needed
if [ "$#" -eq 0 ] || [ "$1" = "-h" ]
then
  usage
  exit
fi

#Params
for options in $@
do
  case "$options" in
    -d\=[a-zA-Z0-9\.]*)
      #Destination
      file=$(echo "$options" | cut -c 4-)
      ;;
    -t\=[0-9][0-9]:[0-9][0-9])
      #Time
      timeParam=$(echo "$options" | cut -c 4-)
      ;;
    -v)
      #Verbose
      set -x
      ;;
    *)
      #Failsafe
      usage
      exit
      ;;
  esac
done

#Spread
mkdir "$resultFolder"
spreadToMachines

#Finish
finish
