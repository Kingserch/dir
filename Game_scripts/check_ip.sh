#!/bin/bash
while true
do
  awk '{print $1}' access.log|grep -v "^$"|sort|uniq -c > /tmp/tmp.log
  exec </tmp/tmp.log
  while read line
  do
    ip=`echo $link|awk'{print $2}'`
    count=`echo $line|awk '{print $1}'`
      if [ $count -gt 3 ] && [ `iptables -L -n|grep "$ip"|wc -l` -lt 1 ]
      then
        iptables -I INPUT -s $ip -j DROP
        echo "$line is dropped" >>/tmp/droplist.log
      fi
  done
  sleep 5
done
