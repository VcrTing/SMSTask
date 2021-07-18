echo '======================>'
database='agegroupltd'
echo ''
echo ''
echo '执行项目安装'
python3 ../manage.py migrate
echo '数据同步完成'
echo '...'
cp ./nginx.http.conf /etc/nginx/conf.d/project.conf
echo 'Nginx 文件配置完成'
cp ./supervisor.conf /etc/supervisord.d/project.conf
echo 'Supervisor 文件配置完成'
echo '...'
echo '准备导入数据，Mysql 密码为:'
mysqldump -u root -p $database < ../../_doc/Install_Shell/SAVE/tsms.sql 
echo '导入数据 完成'
echo '您需要创建一名用来登录的默认超级用户:'
python3 ../manage.py createsuperuser
echo '创建完成。'
echo ''
echo '您接下来要做的事情为:'
echo '1. 必须初始化数据，您需要进入以下链接: 域名/init/'
echo '2. 如果需要 切换Sms Api收费源，链接为: 域名/scret_window/option=view'
echo '3. 登录后台，操作您需要的数据'
echo ''
echo ''
echo '我们已经执行了 Reboot'
echo ''
echo '<======================'