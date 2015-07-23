#!/bin/bash

#
# Server research script via markdown.
#

HOSTNAME=`hostname`
HOSTNAME_SHORT=`hostname -s`
HOSTNAME_DOMAIN=`hostname -d`
HOSTNAME_FULL=`hostname -f`
MDFILENAME=${HOSTNAME_SHORT}_server_status.md
SERVER_DESCRIPTION="No desctiptions..."
if [ -f ${HOSTNAME_SHORT}_server_info.txt ]; then
SERVER_DESCRIPTION=$(cat << EOS
`cat ~/${HOSTNAME_SHORT}_server_info.txt`
EOS
)
fi
TMP_FILE=$(cat << EOS

${HOSTNAME} SERVER STATUS
===

Timestamp: `date`

## 1. Summary

### 1-1. DESCRIPTION

\`\`\`bash
${SERVER_DESCRIPTION}
\`\`\`

### 1-2. HOSTNAME

\`\`\`bash
HOST  : ${HOSTNAME}
SHORT : ${HOSTNAME_SHORT}
DOMAIN: ${HOSTNAME_DOMAIN}
LONG  : ${HOSTNAME_FULL}
OS    : `cat /etc/redhat-release`
KERNEL: `uname -a`
\`\`\`

### 1-3. NETWORK INTERFACE

"ifconfig"

\`\`\`bash
`ifconfig`
\`\`\`

"cat /etc/udev/rules.d/70-persistent-net.rules"

\`\`\`bash
`cat /etc/udev/rules.d/70-persistent-net.rules`
\`\`\`

"netstat -nr"

\`\`\`bash
`netstat -nr`
\`\`\`

"arp -an"

\`\`\`bash
`arp -an`
\`\`\`

"cat /etc/hosts"

\`\`\`bash
`cat /etc/hosts`
\`\`\`

### 1-4. RUNNING PROCESS

"pstree"

\`\`\`bash
`pstree`
\`\`\`

### 1-5. SECURITY

"getenforce"

\`\`\`bash
`getenforce`
\`\`\`

## 2. HARDWARE INFO

"cat /proc/cpuinfo"

\`\`\`bash
`cat /proc/cpuinfo`
\`\`\`

"cat /proc/meminfo"

\`\`\`bash
`cat /proc/meminfo`
\`\`\`

## 3. MEMORY USAGE

"free -mt"

\`\`\`bash
`free -mt`
\`\`\`

## 4. DISC DRIVE USAGE

### 4-1. PARTITION

"df -Th"

\`\`\`bash
`df -Th`
\`\`\`

### 4-2. TOP DIRECTORY

"ionice -c 2 -n 7 nice -n 19 du -sck /* | sort -rn"

\`\`\`bash
`ionice -c 2 -n 7 nice -n 19 du -sck /* | sort -rn`
\`\`\`

## 5. FIREWALL

"service iptables status"

\`\`\`bash
`service iptables status`
\`\`\`

## 6. ROUTING TABLE

"route"

\`\`\`bash
`route`
\`\`\`

## 7. DNS

"cat /etc/resolv.conf"

\`\`\`bash
`cat /etc/resolv.conf`
\`\`\`

## 8. NTP

"ntpq -p"

\`\`\`bash
`ntpq -p`
\`\`\`

## 9. STARTUP SERVICES

"chkconfig --list"

\`\`\`bash
`chkconfig --list`
\`\`\`

## 10. USERS

"getent passwd"

\`\`\`bash
`getent passwd`
\`\`\`

## 11. ROUTINE TASKS

"find /var/spool/cron -type f -print0 | xargs -0 cat"

\`\`\`bash
　
`find /var/spool/cron -type f -print0 | xargs -0 cat`
\`\`\`

## 12. PROCESS

"ps auxww"

\`\`\`bash
`ps auxww`
\`\`\`

## 13. INSTALLED PACKAGES

"rpm -qa"

\`\`\`bash
`rpm -qa`
\`\`\`

EOS
)
echo "${TMP_FILE}" 1>${MDFILENAME} 2>&1
