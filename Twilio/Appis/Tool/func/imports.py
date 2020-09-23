import os 
import csv 
from Twilio.company import Now

from Appis.User.models import Contact

def _finish(paths, done):
    os.rename(paths, paths + '_done')

def _import_contact(rec):
    if Now == '123medhk':
        for r in rec:
            
            print(r)
            contact = Contact()

def import_csv(paths, fields):
    rec = None
    if os.path.exists(paths):
        with open(paths, 'r') as f:
            if str(paths).endswith('csv'):
                rec = csv.reader(f)

            if fields == 'Contact':
                _import_contact(rec)

                _finish(paths, True)
    return True



