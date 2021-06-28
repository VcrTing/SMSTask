import os, json, shutil
from Twilio.settings import BASE_DIR

def load(f, company):
    try:
        _path = os.path.join(BASE_DIR, 'Media', 'data', company, f + '.json')
        
        with open(_path, 'r') as j:
            res = json.loads(j.read())
        return res
    except:
        return None

def save(f, company, data):
    try:
        _path = os.path.join(BASE_DIR, 'Media', 'data', company, f + '.json')
        
        
        with open(_path, 'w') as j:
            j.write(json.dumps(data)) 
        return res
    except:
        return None


def scopy(old, new):

    if os.path.exists(old):

        shutil.copy(old, new)
        return True
    return False

def change_conf(company, new_icon, new_orgin):
    rec = load('_conf', company)

    if rec:
        if new_icon is not False:
            rec['now_icon'] = new_icon
        if new_orgin is not False:
            rec['now_bgimg'] = new_orgin
            
        return save('_conf', company, rec)
    return rec