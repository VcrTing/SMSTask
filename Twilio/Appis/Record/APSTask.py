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
    waiting = True
    def __init__(self, task_id, way, waiting = True):
        super().__init__()
        self.task_id = task_id
        self.way = way
        self.waiting = waiting

    def run(self):
        if self.waiting:
            time.sleep(60*WAIT_MINUTES)
        else:
            time.sleep(0.5)
        tick(self.task_id, self.way)
