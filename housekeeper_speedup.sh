#! /bin/bash

########################
# Housekeeper speed up #
########################


check_log () {
        key=$(cat "$1" | grep housekeeper | tail -n 1 | awk '{print$2}')
        if [ $key == "executing" ]
	then
                :
        elif [ $key == "server" ]
	then
                sleep 30m
                $executing
        elif [ $key == "housekeeper" ]
	then
                $executing
        elif [ -z $key ]
	then
                check_log /var/log/zabbix/zabbix_server.log.1
        else
                exit 1
        fi
}


executing="zabbix_server -c /etc/zabbix/zabbix_server.conf -R housekeeper_execute"
while true
do
        check_log /var/log/zabbix/zabbix_server.log
	sleep 1m
done
exit 0
