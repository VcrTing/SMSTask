import requests
import json

class ConnectError(Exception):
    def __init__(self, err):
        super().__init__(self)
        self.error_info = err
    def __str__(self):
        return '【连接错误】' + str(self.error_info)

def _res(res):
    if str(res.status_code).startswith('2'):
        res = json.loads(res.text)
    else: 
        res = None
    return res

# GET
def req_Get(url):
    try:
        res = requests.get(url)
        return _res(res)
    except:
        ConnectError('Requests GET请求错误！！！')

# POST
def req_Post(url, data, headers=None):
    try:
        res = requests.post(url, data, headers)
        return _res(res)
    except:
        ConnectError('Requests POST请求错误！！！')

# UPDATE
def req_Update(url, data):
    try:
        res = requests.put(url, data)
        return _res(res)
    except:
        ConnectError('Requests PUT请求错误！！！')
