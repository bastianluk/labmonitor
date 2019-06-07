# Specification
## Description  
\#TODO  

## Usage  
```console
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
```

\#TEMP
> MAIL:  
> Navrhuji program, co se spustí na všech počítačích v labu a začne každou
> sekundu monitorovat, kdo je přihlášen na nějakém PC. Na konci svého běhu
> data vezme a vytvoří tabulku, kde bude pro daný login údaj, kde, kdy a
> jak dlouho byl uživatel přihlášen
