from datetime import timedelta, date
import datetime
import json

def val_phone(phone_str):
    phone_str = str(phone_str).replace(' ', '')
    phone_str = phone_str.split('|')
    res = []
    for p in phone_str:
        if p != '':
            res.append(p)
    return res

def val_future_datetime(n, offset):
    n += offset
    if (n < 0):
        n = abs(n)
        return date.today() - timedelta(days=n)
    else:
        return date.today() + timedelta(days=n)

def val_send_time(time_rule_belong, each_day, offset):
    now = datetime.datetime.now()
    now_time = str(now.hour) + ':' + str(now.minute) + ':' + str(now.second)
    res = int(time_rule_belong) * int(each_day)
    res = val_future_datetime(res, offset)
    return str(res) + ' ' + now_time

def val_django_response_list(data):
    res = []
    try:
        if data:
            data = data['data']
            data = json.loads(data)
            for d in data:
                _id = d['pk']
                d = d['fields']
                d['id'] = _id
                res.append(d)
        return res
    except:
        return []