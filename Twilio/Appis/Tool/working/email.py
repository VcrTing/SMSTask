import time, datetime
from datetime import date, timedelta
from django.utils import timezone
from ..api import mailgun as mailgun
from ..func import connect as conn
from ..func import validate as validate 
from ..send import mailgun_now
from ..config import EACH_DAY

from Appis.Additional.models import EmailApply, EmailCollect

def _ser_next_time(n):
    if (n < 0):
        n = abs(n)
        return date.today() - timedelta(days=n)
    else:
        return date.today() + timedelta(days=n)
        
def _email_record(ea, response):

    ec = EmailCollect()
    
    ec.email_apply = ea 
    ec.email_template = ea.email_template
    ec.json_response = response

    ec.send_time = timezone.now()
    ec.index = int(ea.now_index) + 1

    if response is not None:
        if 'id' in response:
            ec.success_status = True

    ec.save()

def _do_email(ea):
    recivers = [ ea.contact.email,  ]
    subject = ea.email_template.subject
    
    # 这里可能需要序列一下参数
    html = ea.email_template.message
    
    res = mailgun_now(recivers, subject, html)

    # 新增邮件记录
    _email_record(ea, res)

    if res is not None:
        # 计算下次时间
        ea.next_time = _ser_next_time(ea.email_template.time_rule * EACH_DAY)
        ea.now_index = int(ea.now_index) + 1
        ea.save()
        return True
    return False

def _serial_email(ids):
    for i in ids:
        res = False
        ea = EmailApply.objects.get(id = i)
        
        if ea.status and (ea.apply_status is not True):
            # 设置已生效
            ea.apply_status = True

            # 首发
            if ea.send_status == True:
                ea.now_index = 0
                res = _do_email(ea)

            # 是否完结
            if res and (ea.email_template.time_rule == 0):
                ea.over_status = True
                
            # 保存改动
            ea.save()

def _do_runemail(pk):
    ea = EmailApply.objects.get(id = pk)
    return _do_email(ea)