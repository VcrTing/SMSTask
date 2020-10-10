
TEST = True

SYS_MAIL = 'support@manfulls.com'

Now = '123medhk' # 该值是指当前 公司的 key_name

SETTING = {
    'eye': {
        'key_name': 'eye', # 不用改
        'media': 'Eye', # 媒体库文件夹，不用改
        'host': 'http://crm.up5d.com:7000',
        'time_zone': 'Asia/Shanghai', # 时区

        'admin_name': 'SMS任务管理', # 后台名字
        'company_name': '眼镜中心', # 公司名称
        'email_name': 'eye', # 邮箱地址非中文称呼

        'database': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': 'tsms',
            'HOST': 'crm99.svr.up5d.com',
            'PORT': 3306,
            'USER': 'root',
            'PASSWORD': 'VcrTing.ZT123zlt',
            'CONN_MAX_AGE': 9
        },
        'layout': {
            'sms': 0,
            'email': 1
        }, # 功能设定，0 为关闭，1 为打开

        'qiong': 8, # 加密数值，每更换一次数值，网站配置必须更新，谨慎修改
        'wait_minute': 2, # 等待时间，任务申请几分钟后生效
        'work_hour': [11, 20] # 定时任务的准点工作时间
    },
    '123medhk': {
        'key_name': '123medhk', # 不用改
        'media': '123Medhk', # 媒体库文件夹，不用改
        'host': 'http://crm99.svr.up5d.com',
        'time_zone': 'Asia/Shanghai', # 时区

        'admin_name': 'SMS任务管理', # 后台名字
        'company_name': '123醫務中心', # 公司名称
        'email_name': '123Medhk', # 邮箱地址非中文称呼

        'database': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': 'tsms',
            'HOST': 'crm99.svr.up5d.com',
            'PORT': 3306,
            'USER': 'root',
            'PASSWORD': 'VcrTing.ZT123zlt',
            'CONN_MAX_AGE': 9
        },
        'layout': {
            'sms': 1,
            'email': 0
        }, # 功能设定，0 为关闭，1 为打开

        'qiong': 8, # 加密数值，每更换一次数值，网站配置必须更新，谨慎修改
        'wait_minute': 2, # 等待时间，任务申请几分钟后生效
        'work_hour': [11, 20, 21] # 定时任务的准点工作时间
    }
}