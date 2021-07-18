echo '======================>'
echo ''
echo ''
echo '安装 Supervisor'
yum remove supervisor -y
yum install supervisor -y
systemctl enable supervisord
echo '安装完成'
# rm -rf /etc/supervisord.conf
# cp ./SAVE/supervisord.conf /etc/supervisord.conf
echo '文件 配置完成'
echo ''
echo '<======================'