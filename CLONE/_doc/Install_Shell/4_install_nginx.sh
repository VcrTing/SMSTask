echo '======================>'
echo ''
echo ''
### Nginx
echo '准备安装 NGINX'
yum -y remove nginx
sudo yum install -y epel-release
yum -y update
echo '...'
yum -y install nginx
systemctl enable nginx.service
echo '安装 完成'
echo '<======================'