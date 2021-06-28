import platform

from conf import LAYOUT, COMPANY_NAME, EMAIL_NAME, DATA_BASE, HOST, DOMAIN, WORK_HOUR

print(platform.system())
 
_TEST = True
if (platform.system() == 'Linux'):
  _TEST = False

TEST = _TEST

SYS_MAIL = 'support@manfulls.com'

Now = '123medhk' # 该值是指当前 公司的 key_name

SETTING = {
    '123medhk': {
        'key_name': '123medhk', # 不用改
        'media': '123Medhk', # 媒体库文件夹，不用改
        'host': HOST,
        'time_zone': 'Asia/Shanghai', # 时区

        'admin_name': 'SMS任务管理', # 后台名字
        'company_name': COMPANY_NAME, # 公司名称
        'email_name': EMAIL_NAME, # 邮箱地址非中文称呼

        'database': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': DATA_BASE,
            'HOST': DOMAIN,
            'PORT': 3306,
            'USER': 'root',
            'PASSWORD': 'VcrTing.ZT123zlt',
            'CONN_MAX_AGE': 2000
        },
        'layout': LAYOUT, # 功能设定，0 为关闭，1 为打开

        'qiong': 8, # 加密数值，每更换一次数值，网站配置必须更新，谨慎修改
        'wait_minute': 1, # 等待时间，任务申请几分钟后生效
        'work_hour': WORK_HOUR # 定时任务的准点工作时间
    }
}

# 千人任务分割
EVERY = 20