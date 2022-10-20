#!/bin/bash
TYPE=$1
NAME=$2
STATE=$3
LOG_STR="$(date) $STATE"
case $STATE in
 "MASTER")
 echo "MASTER" > ./pa.lock
 rm -f /usr/share/wimark/volumes/mongo/*.lock
 cd /etc/wimark/backup; docker-compose down
 cd /etc/wimark/master; docker-compose up -d
 LOG_STR="$LOG_STR: start master"
 ;;
 "BACKUP")ls
 echo "BACKUP" > ./pa.lock
 sleep 10
 [ $(cat ./pa.lock) != "BACKUP" ] && exit 0
 rm -f /usr/share/wimark/volumes/mongo/*.lock
 cd /etc/wimark/master; docker-compose down
 cd /etc/wimark/backup; docker-compose up -d
 LOG_STR="$LOG_STR: start backup"
 ;;
 "FAULT")
  LOG_STR="$LOG_STR: fault"
 ;;
 *)
 LOG_STR="$LOG_STR: unknown"
 ;;
esac
echo $LOG_STR >> /var/log/wimark-keepalived.log
