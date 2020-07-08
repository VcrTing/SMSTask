
import os
from Twilio.settings import BACKUP
from Appis.Tool.func import osed

# COPY MEDIA AND ZIP IT TO THE BACKUP DIR
def _media(cmd, f, timed):
    rec = BACKUP['MEDIA_HARDRIVER']
    _file = f + '_' + timed + '.zip'

    if osed.path(rec):
        pass
    else:
        os.makedirs(rec)

    rec = os.path.join(rec, _file)

    cmd = cmd + ' ' + rec + ' ' + BACKUP['MEDIA_SRC']
    print('HARDRIVER _MEDIA CMD =', cmd)
    os.system(cmd)

    return rec