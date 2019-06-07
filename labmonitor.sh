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
#set -x

usage(){
cat <<EOF
SYNTAX
        ./labmonitor.sh [OPTIONS] -d=FILE
DESCRIPTION
        #TODO
        The scripts spreads to assigned adresses in FILE and mointors users
        logged on to each of the assigned adresses in FILE and after the end
        of its run it returns a table of logins with the time they logged in at
        and the duration they were logged in for

        OPTIONS:
        -d
                Destination list - list of addresses of machines to monitor
                One address per line

        -s
                Sort... #TODO

                Example:
                #TODO

                FLAGS:
                a     Adress of PC the login belonged to
                n     Login/Name
                t     Time of the login it belonged to
                o     Time spent online/logged in
        -q
                Quiet/Silent... #TODO
        -v
                Verbose... #TODO
        -f
                Format change for the output table... #TODO

                Example:
                -f[FLAGS]

                FLAGS:
                a     Adress of PC the login belonged to
                n     Login/Name
                t     Time of the login it belonged to
                o     Time spent online/logged in
EOF
}


#ARGs
#File with addresses to monitor
file=''
#Quiet/Silent
q=0
#Verbose
v=0
#Format info
f=0
fadr=1
fname=1
ftime=1
fon=1
#Sort info
s=0
sadr=1
sname=1
stime=1
son=1


#FUNC
getFormatFlags() {
  formatErase
  if [[ "$1" =~ a ]]
  then
    fadr=1
  fi
  if [[ "$1" =~ n ]]
  then
    fname=1
  fi
  if [[ "$1" =~ t ]]
  then
    ftime=1
  fi
  if [[ "$1" =~ o ]]
  then
    fon=1
  fi
}
formatErase() {
  fadr=0
  fname=0
  ftime=0
  fon=0
}

#Sort info
getSortFlags() {
  sortErase
  if [[ "$1" =~ a ]]
  then
    sadr=1
  fi
  if [[ "$1" =~ n ]]
  then
    sname=1
  fi
  if [[ "$1" =~ t ]]
  then
    stime=1
  fi
  if [[ "$1" =~ o ]]
  then
    son=1
  fi
}
sortErase() {
  sadr=0
  sname=0
  stime=0
  son=0
}

#Spread
spreadToMachines() {

}


#MAIN
#Print help if needed
if [ "$1" = -h ] || [ "$#" -eq 0 ]
then
  usage
  exit
fi

#Params
for options in $@
do
  case "$options" in
    -d=)
      file=$(echo "$options" | cut 4-)
      echo "$file"
      ;;
    -q)
      #Quiet/Silent
      if [ "$v" -eq 1 ]
      then
        echo "Overwriting verbose - now using quiet."
        v=0
      fi
      q=1
      ;;
    -v)
      #Verbose
      if [ "$q" -eq 1 ]
      then
        echo "Overwriting quiet/silent - now using verbose."
        q=0
      fi
      v=1
      ;;
    -s)
      #Sort
      s=1
      getSortFlags "$options"
      ;;
    -f)
      #Format change
      f=1
      getFormatFlags "$options"
      ;;
    *)
      #Failsafe
      usage
      exit
      ;;
  esac
done

#Spread
mkdir .tmp_labmonitor
address=$(echo $(whoami)"@"$(hostname -f)":"$(pwd)"/.tmp_labmonitor)
while read line
do
  ssh "$line" "sh -s" < labmonitor_worker.sh "$address"
done < "$file"

#Await results
#Have a table of "got result from" and check for all machines


#Compile results


#Cleanup
rm -r .tmp_labmonitor/*
rmdir .tmp_labmonitor
