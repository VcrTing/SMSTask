from multiprocessing import Process
import time

from Appis.Tool import index as worker
from Twilio import settings as settings
# Create your views here.

WAIT_HOURS = settings.WAIT_HOURS


from django.db import connection 

def tick():
    connection.close()
    worker.running_task()

class TaskProcess(Process):
    name = ''
    def __init__(self, name):
        super().__init__()
        self.name = name

    def run(self):
        tick()
        # time.sleep(60*60*WAIT_HOURS)
