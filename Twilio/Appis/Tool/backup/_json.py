import os, json
from Twilio.settings import BACKUP

from Appis.Tool.func import osed

def _load(name):
    src = os.path.join(BACKUP['MEDIA_SRC'], 'backup', name)
    print('>>>>>>>>>>>>')
    print('LOAD SRC =', src)
    print('>>>>>>>>>>>>')
    return osed.load(src)

def _save(name, data):
    src = os.path.join(BACKUP['MEDIA_SRC'], 'backup', name)
    print('>>>>>>>>>>>>')
    print('SAVE SRC =', src)
    print('>>>>>>>>>>>>')
    return osed.save(src, data)

def insert(rec, f, timed, typed):
    j = []
    data = {}
    
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
        
    if typed == 'media':
        data = {
            'timed': timed,
            'source': rec
        }
        j = _load('Media.json')

    if j == None:
        j = []
    j.append(data)


    if typed == 'mysql':
        res = _save('Data.json', j)

    elif typed == 'media':
        res = _save('Media.json', j)

    if res:
        return True

    return False
