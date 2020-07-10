import os, json

def path(rec):
    return os.path.exists(rec)

def size(rec):
    if os.path.exists(rec):
        info = os.statvfs(rec)
        print('info.f_bsize =', info.f_bsize, ', info.f_bavail =', info.f_bavail)
        free = info.f_bsize * info.f_bavail / 1024 / 1024
        return int(free)
    return None

def files(rec):
    f = []
    for root, dirs, files in os.walk(rec):  
        f.append(files)
    return f

def trash(rec):
    if os.path.exists(rec):
        os.remove(rec)

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