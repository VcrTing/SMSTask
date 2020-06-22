import os, uuid
from PIL import Image

import Twilio.settings as settings

def _size(size):
    try:
        size = int(size)
    except:
        return 0
    return int(size / 1024)

def _quality(size):
    size = _size(size)
    
    if size == 0:
        return None

    if size > settings.COMP:
        if size < (settings.COMP * 1.5):
            return 70
        if size < 5000:
            return 60
        if size < 7500:
            return 50
        if size < 10000:
            return 40
        if size < 20000:
            return 30
        else:
            return 15
    else:
        if size > (settings.COMP // 1.5):
            return 80
        if size > (settings.COMP // 2):
            return 75
    return 100

def _thum(w, h, size):
    res = _quality(size)
    size = _size(size)
    if res:
        if res == 100:
            if size > (settings.COMP // 6):
                if size > (settings.COMP // 2):
                    res = 50
                else:
                    res = 60
        else:
            if res > 38:
                res = res // 2
    return res

def _img_name(ext, f):
    res = 'HSIZE_'
    if f == 'img_tiny':
        res = 'TINY_'
    res += uuid.uuid4().hex + '.' + ext
    return os.path.join(f, res)

def save(rec, ext, f, quality):
    res = _img_name(ext, f)
    
    if f == 'img_tiny':
        pass
    rec.thumbnail(
        ((rec.width * (quality / 100)),
        (rec.height * (quality / 100)))
    )
    
    rec.save(
        os.path.join(
            settings.MEDIA_ROOT,
            res
        ),
        quality = 95,
        subsampling = 0
    )
    return res
