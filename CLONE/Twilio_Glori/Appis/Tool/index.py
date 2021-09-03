import datetime
from . import config as conf

from .working.email import _serial_email
from .working.note import _serial_task

from Appis.Tool.backup.index import backup, lockit, trash
from .working.running import _running_task
from .working.incentive import _get_incentive_tasker
from .working.status import _running_status

# 短信任务
def serial_task(every_task_ids):
    _serial_task(every_task_ids)

# 电邮任务
def serial_email(task_ids):
    _serial_email(task_ids)

# 执行 运行中 的任务
def running_task():
    
    i = datetime.datetime.now()
    
    if int(i.hour) in conf.WORK_HOUR:
        _running_task()
    
    # 备份
    if int(i.hour) in [11, 12, 14, 15, 16, 17]:
        print('即将备份:')
        backup()
    if int(i.hour) in [ 14, 15, 16, 17]:
        print('执行删除:')
        trash()
        lockit('backuping', False)

# 运行中的任务
def running_taskers():
    _get_incentive_tasker()
    
    _running_status()
