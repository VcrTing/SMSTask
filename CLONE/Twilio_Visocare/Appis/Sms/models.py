from django.utils import timezone
from django.db import models
from multiselectfield import MultiSelectField

from .. import common
# Create your models here.

class Area(models.Model):
    phoned_prefix = models.CharField(max_length=30, null=True, verbose_name='手机号码前缀')
    named = models.CharField(max_length=60, null=True, blank=True, verbose_name='地域名称')
    
    status = models.BooleanField(default=True, verbose_name='数据状态')
    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)

    class Meta:
        verbose_name = "地域与电话号码前缀"
        verbose_name_plural = verbose_name

    def __str__(self):
        return '地域名称：' + str(self.named) + '前缀：' + str(self.phoned_prefix)


class Category(models.Model):
    named = models.CharField(max_length=30, default=common.UNKNOW, verbose_name='分类展示名字', null=True)
    flag = models.SmallIntegerField(choices=common.CATEGORY, default=1, verbose_name='分类', null=True)
    way = models.SmallIntegerField(choices=common.WAY, default=1, verbose_name='定位', null=True)
    
    status = models.BooleanField(verbose_name='数据状态', default = True)
    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)

    class Meta:
        verbose_name = "服务分类"
        verbose_name_plural = verbose_name

    def __str__(self):
        return str(self.named)

class Service(models.Model):
    
    named = models.CharField(max_length=60, default=common.UNKNOW, verbose_name='服务名')
    time_rule = MultiSelectField('时间规律', choices=common.TIME_RULE, null=True, blank=True)

    status = models.BooleanField(verbose_name='数据状态', default = True)
    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)
    class Meta:
        verbose_name = "服务项目"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.named

class SmsTemplate(models.Model):
    sms_id = models.CharField(max_length=90, verbose_name='模版id')
    sms_id_sub = models.CharField(max_length=90, verbose_name='后手模版id', default='001')
    
    content = models.TextField(max_length=2000, verbose_name='先手短信模版', help_text="短信内容可有参，{{phone}}表示短信接收者的电话号码")
    content_sub = models.TextField(max_length=1600, verbose_name='后手短信模版', default=common.UNKNOW, help_text="同上")
    
    lang = models.SmallIntegerField(choices=common.LANG, default=1, verbose_name='语言', null=True)

    service = models.ForeignKey(Service, verbose_name='所属服务', on_delete=models.CASCADE, null=True)
    category = models.ForeignKey(Category, verbose_name='服务分类', on_delete=models.CASCADE, null=True)
    
    status = models.BooleanField(verbose_name='数据状态', default = True)
    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)
    class Meta:
        verbose_name = "短信模版"
        verbose_name_plural = verbose_name

    def __str__(self):
        return 'ID: ' + self.sms_id + ', 模版: ' + self.content[0: 20] + '...'