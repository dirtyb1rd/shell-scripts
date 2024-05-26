#!/bin/bash

#Written by Ben Paris

#Create custom commands in both bash and zsh at the same time

#!/bin/bash

_repeat="Y"

while [ $_repeat = "Y" ]

do

#Gather and add command
	echo "Please type in the custom command you wish to creat. (i.e. setupmyvpn, startupscript, closeapps, etc.)"
	read name
	echo "Please type in the full command with all arguments"
	read cmd
	echo "alias "$name"='"$cmd"'" >> ~/.bashrc
	echo "alias "$name"='"$cmd"'" >> ~/.zshrc
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

#source new bashrc&zshrc
source ~/.bashrc
source ~/zshrc
