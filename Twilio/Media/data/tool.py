import os, json
from Twilio.settings import BASE_DIR

def load(f, company):
    try:
        _path = os.path.join(BASE_DIR, 'Media', 'data', company, f + '.json')
        
        with open(_path, 'r') as j:
            res = json.loads(j.read())
        return res
    except:
        return None

