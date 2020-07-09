import os, json, datetime, time

from Twilio.settings import BACKUP, SQL_CONN, BASE_DIR
from Appis.Tool.func import osed
from Appis.Tool.backup._json import insert 

from Appis.Tool.backup.source import _mysql
from Appis.Tool.backup.hardriver import _media

from Appis.Tool.working.sys import mail
from Appis.common import SYSTEMMSGTYPED
from Twilio.company import Now, SYS_MAIL

FIELD = [
    'all'
]
_sql_cmd = 'mysqldump -u' + SQL_CONN['user'] + ' -p' + SQL_CONN['pass'] + ' ' + SQL_CONN['name']

_zip_cmd = 'zip -r'

_lock = os.path.join(BASE_DIR, 'Media', '_lock.json')

def unlock():
    backuping = osed.load(_lock)

    if backuping:
        backuping['backuping'] = False

        osed.save(_lock, backuping)

def _mail(message):
    code = 113
    sub = Now + ' '
    for typed in SYSTEMMSGTYPED:
        if code == typed[0]:
            sub += typed[1]
    
    print('开始发送系统邮件：')
    print(message)
    return mail(sub , message, 2, SYS_MAIL)

def _timed():
    n = datetime.datetime.now()
    name =  str(n.year) + '-' + str(n.month) + '-' + str(n.day)
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
                # INSERT DATA TO DATA JSON
                print('准备 插入 数据 MYSQL')
                res.append( insert(rec, f, timed, 'mysql') )
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
        
        msg += '媒体库 备份状态： True, ' + '\n'
        # INSERT DATA TO MEDIA JSON
        print('准备 插入 数据 MEDIA')
        insert(rec, f, timed, 'media')
        res = True
    else:
        msg += '媒体库 备份状态： False, ' + '\n'

    return res, msg
    
def _backup():
    
    msg = '[' + Now + ']'

    timed = _timed()
    print('============= BACK UP =============')
    print('timed =', timed)

    res_mysql, msg = mysql(timed, msg)
    res_media, msg = media(timed, msg)

    res_mail = _mail(msg)
    print('MYSQL RES =', res_mysql)
    print('MEDIA RES =', res_media)
    print('MAIL RES =', res_mail)
    
def backup():

    backuping = osed.load(_lock)

    if backuping:
        backuping['backuping'] = True

        osed.save(_lock, backuping)

        _backup()
    