
def check_and_run():
    import requests
    from Twilio.setting import HOST
    
    res = requests.get(HOST + '/task_running/')
    
