from django.utils import timezone
from django.db import models

from .. import common
import uuid, os
from Twilio import settings
# Create your models here.

class SMSConf(models.Model):
    flag = models.CharField(max_length=30, default='twilio', verbose_name='厂家标示')
    sid = models.CharField(max_length=200, default=common.UNKNOW, verbose_name='账户 sid')
    token = models.CharField(max_length=200, default=common.UNKNOW, verbose_name='账户 认证token')
    sender = models.CharField(max_length=120, default=common.UNKNOW, verbose_name='发送者号码')

    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)
    
    class Meta:
        verbose_name = "SMS配置"
        verbose_name_plural = verbose_name

    def __str__(self):
        return '配置' + str(self.id)

class SystemMsg(models.Model):
    subject = models.CharField(max_length=120, null=True, verbose_name='邮件Subject')
    message = models.TextField(max_length=600, default=common.NULL, null=True, blank=True, verbose_name='邮件内容')

    typed = models.SmallIntegerField(choices=common.SYSTEMMSGTYPED, default=1, verbose_name='消息类型', null=True)
    way = models.SmallIntegerField(choices=common.WAY, default=2, verbose_name='发送消息的方式', null=True)

    success_status = models.BooleanField(verbose_name='是否发送成功', default = True)
    
    status = models.BooleanField(verbose_name='数据状态', default = True)
    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)
    class Meta:
        verbose_name = "系统消息"
        verbose_name_plural = verbose_name

    def __str__(self):
        return '系统消息: ' + self.subject

def _img(instance, filename):
    filename = 'HSIZE_' + uuid.uuid4().hex + os.path.splitext(filename)[-1]
    return os.path.join('img', filename)
def _img_tiny(instance, filename):
    filename = 'TINY_' + uuid.uuid4().hex + os.path.splitext(filename)[-1]
    return os.path.join('img_tiny', filename)

class Img(models.Model):
    img = models.ImageField(upload_to=_img, null=True, verbose_name='图片')
    img_tiny = models.ImageField(upload_to=_img_tiny, null=True, verbose_name='缩略图片')

    w = models.CharField(max_length=60, null=True, verbose_name='宽')
    h = models.CharField(max_length=60, null=True, verbose_name='高')

    add_time = models.DateTimeField(verbose_name='創建時間', default=timezone.now)

    class Meta:
        verbose_name = "图片"
        verbose_name_plural = verbose_name

    def __str__(self):
        return '图片: ' + str(self.img)
        
    def delete(self):
        os.remove(
            os.path.join(settings.MEDIA_ROOT, 'img', self.img.path)
        )
        try:
            os.remove(
                os.path.join(settings.MEDIA_ROOT, 'img_tiny', self.img_tiny.path)
            )
        except:
            pass
        return super(Img, self).delete()