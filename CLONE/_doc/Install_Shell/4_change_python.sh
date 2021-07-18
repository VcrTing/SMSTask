echo '======================>'
echo ''
echo ''
echo '安装 依赖'
pip3 install -r ./SAVE/setup.txt
echo '依赖 安装完成'
echo '开始文件纠错'
rm -rf /usr/local/lib/python3.6/site-packages/django/db/backends/mysql/base.py
cp ./SAVE/mysql_base.py /usr/local/lib/python3.6/site-packages/django/db/backends/mysql/base.py
echo '...'
rm -rf vim /usr/local/lib/python3.6/site-packages/django/db/backends/mysql/operations.py
cp ./SAVE/mysql_operations.py /usr/local/lib/python3.6/site-packages/django/db/backends/mysql/operations.py
pip3 install --upgrade pip
echo '...'
echo '文件修错完成'
echo ''
echo '<======================'
