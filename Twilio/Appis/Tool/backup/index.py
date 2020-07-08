import os, json, datetime, time

from Twilio.settings import BACKUP, SQL_CONN
from Appis.Tool.func import osed
from Appis.Tool.backup._json import insert 

from Appis.Tool.backup.source import _mysql
from Appis.Tool.backup.hardriver import _media

FIELD = [
    'all'
]
_sql_cmd = 'mysqldump -u' + SQL_CONN['user'] + ' -p' + SQL_CONN['pass'] + ' ' + SQL_CONN['name']

_zip_cmd = 'zip -r'

def _timed():
    n = datetime.datetime.now()
    name =  str(n.year) + '-' + str(n.month) + '-' + str(n.day)
    return name

def mysql(timed):
    res = [ ]
        
    for f in FIELD:
        if f == 'all':
            print('INDEX mysql sql =', _sql_cmd)
    
            # INSERT MYSQL TO MEDIA DIR
            rec = _mysql(_sql_cmd, f, timed)

            time.sleep(5)
            print('EXISTS _MYSQL REC =', rec)
            if os.path.exists(rec):
                
                # INSERT DATA TO DATA JSON
                print('准备 插入 数据 MYSQL')
                res.append( insert(rec, f, timed, 'mysql') )
            else:
                res.append( False )
    return res

def media(timed):
    res = False

    f = 'MEDIA'
    # INSERT MEDIA TO BACKUP
    rec = _media(_zip_cmd, f, timed)

    time.sleep(5)
    print('EXISTS _MEDIA REC =', rec)
    if os.path.exists(rec):
        # INSERT DATA TO MEDIA JSON
        print('准备 插入 数据 MEDIA')
        insert(rec, f, timed, 'media')
        res = True

    return res
    
def backup():
    
    timed = _timed()
    print('============= BACK UP =============')
    print('timed =', timed)

    res_mysql = mysql(timed)
    res_media = media(timed)

    print('MYSQL RES =', res_mysql)
    print('MEDIA RES =', res_media)
    