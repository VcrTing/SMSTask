import os, datetime, time

import csv 
from Twilio.company import Now

from Appis.Sms.models import Area
from Appis.User.models import Contact, Tag

def _finish(paths, done):
    n = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
    os.rename(paths, paths + '_' + str(n))

def _deal_save(pk, rec):
    if pk:
        return True
    return {
        'rec': rec,
        'id': pk
    }

def _contact(rec, area, tag):
    contact = Contact()
    contact.first_named = rec[0]
    contact.area = area
    contact.phoned = rec[1]
    
    contact.save()
    if tag is not None:
        tag = [ t.id for t in tag]
        contact.tag.clear()
        for t in tag:
            contact.tag.add(t)

    contact.save()
    return _deal_save(contact.pk, rec)
    # return True

def _import_contact_csv(rec, tag):
    if Now == '123medhk':
        res = []
        rec = list(rec)
        rec = rec[1: ]

        area = Area.objects.get(phoned_prefix = '+852')

        if tag is not None:
            tag = Tag.objects.filter(named = tag)
        index = 0

        for r in rec:
            _save = _contact(r, area, tag)

            if _save is not True:
                res.append(_save)
            else:
                index += 1

            if index % 5 == 0:
                time.sleep(0.1)
                
        return res, index

def import_csv(paths, fields):
    rec = None
    if os.path.exists(paths):
        with open(paths, 'r') as f:

            if str(paths).endswith('csv'):
                rec = csv.reader(f)

            if fields.startswith('ContactTag'):
                res, index = _import_contact_csv(rec, '屈醫生')
                
                _finish(paths, True)
                return res, index

            if fields.startswith('Contact'):
                res, index = _import_contact_csv(rec, None)

                _finish(paths, True)
                return res, index

    return True



