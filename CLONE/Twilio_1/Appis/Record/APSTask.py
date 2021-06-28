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
        
class TaskProcess(Process):
    task_id = 0
    way = common.WAY[0][0]
    one = True
    def __init__(self, task_id, way, one = True):
        super().__init__()
        self.task_id = task_id
        self.way = way
        self.one = one

    def run(self):
        if self.one:
            time.sleep(60*WAIT_MINUTES)

            tick(self.task_id, self.way)
        else:
            time.sleep(10)
            for ids in self.task_id:
                tick(ids, self.way)
                time.sleep(0.5)
