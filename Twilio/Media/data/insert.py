from .tool import load

from Appis.Sms import models as sms_models
from Twilio.company import SETTING

def _insert_template(company):
    template = load('template', company)
    if template == None:
        return False

    for t in template:
        tem = sms_models.SmsTemplate()
        tem.sms_id = t['sms_id']
        tem.sms_id_sub = t['sms_id_sub']
        tem.content = t['content']
        tem.content_sub = t['content_sub']
        tem.lang = t['lang']
        tem.service = sms_models.Service.get(id = t['service'])
        tem.category = t['catregory']
        
        tem.save()
    return True

def _insert_service(company):
    services = load('service', company)
    if services == None:
        return False

    for s in services:
        ser = sms_models.Service()
        ser.named = s['named']
        ser.time_rule = s['time_rule']
        
        ser.save()
    return True

def _insert_category(company):
    cates = load('category', company)
    if cates == None:
        return False

    for c in cates:
        cate = sms_models.Category()
        cate.named = c['named']
        cate.flag = c['flag']
        cate.way = c['way']

        cate.save()
    return True
    
def _insert_area(company):
    areas = load('area', company)
    if areas == None:
        return False

    for a in areas:
        area = sms_models.Area()
        area.phoned_prefix = a['phoned_prefix']
        area.named = a['named']

        area.save()
    return True
    
def insert(company):
    c = sms_models.Category.objects.filter(status = True)
    print('Cate =', c)
    if c:
        return False

    a = sms_models.Area.objects.filter(status = True)
    print('Area =', a)
    if a:
        return False

    return {
        'area': _insert_area(company),
        'cate': _insert_category(company),
    }

def insert_service(company):
    s = sms_models.Service.objects.filter(status = True)
    print('Service =', s)
    if s:
        return False

    t = sms_models.SmsTemplate.objects.filter(status = True)
    print('Template =', t)
    if t:
        return False
    
    return {
        'service': _insert_service(company),
        'template': _insert_template(company)
    }