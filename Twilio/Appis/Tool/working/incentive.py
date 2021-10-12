import time
from django.db.models import Q

from .email import _serial_email
from .note import _serial_task

from Appis.Additional import models as email_models
from Appis.Record import models as sms_models
from Appis.Web import models as web_models

from ..config import WAY as WAY

_AT = '@'
_XL = '_'

def get_incentive_tasker(way):
    res = web_models.Running.objects.filter( Q(done_status = False) & Q(way = way) )

    if len(res) > 2:
        res = res[0: 2]
    return res

# SMS
def _get_incentive_sms():
    rec = get_incentive_tasker(WAY[0][0])
    if rec:

        index = 0
        for running in rec:
            if running.lock == False:
                running.lock = True
                running.save()

                tasks = running.ids
                tasks = tasks.split(_XL)

                for ids in tasks:
                    ids = str(ids).split(_AT)
                    ids = [int(i) for i in ids]
                    try:
                        _serial_task(ids)
                    except Exception as e:
                        pass
                    index += 1
                    if index % 5 == 0:
                        time.sleep(0.1)

                running.lock = False
                running.done_status = True
                running.block_status = False
                running.save()

# EMAIL
def _get_incentive_email():
    rec = get_incentive_tasker(WAY[1][0])

    if rec:
        for running in rec:
            if running.lock == False:
                running.lock = True
                running.save()

                ids = running.ids
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

