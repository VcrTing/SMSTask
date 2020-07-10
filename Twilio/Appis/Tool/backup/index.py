import os, json, datetime, time

from Twilio.settings import BACKUP, SQL_CONN, BASE_DIR
from Appis.Tool.func import osed

from Appis.Tool.backup.source import _mysql
from Appis.Tool.backup.source import _trash as _del_mysql

from Appis.Tool.backup.hardriver import _media
from Appis.Tool.backup.hardriver import _trash as _del_media

from Appis.Tool.working.sys import mail
from Appis.common import SYSTEMMSGTYPED
from Twilio.company import Now, SYS_MAIL

FIELD = [
    'all'
]
_sql_cmd = 'mysqldump -u' + SQL_CONN['user'] + ' -p' + SQL_CONN['pass'] + ' ' + SQL_CONN['name']

_zip_cmd = 'zip -r'

_lock = os.path.join(BASE_DIR, 'Media', '_lock.json')

def lockit(word, res):
    data = osed.load(_lock)

    if data:
        data[word] = res
        osed.save(_lock, data)


def _mail(message):
    code = 113
    sub = ' '
    for typed in SYSTEMMSGTYPED:
        if code == typed[0]:
            sub += typed[1]
    
    print('开始发送系统邮件：')
    print(message)
    return mail(sub , message, 2, SYS_MAIL)

def _timed():
    n = datetime.datetime.now()
    name =  str(n.year) + str(n.month) + str(n.day)
    return name

def mysql(timed, msg):
    res = [ ]
    
    for f in FIELD:
        if f == 'all':
            print('INDEX mysql sql =', _sql_cmd)
    
            # INSERT MYSQL TO MEDIA DIR
            rec = _mysql(_sql_cmd, f, timed)

            time.sleep(16)
            # 系统邮件

            print('EXISTS _MYSQL REC =', rec)
            if os.path.exists(rec):
                
                msg += 'Mysql 备份状态： True, '  + '\n'
            else:
                msg += 'Mysql 备份状态： False, ' + '\n'
                res.append( False )

    return res, msg

def media(timed, msg):
    res = False

    f = 'MEDIA'
    # INSERT MEDIA TO BACKUP
    rec = _media(_zip_cmd, f, timed)

    time.sleep(40)
    print('EXISTS _MEDIA REC =', rec)
    if os.path.exists(rec):
        
        msg += '媒体库 备份状态： True, ' + '<br/>'
        res = True
    else:
        msg += '媒体库 备份状态： False, ' + '<br/>'

    return res, msg
    
def _backup():
    
    msg = '[' + Now + ']'

    s = osed.size('/')
    m = osed.size(BACKUP['MEDIA_SRC'])

    if s <= ((m * 2) - 10):
        # 容量不足
        msg = '磁盘剩余容量为：' + str(s) + ' MB，不足以支持媒体库进行备份，请解决。'
    
    else:

        timed = _timed()
        print('============= BACK UP =============')
        print('timed =', timed)

        res_mysql, msg = mysql(timed, msg)
        res_media, msg = media(timed, msg)

        s = osed.size('/')
        m = osed.size(BACKUP['MEDIA_SRC'])
        print('MYSQL RES =', res_mysql)
        print('MEDIA RES =', res_media)

    msg += '<br/>磁盘剩余容量：' + s + ' MB，媒体库容量：' + m + ' MB。'
    res_mail = _mail(msg)
    print('MAIL RES =', res_mail)

def trash():
    timed = _timed()
    res_mysql = _del_mysql(timed)
    res_media = _del_media(timed)
    print('MYSQL DEL RES =', res_mysql)
    print('MEDIA DEL RES =', res_media)
    
def backup():

    backuping = osed.load(_lock)
    if backuping:

        backuping['backuping'] = True
        osed.save(_lock, backuping)

        _backup()
    