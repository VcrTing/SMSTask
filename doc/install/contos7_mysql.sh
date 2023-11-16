systemctl stop mariadb.service
systemctl stop mysqld
rpm -qa | grep mariadb
rpm -qa | grep mysqld
cd ~
wget http://repo.mysql.com/yum/mysql-8.0-community/el/7/x86_64/mysql80-community-release-el7-10.noarch.rpm
rpm -ivh ./mysql80-community-release-el7-10.noarch.rpm 
rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
yum install -y mysql-community-server
systemctl start mysqld.service
echo "MYSQL 安裝完成"