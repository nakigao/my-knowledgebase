#!/bin/sh

setStarttime() {
    start_time=`date +%s`
}

getEndtime() {
    end_time=`date +%s`
    SS=`expr ${end_time} - ${start_time}`
    HH=`expr ${SS} / 3600`
    SS=`expr ${SS} % 3600`
    MM=`expr ${SS} / 60`
    SS=`expr ${SS} % 60`
    echo "${HH}:${MM}:${SS}"
}

setStarttime

#
#
# DO SOMETHING HERE!
#
#

echo "===================="
returnValue=`getEndtime`
echo "process done(${returnValue})"
