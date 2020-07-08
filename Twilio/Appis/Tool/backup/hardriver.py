
from Twilio.setting import BACKUP

# COPY MEDIA AND ZIP IT TO THE BACKUP DIR
def _media(cmd, f, timed):
    rec = BACKUP['MEDIA_HARDRIVER']
    _file = f + ' ' + timed + '.zip'

    if osed.path(rec):
        pass
    else:
        os.makedirs(rec)

    rec = os.path.join(rec, _file)
    print('HARDRIVER _MEDIA REC =', rec)

    cmd = cmd + ' ' + rec + ' ' + BACKUP['MEDIA_SRC']
    print('HARDRIVER _MEDIA CMD =', cmd)
    os.system(cmd)

    return rec