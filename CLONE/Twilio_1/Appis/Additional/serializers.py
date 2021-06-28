from rest_framework import serializers
from . import models
from Appis.Sms import models as sms_models
# Serializer
class EmailTemplateSerializer(serializers.ModelSerializer):
    """
        邮件模版
    """
    class Meta:
        model = models.EmailTemplate
        depth = 3
        fields = ['id', 'subject', 'message', 'time_rule', 'service', 'category', 'status', 'add_time']

class EmailApplySerializer(serializers.ModelSerializer):
    """
        邮件任务申请列表
    """
    class Meta:
        model = models.EmailApply
        depth = 3
        fields = '__all__'

class EmailCollectSerializer(serializers.ModelSerializer):
    """
        单期邮件记录
    """
    class Meta:
        model = models.EmailCollect
        depth = 3
        fields = '__all__'