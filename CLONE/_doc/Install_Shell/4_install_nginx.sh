echo '======================>'
echo ''
echo ''
### Nginx
echo '准备安装 NGINX'
yum remove nginx -y
sudo yum install epel-release
yum update -y
echo '...'
yum install nginx -y
systemctl enable nginx.service
echo '安装 完成'
echo '<======================'