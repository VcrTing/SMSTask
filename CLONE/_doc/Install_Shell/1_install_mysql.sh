echo 'START INSTALL'
echo '======================>'
echo ''
echo ''
mysql_package='mysql80-community-release-el7-3.noarch.rpm'
## MYSQL
echo '准备安装 Mysql'
older_db=$(rpm -qa | grep mariadb)
rpm -e --nodeps $older_db
unset $older_db
yum update -y
### 开始下载，然后安装
echo '安装 Mysql'
wget https://dev.mysql.com/get/$mysql_package
rpm -Uvh https://dev.mysql.com/get/$mysql_package
yum install -y mysql-community-server
service mysqld start
### 查看状态，准备登录
echo '安装 完成。'
systemctl enable mysqld.service
password=$(grep 'temporary password' /var/log/mysqld.log)
echo ''
echo '当前安装的MYSQL的备用密码为：'
echo $password
now_path=$(pwd)
rm -rf ./$mysql_package
echo ''
echo '<======================'
unset $password
unset $mysql_package
## 结束
