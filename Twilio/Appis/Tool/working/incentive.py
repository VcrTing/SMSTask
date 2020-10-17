import time
from .. import doing as doing
from ..config import WAY as WAY

from .email import _serial_email
from .note import _serial_task

from Appis.Additional import models as email_models
from Appis.Record import models as sms_models
from Appis.Web import models as web_models

_AT = '@'
_XL = '_'

# SMS
def _get_incentive_sms():
    rec = doing.get_incentive_tasker(WAY[0][0])
    if rec:

        index = 0
        for r in rec:
            if r['lock'] == False:
                pk = r['id']
                running = web_models.Running.objects.get(id = pk)
                running.lock = True
                running.save()

                tasks = r['ids']
                tasks = tasks.split(_XL)

                for ids in tasks:
                    ids = str(ids).split(_AT)
                    ids = [int(i) for i in ids]
                    
                    _serial_task(ids)

                    index += 1
                    if index % 5 == 0:
                        time.sleep(0.5)

                running.lock = False
                running.done_status = True
                running.block_status = False
                running.save()

# EMAIL
def _get_incentive_email():
    rec = doing.get_incentive_tasker(WAY[1][0])

    if rec:
        for r in rec:
            if r['lock'] == False:
                pk = r['id']
                running = web_models.Running.objects.get(id = pk)
                running.lock = True
                running.save()

                ids = r['ids']
                ids = ids.split(_XL)
                ids = [int(i) for i in ids]
                
                _serial_email(ids)
                
                running.lock = False
                running.done_status = True
                running.block_status = False
                running.save()

# Incentive
def _get_incentive_tasker():
    _get_incentive_sms()
    time.sleep(0.5)
    _get_incentive_email()

