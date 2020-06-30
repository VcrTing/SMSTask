
from django_apscheduler.jobstores import DjangoJobStore

django_jobstore = DjangoJobStore()

# 初始化scheduler时，可以直接指定jobstore和executor
init_scheduler_options = {
    "jobstores": {
        # first 为 jobstore的名字，在创建Job时直接直接此名字即可
        "default": django_jobstore
    },
    """
    "executors": {
        # first 为 executor 的名字，在创建Job时直接直接此名字，执行时则会使用此executor执行
        "first": first_executor
    },
    """
    # 创建job时的默认参数
    "job_defaults": {
        'coalesce': False,  # 是否合并执行
        'max_instances': 1  # 最大实例数
    }
}