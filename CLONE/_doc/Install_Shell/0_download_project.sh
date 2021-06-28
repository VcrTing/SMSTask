echo '======================>'
echo ''
echo ''
## GIT
echo '安装 GIT'
yum install -y git
yum install -y vim
echo '安装 完成'
echo '准备下载 项目'
cd ~
mv SMSTask OLDER_SMSTask
git clone 'https://www.github.com/VcrTing/SMSTask.git'
echo '项目 下载完成'
echo '<======================'