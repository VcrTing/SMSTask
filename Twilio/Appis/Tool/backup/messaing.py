import datetime

from django.db.models import Q

from Twilio.settings import MESSING_PHONE

from Appis.Record.models import SmsTask, EveryTask
from Appis.Sms.models import SmsTemplate, Area


def messing_again():
    i = datetime.datetime.now()

    res = EveryTask.objects.filter(
        # Q(send_status = True) & 
        Q(contact__phoned = MESSING_PHONE[1]) &
        Q(status = True)
        )

    try:

        res = res[0]

        doing = True
        t = res.send_finish_time

        # print('T =', t)
        if i.month == t.month:
            if i.day == t.day:
                doing = False

        # print('doing = ', doing)  
        if doing:
            res.send_status = False
            res.apply_status = False
            res.send_finish_time = datetime.datetime.now()
            res.save()

    except Exception as e:
        print('Err =', e)
