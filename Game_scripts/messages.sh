#!/bin/bash
#清除日志脚本，/var/log/messages
LOG_DIR=/var/log
ROOT_UID=0     #$UID为0的时候，用户才具有root用户的权限
#要使用root用户运行
if ["$UID" -ne "$ROOT_UID"]
then
	echo "Must be root to run this script"
	exit 1
fi
cd $LOG_DIR || {                                  
	echo "cannot change to necessary directory" >&2     # || :是或的意思，如果前面执行不成功则会执行后面的  &2:标准错误
	exit 1
}
cat /dev/null > messages && echo "Logs cleaned up"      #清空日志
exit 0
