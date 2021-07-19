
from .. import doing as doing
from ..func import connect as conn
from .note import _do_runtask
from .email import _do_runemail

def _running_sms():
    every_task_list = doing.get_running_task()

    if every_task_list:
        for every_task in every_task_list:
            _do_runtask(every_task)
        return True
    else:
        return False

def _running_email():
    every_task_list = doing.get_running_email()
    if every_task_list:
        for every_task in every_task_list:
            _do_runemail(every_task['id'])
        return True
    return False

# 定时执行的 任务
def _running_task():
    sms = _running_sms()
    email = _running_email()