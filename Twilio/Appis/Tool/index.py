import datetime
from . import config as conf

from .working.email import _serial_email
from .working.note import _serial_task

from Appis.Tool.func.backup import media
from .working.running import _running_task
    

# 短信任务
def serial_task(every_task_ids):
    _serial_task(every_task_ids)

# 电邮任务
def serial_email(task_ids):
    _serial_email(task_ids)

# 执行 运行中 的任务
def running_task():
    _running_task()
    media('download')
    i = datetime.datetime.now()
    
    if int(i.hour) in conf.WORK_HOUR:
        _running_task()
    
    if int(i.day) in [1, 15]:
        media('download')
        