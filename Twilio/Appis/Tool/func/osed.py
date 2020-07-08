import os, json

def path(res):
    return os.path.exists(rec)

def load(rec):
    try:
        _path = rec
        
        with open(_path, 'r') as j:
            res = json.loads(j.read())
        return res
    except:
        return None

def save(rec, data):
    try:
        _path = rec
        
        with open(_path, 'w') as j:
            j.write(json.dumps(data)) 
        return res
    except:
        return None