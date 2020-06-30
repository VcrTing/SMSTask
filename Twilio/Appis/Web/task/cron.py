
"""
def check_and_run():
    import requests
    from Twilio.setting import HOST
    res = requests.get(HOST + '/task_running/')
"""

def check_and_run():

    from Appis.Tool.working.running import _running_task
    _running_task()
    