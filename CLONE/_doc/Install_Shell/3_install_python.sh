echo '======================>'
echo ''
echo ''
### Python
echo '安装 PYTHON 依赖'
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make
echo '安装 PYTHON 3.6.4'
cd ~
wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
tar -zxvf Python-3.6.4.tgz
cd Python-3.6.4
./configure && make &&make install
echo '安装 完成'
cd ..
rm -rf Python-3.6.4.tgz
rm -rf Python-3.6.4
echo ''
echo '<======================'