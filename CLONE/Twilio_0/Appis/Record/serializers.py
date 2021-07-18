from rest_framework import serializers
from Appis.Record import models

# Serializer
class SmsTaskSerializer(serializers.ModelSerializer):
    """
        短信信息
    """
    class Meta:
        model = models.SmsTask
        depth = 3
        fields = '__all__'

class EveryTaskSerializer(serializers.ModelSerializer):
    """
        任务队列
    """
	
    class Meta:
        model = models.EveryTask
        depth = 3
        fields = '__all__'

class SmsTaskRecordSerializer(serializers.ModelSerializer):
    """
        SMS任务记录
    """
    class Meta:
        model = models.SmsTaskRecord
        fields = '__all__'