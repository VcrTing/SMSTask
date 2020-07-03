import os, shutil
from Twilio.company import Now
from Twilio.settings import BASE_DIR, MEDIA_ROOT

rec = os.path.join('~', 'Media')

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

def done(f):
    if f:
        if f == 'download':
            return _down()
        if f == 'upload':
            return _up()
    return False