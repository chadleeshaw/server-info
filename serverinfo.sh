#!/bin/bash

DATE=`/bin/date +date_%d-%m-%y_time_%H-%M-%S`

for host in $1; do
  _CMD="ssh user@$host"
    ## --------------------------------------<General Infromation>-----------------------------------##
    echo "___________________________________________________________________________________"
    echo "**** General Information About This Computer ****"
    echo "___________________________________________________________________________________"
    echo "Architecture:                       `$_CMD uname -m`"
    echo "Kernel:                             `$_CMD uname -r`"
    echo "Distro:                             `$_CMD head -n1 /etc/redhat-release`"
    echo "Hostname:                           `$_CMD hostname`"
    echo "User:                               `$_CMD whoami`"
    echo "Number Users:                `$_CMD users | wc -w`"
    echo "Uptime (hrs/min):                   `$_CMD uptime | awk '{ gsub(/,/, ""); print $3 }'`"
    echo "Run level:                 `$_CMD who -r`"
    echo "Running Process:               `$_CMD ps ax | wc -l`"
    echo "___________________________________________________________________________________"
    ## --------------------------------------<CPU Infromation>---------------------------------------##
    echo "****The CPU Infromation****"
    echo "___________________________________________________________________________________"
    echo "CPU count:                          `$_CMD cat /proc/cpuinfo |  grep -c 'processor'`"
    echo "CPU model:                         `$_CMD cat /proc/cpuinfo | awk -F':' '/^model name/ { print $2;exit }'`"
    echo "CPU vendor                         `$_CMD cat /proc/cpuinfo | awk -F':' '/^vendor_id/ { print $2;exit }'`"
    echo "CPU Speed:                         `$_CMD cat /proc/cpuinfo | awk -F':' '/^cpu MHz/ { print $2;exit }'`"
    echo "CPU Cache:                         `$_CMD cat /proc/cpuinfo | awk -F':' '/^cache size/ { print $2;exit }'`"
    ## --------------------------------------<memory Information>------------------------------------##
    echo "___________________________________________________________________________________"
    echo " ****The Memory Information****"
    echo "___________________________________________________________________________________"
    echo "`$_CMD vmstat -s -S M | egrep -ie 'memory|swap'`"
    echo "___________________________________________________________________________________"
    echo "`$_CMD free -h`"
    echo "___________________________________________________________________________________"
done
