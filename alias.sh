#!/bin/bash

#Written by Ben Paris

#Create custom commands in both bash and zsh

#!/bin/bash

_repeat="Y"

while [ $_repeat = "Y" ]

do

#Gather and add command
	echo "Please type in the custom command you wish to creat. (i.e. setupmyvpn, startupscript, closeapps, etc.)"
	read cmd
	echo $cmd >> ~/.bashrc
	echo $cmd >> ~/.zshrc
#Prompt for repeat
        echo -n "Do you have another custom command you wish to create? (Y/N)"
        read -n1 Input
        echo # Completes the line
        case $Input in
                [Nn]):
                _repeat="N"
                ;;
        esac
done
