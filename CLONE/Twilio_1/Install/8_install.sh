echo '======================>'
echo ''
echo ''
echo '执行项目安装'
python3 manage.py migrate
echo '数据同步完成'
echo '...'
cp ./nginx.http.conf /etc/nginx/conf.d/project.conf
echo 'Nginx 文件配置完成'
cp ./supervisor.conf /etc/supervisord.d/project.conf
echo 'Supervisor 文件配置完成'
echo '...'
echo '准备导入数据'
mysqldump -u root -p agegroupltd < ../../_doc/Install_Shell/SAVE/tsms.sql 
echo '导入数据 完成'
echo '完成'
echo ''
echo '<======================'