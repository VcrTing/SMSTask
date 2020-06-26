import json, time, os

from . import config as conf

from .api import sms as sms
from .api import jsms as jsms
from .api import mailgun

from .func import validate as validate
from .func.slice import get_conf
from .func.param import val_sms_content

# Twilio SEND
def twilio_now(reciver, content):
    ACCOUNT_SID, AUTH_TOKEN, SENDER = get_conf('twilio')
    if ACCOUNT_SID:
        return sms.send_msg(content, reciver, ACCOUNT_SID, AUTH_TOKEN, SENDER)
    else:
        return None

# Jsms SEND
def jsms_now(reciver, temp_id, temp_para):
    APP_KEY, MASTER_SECRET, SENDER = get_conf('jsms')
    if APP_KEY:
        jsms_client = jsms.Jsms(APP_KEY, MASTER_SECRET)
        return jsms_client.send_teml(reciver, temp_id, temp_para, time = None)
    else:
        return None

# Email SEND
def mailgun_now(recivers, subject, html):
    APP_KEY, DOMAIN, SENDER = get_conf('mailgun')
    if APP_KEY:
        data = {
            'from': conf.COMPANY + ' <' + conf.EMAIL_NAME + '@' + DOMAIN + '>',
            'to': recivers,
            'h:Reply-To': SENDER,
            'subject': subject,
            'html': html
        }
        return mailgun.send_message(DOMAIN, APP_KEY, data)
    else:
        return None