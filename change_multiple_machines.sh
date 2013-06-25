#!/bin/bash
ARGS=`echo $2`
ENVIROMENT=`echo $1`

if [[ -z $ENVIROMENT || $ENVIROMENT != "dev" && $ENVIROMENT != "prod" && $ENVIROMENT != "qa" ]]; then
	if [ $ENVIROMENT = "--help" ]; then
		echo "
	The command usage is as follows:
	example:	./change_multiple_machines.sh dev \"mv file.txt newfile.txt\"
		This will execute the selected command on all the machines in ENVIROMENT_machines.txt list"
        else
		echo "Please use any of the following enviroment terms: 
	dev
	qa
	prod
	oa"
	fi
else
	if [[ -z $ARGS || -n $3 ]]; then
		echo "Please specify the command to be run on all the machines, encapsulated with \" \" "
		if [ $3 -eq "--help"]; then
			echo "a Command example is as follows: 
	./change_multiple_servers.sh dev \"mv file.txt newfile.txt\"
		This will execute the selected command on all the machines in ENVIROMENT_machines.txt list"
		fi
	else
		for ip in $(cat `echo $ENVIROMENT`_machines.txt | awk '{print $2}'); do

     		ssh root@$ip `echo "'$ARGS'"`

		done
	fi
fi

