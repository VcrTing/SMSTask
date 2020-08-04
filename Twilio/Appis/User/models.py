import uuid
from django.db import models
from django.utils import timezone
from django.contrib.auth import get_user_model

from django.contrib.auth.models import AbstractUser, User

from .. import common
from Appis.Sms.models import Service, SmsTemplate, Area

# Create your models here.
class UserProfile(AbstractUser):
    # 员工
    nickName = models.CharField(max_length=20, null=True, blank=True, verbose_name='员工真实姓名')
    bith = models.DateField(null=True, blank=True, verbose_name='出生年月')
    phone = models.CharField(max_length=11, null=True, blank=True, verbose_name='电话')
    email = models.EmailField(max_length=100, null=True, blank=True, verbose_name='邮箱')
    gender = models.CharField(max_length=6, choices=(('male', u'男'), ('female', u'女')), default='male', verbose_name='性别')
    is_staff = models.BooleanField(default=True, verbose_name='职员状态', help_text='指明用户是否可以登录到这个管理站点。')
    is_superuser = models.BooleanField(default=False, verbose_name='是否超级用户', help_text='无视权限认证，一键拥有超级权限。')
    password = models.CharField(max_length=240, verbose_name='登录密码')

    status = models.BooleanField(verbose_name='账号是否可用', default=True)
    add_time = models.DateTimeField(verbose_name='创建时间', default=timezone.now)

    class Meta:
        verbose_name = "员工"
        verbose_name_plural = verbose_name

    def __str__(self):
        if self.email:
            return self.email
        else:
            return '-空白-'

class Tag(models.Model):
    named = models.CharField(max_length=20, null=True, blank=True, unique=True, verbose_name='标签名称')

    add_time = models.DateTimeField(verbose_name='创建时间', default=timezone.now)

    class Meta:
        verbose_name = "标签"
        verbose_name_plural = verbose_name

    def __str__(self):
        if self.named:
            return self.named
        else:
            return '-空白-'

class Contact(models.Model):
    # 电话薄
    first_named = models.CharField(max_length=40, null=True, blank=True, verbose_name='姓氏')
    last_named = models.CharField(max_length=40, null=True, blank=True, verbose_name='名字')
    bith = models.DateField(null=True, blank=True, verbose_name='出生年月')

    star = models.BooleanField(default=False, verbose_name='是否为星标联系人')
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, verbose_name='手机号码前缀')
    tag = models.ManyToManyField(to = Tag, related_name='tag', blank=True, verbose_name='标签')

    phoned = models.CharField(max_length=11, null=True, blank=True, default='', verbose_name='电话')
    email = models.EmailField(max_length=100, null=True, blank=True, default='', verbose_name='邮箱')
    gender = models.SmallIntegerField(choices=((1, u'男'), (2, u'女'), (0, u'未知')), default=0, verbose_name='性别')
 
    status = models.BooleanField(verbose_name='联系人是否可用', default=True)
    add_time = models.DateTimeField(verbose_name='创建时间', default=timezone.now)

    class Meta:
        verbose_name = "联系人"
        verbose_name_plural = verbose_name

    def __str__(self):
        if self.first_named:
            return self.first_named
        else:
            return '-空白-'
