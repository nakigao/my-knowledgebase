#!/bin/bash

#
# run remote research script for all servers.
#

echo "this is legacy script, plz your refactoring!"
exit 1;

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
  # check host and ip
  if [ ${HOSTSTATUS} = "NO" ]; then
    if [ ${IPSTATUS} = "YES" ]; then
      # override host value to ip value
      HOST=${IP}
    else
      echo ${HOST} and ${IP} can not resolved ...
      continue;
    fi
  fi
  # check dead and alive and then action
  if [ ${DOA} = "Active" ]; then
    echo ${HOST} start ...
    `ssh ${USERID}@${HOST} rm -f ${HOST}.mydomain.local_server_status.md`
  else
    echo ${HOST} ignore ...
  fi
done
IFS=$IFSBK