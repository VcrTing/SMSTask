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
    ec.success_status = False

    if response is not None:
        if 'id' in response:
            ec.success_status = True
    ec.save()

def _do_email(ea):
    recivers = [ ea.contact.email,  ]
    subject = ea.email_template.subject
    
    # 这里可能需要序列一下参数
    html = ea.email_template.message
    
    # 阻隔发送
    # print('=============================')
    send = True
    if ea.send_status:
        if ea.nper == 0:
            send = False
        else:
            if ea.now_index > 0 and ea.first_status == False:
                if ea.nper >= ea.now_index:
                    if ea.across_index <= 0:
                        send = False
    else:
        send = False
        
    send = False
    if ea.send_status:
        # 无限制
        if ea.nper == 0:
            # 首发
            if ea.now_index == 0 and ea.first_status == True:
                send = True
            # 非首发
            else:
                send = False
        # 有限制
        else:
            # 首发
            if ea.now_index == 0 and ea.first_status == True:
                send = True
            # 非首发
            else:
                # 已超出 发送量
                if ea.nper < ea.now_index:
                    send = True
                # 未超出 发送量
                else:
                    if ea.across_index > 0:
                        send = True
                    else:
                        send = False
                        
    # 执行发送
    res = None
    if send:
        res = mailgun_now(recivers, subject, html)

        # 新增邮件记录
        _email_record(ea, res)

    # 计算下次时间
    ea.next_time = _ser_next_time(ea.now_time_rule * EACH_DAY)
    ea.save()
    ea.across_index = int(ea.across_index) + 1

    # 断后
    if send:
        if res is not None:

            if send:
                ea.now_index = int(ea.now_index) + 1

            if ea.nper <= ea.now_index:
                ea.over_status = True

            send = bool(1 - send)
    
    ea.save()
    return not res

def _serial_email(ids):
    index = 0
    for i in ids:
        try:
            ea = EmailApply.objects.get(id = i)
            
            if ea.status and (ea.apply_status is not True):
                # 设置已生效
                ea.apply_status = True

                # 首发
                ea.now_index = 0

                _do_email(ea)
        except e:
            pass
        
        index += 1
        if index % 5 == 0:
            time.sleep(0.5)

def _do_runemail(pk):
    ea = EmailApply.objects.get(id = pk)
    return _do_email(ea)