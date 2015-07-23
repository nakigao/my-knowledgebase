#!/bin/bash

#
# public key send to all servers.
#

CONF_FILE=servers.conf

IFSBK=$IFS
IFS=$'\n'
for line in `cat ${CONF_FILE}`; do
  if [[ $line =~ ^(#|\n) ]]; then
    continue
  fi
  HOST=`echo ${line} | cut -d ',' -f 1`
  HOSTSTATUS=`echo ${line} | cut -d ',' -f 2`
  IP=`echo ${line} | cut -d ',' -f 3`
  IPSTATUS=`echo ${line} | cut -d ',' -f 4`
  USERID=`echo ${line} | cut -d ',' -f 5`
  OSVERSION=`echo ${line} | cut -d ',' -f 6`
  DOA=`echo ${line} | cut -d ',' -f 7`
  # check dead and alive and then action
  if [ ${DOA} = "Active" ]; then
    echo ${HOST} start ...
    `./public_key_send.sh ${HOST} ${HOSTSTATUS} ${IP} ${IPSTATUS} ${USERID} ${OSVERSION}`
  else
    echo ${HOST} ignore ...
  fi
done
IFS=$IFSBK