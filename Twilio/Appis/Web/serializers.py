from rest_framework import serializers
from Appis.Web import models

# Serializer
class SMSConfSerializer(serializers.ModelSerializer):
    """
        Twilio Conf
    """
    class Meta:
        model = models.SMSConf
        fields = '__all__'

class SystemMsgSerializer(serializers.ModelSerializer):
    """
        SYSTEM MESSAGE
    """
    class Meta:
        model = models.SystemMsg
        fields = '__all__'

class ImgSerializer(serializers.ModelSerializer):
    """
        SYSTEM IMG
    """
    class Meta:
        model = models.Img
        fields = '__all__'