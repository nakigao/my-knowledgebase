#!/bin/bash

#
# scp command wrapper.
#

if [ $# -ne 6 ]; then
  echo "FATAL: Invalid arguments. arg1=HOST arg2=HOSTSTATUS(YES/NO) arg3=IP arg4=IPSTATUS(YES/NO) arg5=USERID arg6=OSVERSION" 1>&2
  exit 1
fi

HOST=$1
HOSTSTATUS=$2
IP=$3
IPSTATUS=$4
USERID=$5
OSVERSION=$6

# check host and ip
TARGET=${HOST}
if [ ${HOSTSTATUS} = "NO" ]; then
    if [ ${IPSTATUS} = "YES" ]; then
        # override target value to ip value
        TARGET=${IP}
    else
        echo ${HOST} and ${IP} can not resolved ...
        exit 1;
    fi
fi

ssh-copy-id -i ~/.ssh/id_rsa.pub ${USERID}@${TARGET}
