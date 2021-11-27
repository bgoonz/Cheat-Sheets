#!/bin/sh

sleep 60

if [ "X`pidof unity-panel-service`" != "X" ]
then
 $@
else
 echo "`date` -- Fail to launch $@ (unity-panel-service not running)" >> ~/start_with_delay.sh
fi