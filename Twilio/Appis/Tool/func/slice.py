import json, os

from .. import config as conf
from ..scret import scret

def get_conf(flag):
    try:
        _path = os.path.join(conf.KEY_DIR, flag + '.json')

        with open(_path, 'r') as j:
            res = json.loads(j.read())
        return scret.desalt( res['sid'] ), scret.desalt( res['token'] ), res['sender']
    except:
        return None, None, None
    
def save_key(sid, token, flag, sender):
    _path = os.path.join(conf.KEY_DIR, flag + '.json')
    _data = {
        'sid': scret.vcrting(sid, True),
        'token': scret.vcrting(token, True),
        'sender': sender
    }
    with open(_path, 'w') as j:
        j.write(json.dumps(_data)) 
    return True
