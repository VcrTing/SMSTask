import datetime
from . import config as conf

from .working.email import _serial_email
from .working.note import _serial_task

from Appis.Tool.backup.index import backup, lockit, trash()
from .working.running import _running_task

# 短信任务
def serial_task(every_task_ids):
    _serial_task(every_task_ids)

# 电邮任务
def serial_email(task_ids):
    _serial_email(task_ids)

# 执行 运行中 的任务
def running_task():
    
    i = datetime.datetime.now()
    
    # 运行 邮件任务
    if int(i.hour) in conf.WORK_HOUR:
        _running_task()
    
    # 备份
    if int(i.day) in [1, 8, 15, 22]:
        backup()
    if int(i.day) in [2, 9, 16, 23]:
        lockit('backuping', False)
        trash()

        