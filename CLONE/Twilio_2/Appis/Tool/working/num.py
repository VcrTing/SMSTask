import requests, json

from ..api import jsms
from ..func import connect as connect
from ..func.slice import get_conf

def jsms_num():
    APP_KEY, MASTER_SECRET, SENDER = get_conf('jsms_dev')
    if APP_KEY:
        jsms_client = jsms.Jsms(APP_KEY, MASTER_SECRET)
        
        return jsms_client.dev_balance()
    else:
        return None

def twilio_num():
    APP_KEY, MASTER_SECRET, SENDER = get_conf('twilio')

    if APP_KEY:
        url = 'https://api.twilio.com/2010-04-01/Accounts/' + APP_KEY + '/Balance.json'
        
        jsms_client = requests.get(url, 
            auth = (APP_KEY, MASTER_SECRET)
        )
        if str(jsms_client.status_code).startswith('2'):
            return json.loads(jsms_client.text)
    return None