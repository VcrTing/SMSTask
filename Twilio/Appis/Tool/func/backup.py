import os, shutil
from Twilio.company import Now
from Twilio.settings import BASE_DIR, MEDIA_ROOT

outter = os.path.dirname(os.path.dirname(BASE_DIR))
rec = os.path.join(outter, 'Media')

def _down():
    if os.path.exists(rec):
        shutil.rmtree(rec)
    shutil.copytree(MEDIA_ROOT, rec)
    return True

def _up():
    if os.path.exists(rec):
        if os.path.exists(MEDIA_ROOT):
            shutil.rmtree(MEDIA_ROOT)
        shutil.copytree(rec, MEDIA_ROOT)
    return True

def media(f):
    if f:
        if f == 'download':
            return _down()
        if f == 'upload':
            return _up()
    return False

def _outo():
    pass

def _into():
    pass

def mysql():
    if f:
        if f == 'download':
            return _down()
        if f == 'upload':
            return _up()
    return False