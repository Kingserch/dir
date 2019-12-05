#!/bin/bash
#author:king
#blog:https://www.cnblogs.com/liang-io/
#usage:
#定义时间变量，用于纪录日志
d=`date --date today +%Y%m%d_%H:%M:%S`
#计算nginx的进程数量
n=`ps -C nginx --no-heading|wc -l`
#如果n为0，则启动nginx，并在次检测nginx，还是为0说明nginx无法启动，则关闭Keepalived
if [ $n -eq "0" ]; then 
	systemctl start nginx
   	n2=`ps -C nginx --no-heading|wc -l`
  if [ $n2 -eq "0" ]; then 
     	echo "$d nginx,keepalived will stop" >> /var/log/check_ng.log
	systemctl stop keepalived
  fi
fi
