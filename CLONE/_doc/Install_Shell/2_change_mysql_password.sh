#!/bin/sh
### 查看密码，准备登录
echo '======================>'
echo 'MYSQL 安装 完成。'

password=$(grep 'temporary password' /var/log/mysqld.log)
echo '当前安装的MYSQL的备用密码为：'
echo $password
read -t 60 -p "请输入该备用密码:" password
### 书写 mysql 命令
change_pwd="alter user 'root'@'localhost' identified by 'VcrTing.ZT123zlt';"
change_role="grant all privileges on *.* to 'root'@'%';"
refresh="FLUSH PRIVILEGES;"
### 执行命令
mysql -uroot -p$password -e $change_pwd --connect-expired-password
mysql -uroot -p$password -e $change_role --connect-expired-password
mysql -uroot -p$password -e $refresh --connect-expired-password
echo 'MYSQL 操作完成'
echo ''
echo 'MYSQL新改的密码为:'
echo 'VcrTing.ZT123zlt'
service mysqld restart
### 完成
echo '<======================'