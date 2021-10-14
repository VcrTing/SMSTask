import os, json, datetime, shutil

from Twilio.settings import BACKUP, SQL_CONN
from Appis.Tool.func import osed

# DUMP SQL TO THE MEDIA DIR
def _mysql(cmd, f, timed):
    rec = BACKUP['MYSQL_SRC']
    _file = f + '_' + timed + '_.sql'

    if osed.path(rec):
        pass
    else:
        os.makedirs(rec)

    rec = os.path.join(rec, _file)

    cmd = str(cmd + ' > ' + rec)
    os.system(cmd)

    return rec

def _f(f):
    s = str(f).split('_')
    return int(s[1])
    
def _trash_mysql(timed):
    res = [ True ]
    try:
        res = [ ]
        fs = osed.files(BACKUP['MYSQL_SRC'])
        if len(fs) > 0:
            try:
                fs = [f[0] for f in fs if f[0].endswith('.sql')]

                for f in fs:
                    s = _f(f)

                    src = os.path.join(BACKUP['MYSQL_SRC'], f)
                    if int(timed) - s > BACKUP['SAVING_DAY']:

                        os.remove(src)
                        res.append(True)
            except:
                pass
    except Exception as e:
        shutil.rmtree(
            BACKUP['MYSQL_SRC']
        )
    return res

        