
import os
from Twilio.settings import BACKUP
from Appis.Tool.func import osed

# COPY MEDIA AND ZIP IT TO THE BACKUP DIR
def _media(cmd, f, timed):
    rec = BACKUP['MEDIA_HARDRIVER']
    _file = f + '_' + timed + '_.zip'

    if osed.path(rec):
        pass
    else:
        os.makedirs(rec)

    rec = os.path.join(rec, _file)

    cmd = cmd + ' ' + rec + ' ' + BACKUP['MEDIA_SRC']
    print('HARDRIVER _MEDIA CMD =', cmd)
    os.system(cmd)

    return rec

def _f(f):
    s = str(f).split('_')
    return int(s[1])

# TRASH OLD MEDIA DIR
def _trash(timed):
    res = [ ]

    fs = osed.files(BACKUP['MEDIA_HARDRIVER'])
    print('MEDIA FILES =', fs)

    if fs:
        fs = [f[0] for f in fs if f[0].endswith('.zip')]
        for f in fs:
            s = _f(f)
            if s < int(timed):
                src = os.path.join(BACKUP['MEDIA_HARDRIVER'], f)
                print('FILES SRC =', src)
                os.remove(src)
                res.appen(True)
    return res