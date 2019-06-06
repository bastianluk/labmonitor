#!/bin/sh
set -euo pipefail
set -x

usage(){
cat <<EOF
SYNTAXE
        ./labmonitor.sh [OPTIONS] TARGETS
POPIS
        The scripts spreads to assigned TARGETS and mointors users logged on to each of the TARGETS and after 
        the end of its run it returns a table of logins with the time they logged in at and the duration they 
        were logged in for

        #TODO
        OPTIONS:
        -s
                Short format print for the table of results
        -f
                Format change for the output table

                Example:
                -f[FLAGS]

                FLAGS:
                a     Adress of PC the login belonged to
                t     Time of the login it belonged to
EOF
}

#ARGs
s=0
ftime=1
fon=1
fadr=1

#FUNC
getFormatFlags() {
  formatErase
  if [[ "$1" =~ a ]]
  then
    fadr=1
  fi
  if [[ "$1" =~ o ]]
  then
    fon=1
  fi

  #TODO
}

formatErase() {
  ftime=0
  fon=0
  fadr=0
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
  case "$option" in
    -s)
      #short table print
      s=1
      ;;
    -f)
      #Format change
      getFormatFlags "$options"
      ;;
    *)
      #Failsafe
      usage
      exit
      ;;
done

#TODO
