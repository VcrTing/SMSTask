import os, json, datetime

from Twilio.settings import BACKUP, SQL_CONN
from Appis.Tool.func import osed

# DUMP SQL TO THE MEDIA DIR
def _mysql(cmd, f, timed):
    rec = os.path.join(BACKUP['MYSQL_SRC'], timed)
    _file = f + '_' + timed + '.sql'

    if osed.path(rec):
        pass
    else:
        os.makedirs(rec)

    rec = os.path.join(rec, _file)

    print('SOURCE _MYSQL REC =', rec)
    cmd = str(cmd + ' > ' + rec)

    print('SOURCE _MYSQL CMD =', cmd)
    os.system(cmd)

    return rec
    
