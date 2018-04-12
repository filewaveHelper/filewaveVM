#!/bin/bash

mypid=$$

for pid in `ps -ef | grep filewaveVM.sh | awk '{print $2}'` ; do 
if [ "$mypid" != "$pid" ]; then
kill -9 $pid >/dev/null 2>&1 ;
fi 
done
