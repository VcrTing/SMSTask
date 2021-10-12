
import os, csv, time

from Appis.Sms.models import Area
from Appis.User.models import Contact, Tag

from Twilio.settings import MEDIA_ROOT

# BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
# MEDIA_ROOT = os.path.join(BASE_DIR, 'Media')

def _ser_row(r):
    if len(r) >= 4:
        if r[3] == '':
            return None
        if r[2] == r[1]:
            r[1] = '123Medhk客户' 
        if r[2] == '':
            r[2] = r[1]
    return r


def _contact(rec, area, tag):
    contact = Contact()
    contact.first_named = rec[2]
    contact.area = area
    contact.phoned = rec[3]
    
    contact.save()
    if tag is not None:

        contact.tag.clear()
        for t in tag:
            contact.tag.add(t.id)

        contact.save()

    return True

def _saving(rec):
    index = 0
    area = Area.objects.get(phoned_prefix = '+852')
    # tag = Tag.objects.filter(named = '')
    tag = None

    for r in rec:

        r = _ser_row(r)
        if r == None:
            continue
            
        _contact(r, area, tag)

        index += 1
        if index % 100 == 0:
            time.sleep(0.2)

def _doing(file):
    files = os.listdir(file)
    
    for f in files:
        if str(f).startswith('.'):
            continue

        rec = os.path.join(file, f)
        with open(rec, encoding = 'utf-8') as fs:
            
            rec = csv.reader(fs)
            next(rec)
            _saving(rec)

        time.sleep(0.2)
        
def insert_contact():
    file = os.path.join(MEDIA_ROOT, 'data', '123medhk')

    _doing(file)