import json, time, os
import requests, urllib
from . import config as conf

from .api import sms as sms
from .api import jsms as jsms
from .api import mailgun

from .func import connect as connect
from .func import validate as validate
from .func.slice import get_conf

from .scret import scret

HOST = conf.HOST
HOST_API = conf.HOST_API
EACH_DAY = conf.EACH_DAY

# You Code

# 获取 Every Task
def get_every_task(id):
    url = HOST_API + '/every_task/' + str(id) + '/'
    res = connect.req_Get(url)
    return res

def update_every_task(id, data):
    url = HOST_API + '/every_task/' + str(id) + '/'
    res = connect.req_Update(url, data)
    return res

def update_sms_task(id, data):
    url = HOST_API + '/task/' + str(id) + '/'
    res = connect.req_Update(url, data)
    return res

def get_running_task():
    url = HOST_API + '/running_task/'
    res = connect.req_Get(url)
    return res

def get_running_email():
    url = HOST_API + '/running_email/'
    res = connect.req_Get(url)
    return res

# 短信
def seial_response(data, flag):
    res = {
        'response': data,
        'schedule_id': '0'
    }
    if data:
        if flag == 'twilio':
            res['schedule_id'] = data
        elif flag == 'jsms':
            try:
                res['schedule_id'] = data['msg_id']
            except:
                return res, False
        return res, True
    else:
        return res, False
