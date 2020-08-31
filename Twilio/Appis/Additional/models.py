from django.utils import timezone
from django.db import models
from multiselectfield import MultiSelectField

from .. import common
from Appis.Sms import models as models_sms
from Appis.User import models as models_user
# Create your models here.

class EmailTemplate(models.Model):
    subject = models.CharField(max_length=120, null=True, verbose_name='邮件Subject')
    message = models.TextField(max_length=7200, default=common.NULL, null=True, blank=True, verbose_name='邮件内容')
    
    time_rule = models.SmallIntegerField(choices=common.TIME_RULE_EMAIL, default=0, verbose_name='所属时间规则')
    
    service = models.CharField(max_length=120, null=True, verbose_name='服务名称')
    category = models.ForeignKey(models_sms.Category, verbose_name='服务分类', on_delete=models.CASCADE, null=True)
    
    status = models.BooleanField(verbose_name='数据状态', default = True)
    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)
    class Meta:
        verbose_name = "邮件模版"
        verbose_name_plural = verbose_name

    def __str__(self):
        return '邮件模版: ' + self.message[0: 20] + '...'

class EmailApply(models.Model):
    contact = models.ForeignKey(models_user.Contact, verbose_name='所属用户', on_delete=models.CASCADE, null=True)

    visit_time = models.DateField(verbose_name='光顾時間', default=timezone.now)

    email_template = models.ForeignKey(EmailTemplate, verbose_name='所属模版', on_delete=models.CASCADE, null=True)

    apply_status = models.BooleanField(verbose_name='生效状态', default = False)
    send_status = models.BooleanField(verbose_name='是否允许发送', default = True)
    over_status = models.BooleanField(verbose_name='是否完结', default = False)

    first_status = models.BooleanField(verbose_name='启用首封？', default = True)
    nper = models.IntegerField(choices=common.NPER, verbose_name='期数', default = 0)
    now_time_rule = models.IntegerField(choices=common.TIME_RULE, verbose_name='时间规则', default = 0)

    now_index = models.IntegerField(verbose_name='当前已工作了几期', default = 0)
    next_time = models.DateTimeField(verbose_name='下次发邮件的時間', default=timezone.now)

    status = models.BooleanField(verbose_name='数据状态', default = True)
    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)

    class Meta:
        verbose_name = "邮件任务申请列表"
        verbose_name_plural = verbose_name

    def __str__(self):
        return '邮件任务申请列表: ' + str(self.visit_time) + '...'

class EmailCollect(models.Model):
    email_apply = models.ForeignKey(EmailApply, verbose_name='服务申请表', on_delete=models.CASCADE, null=True)
    email_template = models.ForeignKey(EmailTemplate, verbose_name='任务模版', on_delete=models.CASCADE, null=True)
    success_status = models.BooleanField(verbose_name='是否发送成功', default = False)

    json_response = models.TextField(max_length=400, default=common.NULL, null=True, blank=True, verbose_name='回应的Response')
    
    send_time = models.DateTimeField(verbose_name='发送時間', default=timezone.now)
    index = models.IntegerField(verbose_name='第几期', default = 1)
    
    status = models.BooleanField(verbose_name='数据状态', default = True)
    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)

    class Meta:
        verbose_name = "单期邮件记录"
        verbose_name_plural = verbose_name

    def __str__(self):
        return '单期邮件记录'