#!/bin/bash
#king
#挂机
#版本：1.0
#游戏服务器部署
#基础环境：MYSQL数据库svn客户端需部署才能运行此脚本
####################################################
if [ "$UID" = "0" ]
then
	echo "game server install"
else
	exit 1
fi
read -p "Please create the storage game server directory：" directory
mkdir /application/$directory
path="/application/$directory"
svn co http://192.168.0.5:8080/svn/Tools/ops/guaji/game_server/game $path --username baisc --password bsc123 > /dev/null
if [ "$?" = "0" ]
then
	echo "ok"
else
	exit 1
fi

########################服务器配置##################################
echo "game_server configure"
configure="/application/$directory/config/bootconfig.xml"
read -p "Please enter your node_name:" node_name
sed -i 's/s111/'$node_name'/' $configure
if [ "$?" = "0" ]
then
	echo "ok"
else
	exit 1
fi

read -p "Please enter your listen_port: " port
sed -i 's/8285/'$port'/' $configure
if [ "$?" = "0" ]
then
	echo "ok"
else
	exit 1
fi

read -p "Please enter your server_id:" id
sed -i 's/111/'$id'/' $configure
if [ "$?" = "0" ]
then
	echo "ok"
else
	exit 1
fi

read -p "Please enter your publicip:" ip
sed -i 's/118.178.130.64/'$ip'/' $configure
if [ "$?" = "0" ]
then
	echo "ok"
else
	exit 1
fi

######################数据库导入##############################
data="/application/$directory/"
echo "database configure"
read -p "Please enter database ip:" address
read -p "Please enter database name:" databasename
read -p "Please enter database user:" user
stty -echo
read -p "Please enter database password:" password
stty echo
echo "being import database"
mysql -h $address -u root -p$password -e "create database $databasename character set 'utf8';"
mysql -h $address -u$user -p$password  $databasename < $data/sql/gamedb.sql 
if [ "$?" = "0" ]
then
	echo "import database ok"
else
	echo "import not ok"
	exit 1
fi
######################数据库配置##############################
databaseconfigure="/application/$directory/config/database.xml"
sed -i 's/gamedbtest/'$databasename'/' $databaseconfigure     #数据库名
sed -i 's/127.0.0.1/'$address'/'  $databaseconfigure        #数据库ip
sed -i 's/root/'$user'/' $databaseconfigure                 #数据库用户名
sed -i 's/test/'$password'/' $databaseconfigure             #数据库密码


########################启动服务器################################
read -p "Please enter servername:" servername
read -p "Do you want to start the server now?(yes/no)" start
if [ "$start" = "yes" ]
then
	chmod a+x $data/gameserver
	mv $data/gameserver $data/$servername
	cd $data/ && ./$servername -d    
        if [ "$?" = "0" ]
        then
            echo "gameserver is ok"
        else
            echo "not ok "
            exit 1
        fi 
else
	exit 1
fi
