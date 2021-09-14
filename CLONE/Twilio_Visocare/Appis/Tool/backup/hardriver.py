
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
    print('备份命令 =', cmd)
    os.system(cmd)

    return rec

def _f(f):
    s = str(f).split('_')
    return int(s[1])

# TRASH OLD MEDIA DIR
def _trash_media(timed):
    res = [ ]
    shutil.rmtree(
        BACKUP['MYSQL_SRC']
    )
    """
    fs = osed.files(BACKUP['MEDIA_HARDRIVER'])

    if len(fs) > 0:
        try:
            fs = [f[0] for f in fs if f[0].endswith('.zip')]

            print('Media 文件数量 =', str(len(fs)))

            for f in fs:
                s = _f(f)
                t = int(timed)
                if t - s > BACKUP['SAVING_DAY']:
                    src = os.path.join(BACKUP['MEDIA_HARDRIVER'], f)
                    
                    print('====> 删除:', src)

                    os.remove(src)
                    res.appen(True)
        except:
            pass
    """
        
    return res