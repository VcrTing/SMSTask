from .tool import load

from Appis.Sms import models as sms_models
from Twilio.company import SETTING


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
    
def init(company):
    return {
        'area': _insert_area(company),
        'cate': _insert_category(company),
    }