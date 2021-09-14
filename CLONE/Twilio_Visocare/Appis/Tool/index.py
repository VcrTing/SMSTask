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
    print('任务运行====>')
    i = datetime.datetime.now()
    
    if int(i.hour) in conf.WORK_HOUR:
        _running_task()
    
    # 备份
    if int(i.hour) in [11, 12, 14, 15, 16, 17]:
        try:
            print('执行删除:')
            trash()
            print('即将备份:')
            backup()
            lockit('backuping', False)
        except Exception as e:
            pass

# 运行中的任务
def running_taskers():
    _get_incentive_tasker()
    
    _running_status()
