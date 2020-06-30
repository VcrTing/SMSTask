import time, datetime
from datetime import date, timedelta
from django.utils import timezone
from ..api import mailgun as mailgun
from ..func import connect as conn
from ..func import validate as validate 
from ..send import mailgun_now
from ..config import EACH_DAY

from Appis.Additional.models import EmailApply, EmailCollect
from Appis.Web.models import SystemMsg

def _record(sub, msg, way, typed, suc):
    sys = SystemMsg()
    sys.subject = sub
    sys.message = msg 
    sys.typed = typed
    sys.way = way
    sys.success_status = suc
    sys.save()

    return True

def mail(subject, message, typed, reciver):
    suc = False
    recivers = [reciver, ]
    res = mailgun_now(recivers, subject, message)

    if res is not None:
        if 'id' in res:
            suc = True
    res = _record(subject, message, 2, typed, suc)

    return res
