echo '======================>'
echo ''
echo ''
echo '安装 Snapd'
sudo yum install epel-release -y
sudo yum install snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
echo 'Snapd 安装完成'
echo '...'
echo '安装 Core'
sudo snap install core
sudo snap refresh core
echo 'Core 安装完成'
echo '...'
echo '安装 Certbot'
sudo yum remove certbot -y
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
echo 'Certbot 安装完成'
echo '获取本地域名'
domain=$(cat /etc/hostname)
echo '配置 Cerbot'
mkdir -p /var/www/certbot

echo ''
echo ''
grep 'temporary password' /var/log/mysqld.log
# echo '配置 Https'
# sudo certbot --nginx
# certbot certonly --preferred-challenges dns --manual  -d $domain --server https://acme-v02.api.letsencrypt.org/directory
