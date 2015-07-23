#!/bin/sh

TIME_STAMP=`date +%Y%m%d%H%M`
if [ $# -ne 2 ]; then
  echo "FATAL: Invalid arguments. arg1=UID arg2=IP" 1>&2
  exit 1
fi
BACKUP_SRC_UID=$1
BACKUP_SRC_IP=$2
BACKUP_SRC_DIR=/
BACKUP_DST_DIR=./archives/${BACKUP_SRC_IP}/${TIME_STAMP}
IGNORE_LIST=./rsync_ignore_list

BACKUP_DIRECTORIES=(
    /var/log
    #  /etc/httpd/conf.d
    #  /etc/mrtg
    #  /etc/postfix
    #  /etc/snmp
    #  /etc/sysconfig/network-scripts
    #  /etc/vsftpd
    #  /etc/yum.repos.d
)

CREATE_ONLY_DIRECTORIES=(
    # /etc/rc.d/
    # /etc/
    # /etc/acpi/actions
    # /etc/selinux/
    # /etc/sysconfig/
    # /etc/systemd/
)

BACKUP_FILES=(
    #  /etc/acpi/actions/power.sh
    #  /etc/chrony.conf
    #  /etc/dracut.conf
    #  /etc/hostname
    #  /etc/php.ini
    #  /etc/selinux/config
    #  /etc/sysconfig/network
    #  /etc/systemd/logind.conf
)

# create local backup directory
if [ ! -e ${BACKUP_DST_DIR} ]; then mkdir -p ${BACKUP_DST_DIR} ; fi

# directory rsync process
for directory in ${BACKUP_DIRECTORIES[@]}; do
  if [ ! -e ${BACKUP_DST_DIR}${directory} ]; then mkdir -p ${BACKUP_DST_DIR}${directory} ; fi
  rsync \
    --force \
    --ignore-errors \
    --exclude=${IGNORE_LIST} \
    --delete \
    --delete-excluded \
    -auvz \
    -e ssh ${BACKUP_SRC_UID}@${BACKUP_SRC_IP}:${directory}/* ${BACKUP_DST_DIR}${directory}
done

# JUST create local backup directory ...
for create_directory in ${CREATE_ONLY_DIRECTORIES[@]}; do
  if [ ! -e ${BACKUP_DST_DIR}${create_directory} ]; then mkdir -p ${BACKUP_DST_DIR}${create_directory} ; fi
done

# file rsync process
for file in ${BACKUP_FILES[@]}; do
    rsync \
      --force \
      --ignore-errors \
      --exclude=${IGNORE_LIST} \
      --delete \
      --delete-excluded \
      -auvz \
      -e ssh ${BACKUP_SRC_UID}@${BACKUP_SRC_IP}:${file} ${BACKUP_DST_DIR}${file}
done
