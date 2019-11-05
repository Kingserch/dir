Backup zabbix mysql database

```
chmod 700 /scripts/zabbix-mysql-backup-master/zabbix_mysqldump.sh		
crontab -e 
0 3 * * *  /scripts/zabbix-mysql-backup-master/zabbix_mysqldump.sh mysqldump
```

##Usage method