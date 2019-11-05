### Usage method
Backup zabbix mysql database

```
chmod 700 /scripts/zabbix-mysql-backup-master/zabbix_mysqldump.sh	
sh /scripts/zabbix-mysql-backup-master/zabbix_mysqldump.sh mysqldump	#备份数据
crontab -e 
0 3 * * *  /scripts/zabbix-mysql-backup-master/zabbix_mysqldump.sh mysqldump	#加入定时任务
sh /scripts/zabbix-mysql-backup-master/zabbix_mysqldump.sh mysqlimport		#恢复数据
```
### Backup demonstration

```
执行完脚本备份路径中查看
[root@s-30 /]# cd mysql_backup/
[root@s-30 mysql_backup]# ls
2019-11-05  logs
[root@s-30 2019-11-05]# cd ..
[root@s-30 mysql_backup]# ls
2019-11-05  logs
[root@s-30 mysql_backup]# cd logs/
[root@s-30 logs]# ls
ZabbixMysqlDump.log
[root@s-30 logs]# cat ZabbixMysqlDump.log 
2019-11-05: Backup zabbix succeed
[root@s-30 logs]# 
```