#!/bin/bash

# All server research script via markdown.

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
  UID=`echo ${line} | cut -d ',' -f 5`
  OSVERSION=`echo ${line} | cut -d ',' -f 6`
  DOA=`echo ${line} | cut -d ',' -f 7`
  echo -e "\r\n"
  echo -e "${HOST}:${IP} start ... "
  echo -e "\r\n\r\n"
  echo -e "PING TO HOSTNAME(${HOST})"
  echo -e "\r\n";
  ping ${HOST}
  echo -e "\r\n";
  echo -e "PING TO IP(${IP})"
  echo -e "\r\n"
  ping ${IP}
  echo -e "---"
  echo -e "\r\n\r\n\r\n"
done
IFS=$IFSBK