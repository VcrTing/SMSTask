#!/bin/sh
### 查看密码，准备登录
echo '======================>'
echo 'MYSQL 安装 完成。'

password=$(grep 'temporary password' /var/log/mysqld.log)
echo '当前安装的MYSQL的备用密码为：'
echo $password
### 登录 mysql
mysql -u root -p $password <<EOF
alter user 'root'@'localhost' identified by 'VcrTing.ZT123zlt';
grant all privileges on *.* to 'root'@'%';
FLUSH PRIVILEGES;
exit;
EOF
echo 'MYSQL 操作完成'
echo ''
echo 'MYSQL新改的密码为:'
echo 'VcrTing.ZT123zlt'
service mysqld restart
### 完成
echo '<======================'