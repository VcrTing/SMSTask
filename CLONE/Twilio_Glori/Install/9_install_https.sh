echo '安装 HTTPS'
sudo certbot renew --dry-run
sudo certbot --nginx
# sudo certbot install --cert-name crm05.svr.up5d.com
echo '安装 完成'