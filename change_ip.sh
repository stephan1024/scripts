#!/bin/bash
FROMIP=`echo $1`
TOIP=`echo $2`

	if [[ -z $1 || -z $2 || -n $3 ]]; then
		echo "Please specify the IP that need to be changed and to what it needs to change to...
 example: ./change_ip.sh 192.168.122.10 192.168.122.22

Please note if an machine is availabale on the to IP it will be shut down first. "
	else
     		ssh root@$TOIP `poweroff`
		ssh root@$FROMIP `sed -i 's\\$FROMIP\\$TOIP\\g' /etc/sysconfig/network-scripts/ifcfg-bond0 && sed -i 's\\$FROMIP\\$TOIP\\g' /etc/hosts`
	fi

