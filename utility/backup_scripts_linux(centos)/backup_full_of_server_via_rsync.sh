#!/bin/sh

#
# サーバーのフルバックアップ
#
# ARG1: IPアドレス
#

TIME_STAMP=`date +%Y%m%d%H%M`

if [ $# -ne 2 ]; then
  echo "FATAL: Invalid arguments. arg1=UID arg2=IP" 1>&2
  exit 1
fi
BACKUP_SRC_UID=$1
BACKUP_SRC_IP=$2
BACKUP_SRC_DIR=/

BACKUP_DST_DIR=./archives/${BACKUP_SRC_IP}/${TIME_STAMP}

BACKUP_LOG_DIR=./archives/
BACKUP_LOG_FILE=${BACKUP_LOG_DIR}/server_full_backup_${BACKUP_SRC_IP}_${TIME_STAMP}.log

IGNORE_LIST=./rsync_ignore_list

if [ ! -e ${BACKUP_DST_DIR} ]; then mkdir -p ${BACKUP_DST_DIR} ; fi
if [ ! -e ${BACKUP_LOG_FILE} ]; then touch ${BACKUP_LOG_FILE} ; fi

rsync \
  --log-file=${BACKUP_LOG_FILE} \
  --force \
  --ignore-errors \
  --exclude-from=${IGNORE_LIST} \
  --delete \
  --delete-excluded \
  -auvz \
  -e ssh ${BACKUP_SRC_UID}@${BACKUP_SRC_IP}:${BACKUP_SRC_DIR} ${BACKUP_DST_DIR}
