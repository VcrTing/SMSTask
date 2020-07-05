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
    print('Email Record 保存成功！！！发送状态 success_status 为：', ec.success_status)
    ec.save()

def _do_email(ea):
    print('--------------- 开始执行 邮件发送 ---------------')
    recivers = [ ea.contact.email,  ]
    subject = ea.email_template.subject
    
    # 这里可能需要序列一下参数
    html = ea.email_template.message
    print('发送邮件的 内容 =', html)
    
    res = mailgun_now(recivers, subject, html)

    # 新增邮件记录
    print('发送邮件的 RES =', res)
    _email_record(ea, res)

    if res is not None:
        # 计算下次时间
        ea.next_time = _ser_next_time(ea.email_template.time_rule * EACH_DAY)
        ea.now_index = int(ea.now_index) + 1
        print('保存好了下次发送时间，为：', ea.next_time)
        ea.save()

        print('--------------- 邮件发送 完毕 ---------------')
        return True
    
    print('--------------- 邮件发送 完毕 ---------------')
    return False

def _serial_email(ids):
    print('============= 序列化邮件开始 =============')
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
                print('该一次性邮件已完结！！！')
                ea.over_status = True
                
            # 保存改动
            ea.save()
    
    print('============= 序列化邮件结束 =============')

def _do_runemail(pk):
    print('============= 任务Running =============')
    ea = EmailApply.objects.get(id = pk)
    return _do_email(ea)