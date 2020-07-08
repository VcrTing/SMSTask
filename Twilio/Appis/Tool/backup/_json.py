import os, json
from Twilio.setting import BACKUP

from Appis.Tool.func import osed

def _load(name):
    src = os.path.join(BACKUP['MEDIA_SRC'], 'backup', name)
    return osed.load(src)

def _save(name, data):
    src = os.path.join(BACKUP['MEDIA_SRC'], 'backup', name)
    return osed.save(src, data)

def insert(rec, f, timed, typed):
    j = []
    
    if typed == 'mysql':
        data = {
            'timed': timed,
            'content': [
                {
                    'field': f,
                    'source': rec
                }
            ]
        }
        j = _load('Data.json')

    else if typed == 'media':
        data = {
            'timed': timed,
            'source': rec
        }
        j = _load('Media.json')


    if j:
        j.append(data)

        res = _save(j)

        if res:
            return True
    return False
