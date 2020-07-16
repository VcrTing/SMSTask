from django.utils import timezone
from django.db import models
from multiselectfield import MultiSelectField

from .. import common

from Appis.Sms.models import Service, SmsTemplate, Area
from Appis.User.models import Contact

# Create your models here.

class SmsTask(models.Model):
    sms_template = models.ForeignKey(SmsTemplate, on_delete=models.CASCADE, verbose_name='短信模版')
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, verbose_name='手机号码前缀')
    
    phoned = models.CharField(max_length=60, null=True, verbose_name='手机号')
    named = models.CharField(max_length=120, null=True, verbose_name='顾客名字')

    task_status = models.NullBooleanField(default=False, verbose_name='任务申请状态')
    end_time = models.DateTimeField(verbose_name='任务结束时间', null=True, blank=True)

    status = models.BooleanField(default=True, verbose_name='数据状态')
    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)

    class Meta:
        verbose_name = "任務申请"
        verbose_name_plural = verbose_name

    def __str__(self):
        return '接收者：' + str(self.named) + '，电话：' + str(self.phoned)

class EveryTask(models.Model):
    contact = models.ForeignKey(Contact, verbose_name='所属用户', on_delete=models.CASCADE, null=True)
    sms_task = models.ForeignKey(SmsTask, on_delete=models.CASCADE, verbose_name='所属任务申请表', null=True)
    time_rule_belong = models.SmallIntegerField(choices=common.TIME_RULE, default=0, verbose_name='所属时间规则')
    numed = models.SmallIntegerField(default=1, null=True, blank=True, verbose_name='所属索引值')
    
    send_finish_time = models.DateTimeField(verbose_name='預計發送時間', null=True, blank=True)
    schedule_id = models.CharField(max_length=90, default='0', verbose_name='极光短信任务ID 字段')
    
    apply_status = models.NullBooleanField(default=None, verbose_name='应用标识')
    send_status = models.BooleanField(default=False, verbose_name='短信是否已发送')

    temp_para = models.TextField(max_length=600, default=common.NULL, null=True, blank=True, verbose_name='模版参数')
    jsms_response = models.TextField(max_length=1000, null=True, blank=True, verbose_name='极光 Response 返回解析结果储存')

    status = models.BooleanField(default=True, verbose_name='数据状态')
    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)

    class Meta:
        verbose_name = "极光任務队列"
        verbose_name_plural = verbose_name
        ordering = ('-add_time',)

    def __str__(self):
        return '所属时间规则：' + str(self.time_rule_belong) + ' schedule_id：' + str(self.schedule_id)

class SmsTaskRecord(models.Model):
    title = models.CharField(max_length=120, verbose_name='任務名稱')
    phoned = models.TextField(max_length=2000, null=True, verbose_name='手机号')
    sms_template = models.CharField(max_length=240, verbose_name='短信內容')
    send_time = models.DateTimeField(verbose_name='發送時間')

    # 暗藏字段
    every_task = models.ForeignKey(EveryTask, on_delete=models.CASCADE, verbose_name='极光任务队列表', null=True)

    status = models.BooleanField(default=True, verbose_name='数据状态')
    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)

    class Meta:
        verbose_name = "短信发送完成记录"
        verbose_name_plural = verbose_name

    def __str__(self):
        return '名称：' + str(self.title) + '，时间：' + str(self.add_time)