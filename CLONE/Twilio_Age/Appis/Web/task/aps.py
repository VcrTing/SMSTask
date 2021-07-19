
from django_apscheduler.jobstores import DjangoJobStore

django_jobstore = DjangoJobStore()

# 初始化scheduler时，可以直接指定jobstore和executor

init_scheduler_options = {
    "jobstores": {
        "default": django_jobstore
    },
    "job_defaults": {
        'coalesce': False,
        'max_instances': 1
    }
}