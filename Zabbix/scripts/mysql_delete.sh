#!/bin/bash

MYSQL_BIN=mysql       #MySQL的程序
MYSQL_USER=zabbix     #MySQL的用户名
MYSQL_PWD=zabbix      #MySQL的密码
MYSQL_PORT=3306       #MySQL的端口
MYSQL_HOST=127.0.0.1  #MySQL的IP
DB_NAME=zabbix        #数据库名称
MYSQL_LOGIN="${MYSQL_BIN} -u${MYSQL_USER} -p${MYSQL_PWD} -h${MYSQL_HOST} -P${MYSQL_PORT} ${DB_NAME}"
triggerids="13614 13684" #此处填写需要被删除的故障的triggerid
for ID in ${triggerids};do
	echo "------------------------------------------------------"
	echo "update zabbix.triggers set value=0 where triggerid=${ID} and value=1"
	${MYSQL_LOGIN} -e "update zabbix.triggers set value=0 where triggerid=${ID} and value=1" 2>&1 | grep -v "Warning: Using a password"
	echo "delete from zabbix.events where objectid=${ID} and object=0"
	${MYSQL_LOGIN} -e "delete from zabbix.events where objectid=${ID} and object=0" 2>&1 | grep -v "Warning: Using a password"
#4.0版本还需要清理problem表的数据记录
	${MYSQL_LOGIN} -e "delete from zabbix.problem where objectid=${ID} and object=0" 2>&1 | grep -v "Warning: Using a password"
  echo ""
done
