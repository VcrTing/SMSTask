
import os, shutil
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
    
    os.system(cmd)

    return rec

def _f(f):
    s = str(f).split('_')
    return int(s[1])

# TRASH OLD MEDIA DIR
def _trash_media(timed):
    res = [ ]
    try:
            
        fs = osed.files(BACKUP['MEDIA_HARDRIVER'])

        if len(fs) > 0:
            try:
                fs = [f[0] for f in fs if f[0].endswith('.zip')]

                for f in fs:
                    s = _f(f)
                    t = int(timed)
                    if t - s > BACKUP['SAVING_DAY']:
                        src = os.path.join(BACKUP['MEDIA_HARDRIVER'], f)

                        os.remove(src)
                        res.append(True)
            except:
                pass
        
    except Exception as e:
        res.append(True)
        shutil.rmtree(
            BACKUP['MEDIA_HARDRIVER']
        )
        
    return res