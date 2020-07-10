import os, json, datetime

from Twilio.settings import BACKUP, SQL_CONN
from Appis.Tool.func import osed

# DUMP SQL TO THE MEDIA DIR
def _mysql(cmd, f, timed):
    rec = os.path.join(BACKUP['MYSQL_SRC'], timed)
    _file = f + '_' + timed + '_.sql'

    if osed.path(rec):
        pass
    else:
        os.makedirs(rec)

    rec = os.path.join(rec, _file)

    cmd = str(cmd + ' > ' + rec)

    print('SOURCE _MYSQL CMD =', cmd)
    os.system(cmd)

    return rec

def _f(f):
    s = str(f).split('_')
    return int(s[1])
    
def _trash(timed):
    res = [ ]

    fs = osed.files(BACKUP['MYSQL_SRC'])

    print('MYSQL FILES =', fs)
    fs = [if f.endswith('.sql') for f in fs]
    
    if fs:

        for f in fs:
            s = _f(f)
            if s < int(timed):
                src = os.path.join(BACKUP['MYSQL_SRC'], f)
                print('FILES SRC =', src)
                os.remove(src)
                res.appen(True)
    return res

        