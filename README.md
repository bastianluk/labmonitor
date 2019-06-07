# Specification
## Description  
This script came to be as a project during the authors studies @ MFF UK in Prague and it is supposed to be used for monitoring select PC from the moment the script is run until the specified end time.  
It outputs a table in the following format:  
> [Address] \t [Login] \t [Time Stamps]  

Where:
- [Address]  
Address of a machine that was monitored  
- [Login]  
User that was logged in at the machine during the monitoring  
- [Time Stamps]  
Time stamps of the login; Either: start and end time + duration of login OR start time and the information, that the user is still logged in at the end of monitoring  

The script relies on the use of `$>last` and communication over SSH.

## Usage  
Taken from:
`$>./labmonitor.sh -h`;
`$>./labmonitor_worker.sh`
```console
SYNTAX
        ./labmonitor.sh [OPTIONS] -t=TIME -d=FILE
DESCRIPTION
        The scripts spreads to assigned addresses in FILE and mointors users
        logging on to each of the assigned adresses in FILE and after the end
        of its run it returns a table of logins with the time they logged in at
        and the duration they were logged in for
        OPTIONS:
        -h
                Help - shows this information
        -d
                Destination list - list of addresses of machines to monitor
                One address per line
        -v
                Verbose - prints all executed commands (set -x)
        -t
                End time of the monitoring
                Time format:
                %H:%M
        -u
                Prints a Unified verion of the log on per user basis
                FLAGS:
                c     ~ Compact
```
```console
SYNTAX
        ./labmonitor_worker.sh VERBOSE RETURN_ADDRESS END_TIME
DESCRIPTION
        Monitors logins for the duration of a run and send results back to
        RETURN_ADDRESS
```
