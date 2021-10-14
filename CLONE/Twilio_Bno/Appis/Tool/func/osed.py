import os, json

def path(rec):
    return os.path.exists(rec)

def _size(rec):
    size = 0
    for root, dirs, files in os.walk(rec):
        size += sum(
            [
                os.path.getsize(
                    os.path.join(root, name)
                ) for name in files
            ]
        )
    return size

def size(rec):
    res = _size(rec)
    return int(res / 1024 / 1024)

def size_full():
    info = os.statvfs('/')
    
    free = info.f_bsize * info.f_bavail / 1024 / 1024
    return int(free)


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