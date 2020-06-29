import os
from .company import Now, SETTING, TEST

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'Twilio.settings.dev')

SECRET_KEY = 'g(q4o8mh+ov2ovk4ua1-b(fl1lke+ppl!5vdqqkp_2$@_o*izi'

DEBUG = True

ALLOWED_HOSTS = ['*']

APPEND_SLASH = True


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
MINE_APPS = [
    'gunicorn',
    'django_crontab', # django-crontab
    'django_filters', # django-filter
    'rest_framework', # djangorestframework
    'corsheaders', # django-cors-headers
    # 'ckeditor',
    # 'ckeditor_uploader'
    'multiselectfield', # django-multiselectfield

    'Appis.Sms',
    'Appis.Web',
    'Appis.User',
    'Appis.Record',
    'Appis.Additional',
    # 'Twilio'
]
INSTALLED_APPS += MINE_APPS

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
]
#  'django.middleware.csrf.CsrfViewMiddleware',

ROOT_URLCONF = 'Twilio.urls'

AUTH_USER_MODEL = 'User.UserProfile'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(BASE_DIR, 'Template'),
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.media',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'Twilio.wsgi.application'


# Database
if TEST:
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': os.path.join(BASE_DIR, 'db.sqlite3')
        }
    }
else:
    DATABASES = {
        'default': SETTING[Now]['database']
    }

# Session

SESSION_ENGINE = 'django.contrib.sessions.backends.db' 
SESSION_COOKIE_AGE = 1209600

# Password validation

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization

LANGUAGE_CODE = 'zh-hans'

TIME_ZONE = SETTING[Now]['time_zone']

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)

STATIC_URL = '/static/'

STATIC_DIR = 'Static'

# STATIC_ROOT = os.path.join(BASE_DIR, STATIC_DIR)

STATICFILES_DIRS = (
    os.path.join(BASE_DIR, STATIC_DIR),
)

MEDIA_URL = '/media/'

MEDIA_ROOT = os.path.join(BASE_DIR, 'Media')

# User =======================================

# Rest Framework

REST_FRAMEWORK = {
    'UNICODE_JSON': False,
    'DEFAULT_SCHEMA_CLASS': 'rest_framework.schemas.coreapi.AutoSchema'
}

# Admin
ADMIN_CONF = {
    'admin_title': SETTING[Now]['admin_name'],
    'admin_header': SETTING[Now]['admin_name'],
    'empty_value_display': '_Unknow_'
}

# Cors Header 跨域

CORS_ALLOW_CREDENTIALS = True
CORS_ORIGIN_ALLOW_ALL = True
CORS_ORIGIN_WHITELIST = ()
 
CORS_ALLOW_METHODS = (
    'DELETE',
    'GET',
    'OPTIONS',
    'PATCH',
    'POST',
    'PUT',
    'VIEW',
)
 
CORS_ALLOW_HEADERS = (
    'accept',
    'accept-encoding',
    'authorization',
    'content-type',
    'dnt',
    'origin',
    'user-agent',
    'x-csrftoken',
    'x-requested-with',
)

# Cron 定时任务
CRONJOBS = [
    ('* */1 * * *', 'Appis.Web.cron.check_and_run')
]

# MEDIA
COMP = 2*1024 # 2 mb

# SCRET 
COMPANY = SETTING[Now]['company_name']
EMAIL_NAME = SETTING[Now]['email_name']
KEY_NAME = SETTING[Now]['key_name']

QIONG = SETTING[Now]['qiong']

# 平台定义

EACH_DAY = 30 # 医学每隔30天就算一个月

DAY_OFFSET = 1 # 这个用来计算预约时间的

WAIT_MINUTES = SETTING[Now]['wait_minute'] # 任务序列化后有多少分钟可供更改

WAIT_HOURS = 12 # Runing 任务每隔多久 执行一次 (单位：小时)

WORK_HOUR = SETTING[Now]['work_hour']

SIGN_ID = 12646

if TEST:
    HOST = 'http://127.0.0.1:8000'
else:
    HOST = SETTING[Now]['host']

HOST_API = HOST + '/api'

KEY_DIR = os.path.join(BASE_DIR, 'Media', 'key')