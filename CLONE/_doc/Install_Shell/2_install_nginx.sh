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
echo '正在更改 配置文件'
rm -rf /etc/nginx/nginx.conf
cp ./SAVE/nginx.conf /etc/nginx/nginx.conf
echo '完成文件 配置'
echo ''
echo '<======================'