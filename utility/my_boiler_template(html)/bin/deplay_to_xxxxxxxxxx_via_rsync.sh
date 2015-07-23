#!/bin/sh
LOCAL_DIR=/cygdrive/c/Users/user/Documents/PhpstormProjects
REMOTE_UID=root
REMOTE_HOST=xxx.xxx.xxx.xxx
REMOTE_DIR=/var/www
PROJECT_NAME=xxxxxxxxxx
COMMAND1="rsync \
    -avuz \
    --owner \
    --group \
    --perms \
    --delete \
    --exclude=.git/ \
    --exclude=.idea/ \
    --exclude=.gitkeep \
    --exclude=.gitignore \
    --exclude=bin/ \
    -e ssh ${LOCAL_DIR}/${PROJECT_NAME}/ ${REMOTE_UID}@${REMOTE_HOST}:${REMOTE_DIR}/${PROJECT_NAME}/
"
$COMMAND1

COMMAND2="ssh ${REMOTE_UID}@${REMOTE_HOST} chown root:root -R ${REMOTE_DIR}/${PROJECT_NAME}"
$COMMAND2

COMMAND3="ssh ${REMOTE_UID}@${REMOTE_HOST} chmod 755 -R ${REMOTE_DIR}/${PROJECT_NAME}"
$COMMAND3

COMMAND4="ssh ${REMOTE_UID}@${REMOTE_HOST} chmod 777 -R ${REMOTE_DIR}/${PROJECT_NAME}/tmp"
$COMMAND4

