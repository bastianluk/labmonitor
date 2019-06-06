#!/bin/sh
set -euo pipefail
set -x

usage(){
cat <<EOF
SYNTAXE
        ./labmonitor.sh [OPTIONS] FILE
POPIS
        The scripts spreads to assigned adresses in FILE and mointors users logged on to each of the assigned 
        adresses in FILE and after the end of its run it returns a table of logins with the time they logged 
        in at and the duration they were logged in for

        #TODO
        OPTIONS:
        -s
                Sort
                
                Example:
                
                
                FLAGS:
                a     Adress of PC the login belonged to
                n     Login/Name
                t     Time of the login it belonged to
                o     Time spent online/logged in
        -q
                Quiet/Silent
        -v
                Verbose
        -f
                Format change for the output table

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
#Quiet/Silent
q=0
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
    -q)
      #Quiet/Silent
      if [ "$v" -eq 1 ]
      then
        echo "Overwriting verbose - now quiet."
        v=0
      fi
      q=1
      ;;
    -v)
      #Verbose
      if [ "$q" -eq 1 ]
      then
        echo "Overwriting quiet/silent - now verbose."
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
done

#TODO
#Spread

#Await results

#Compile results

