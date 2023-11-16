cd ~
yum install -y zlib-devel bzip2-devel openssl-devel 
yum install -y ncurses-devel sqlite-devel readline-devel 
yum install -y tk-devel gcc make
wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
tar -zxvf Python-3.6.4.tgz
cd Python-3.6.4
./configure && make &&make install