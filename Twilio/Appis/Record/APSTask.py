from multiprocessing import Process

import Twilio.settings as settings
from django.db import connection 
import Appis.common as common
import time

from Appis.Tool import index as worker
# Create your views here.

WAIT_MINUTES = settings.WAIT_MINUTES

def tick(id, way):
    connection.close()
    if way == common.WAY[0][0]:
        worker.serial_task(id)
    if way == common.WAY[1][0]:
        worker.serial_email(id)
        
    time.sleep(10)
    worker.running_task()

class TaskProcess(Process):
    task_id = 0
    way = common.WAY[0][0]
    def __init__(self, task_id, way):
        super().__init__()
        self.task_id = task_id
        self.way = way

    def run(self):
        time.sleep(60*WAIT_MINUTES)
        tick(self.task_id, self.way)
