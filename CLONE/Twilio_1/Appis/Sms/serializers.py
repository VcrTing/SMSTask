from rest_framework import serializers
from Appis.Sms import models

# Serializer
class ServiceSerializer(serializers.ModelSerializer):
    """
        服务项
    """
    class Meta:
        model = models.Service
        fields = '__all__'

class CategorySerializer(serializers.ModelSerializer):
    """
        分类
    """
    class Meta:
        model = models.Category
        fields = '__all__'

class SmsTemplateSerializer(serializers.ModelSerializer):
    """
        短信模版
    """
    class Meta:
        model = models.SmsTemplate
        depth = 1
        fields = '__all__'
        
class AreaSerializer(serializers.ModelSerializer):
    """
        地域与电话号码前缀
    """
    class Meta:
        model = models.Area
        fields = '__all__'
        # exclude = ('is_active')