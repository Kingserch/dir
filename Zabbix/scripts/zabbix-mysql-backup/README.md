### Usage method
Backup zabbix mysql database

```
chmod 700 /scripts/zabbix-mysql-backup-master/zabbix_mysqldump.sh	
sh /scripts/zabbix-mysql-backup-master/zabbix_mysqldump.sh mysqldump	#备份数据
crontab -e 
0 3 * * *  /scripts/zabbix-mysql-backup-master/zabbix_mysqldump.sh mysqldump	#加入定时任务
sh /scripts/zabbix-mysql-backup-master/zabbix_mysqldump.sh mysqlimport		#恢复数据
```