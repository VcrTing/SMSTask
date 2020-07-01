from rest_framework import serializers
from Appis.User import models
from Appis.Sms.models import Area
from Appis.Sms.serializers import AreaSerializer

# Serializer

"""
class TagSerializer(serializers.ModelSerializer):
    ""
        标签
    ""
    class Meta:
        model = models.Tag
        depth = 1
        fields = '__all__'
"""

class ContactSerializer(serializers.ModelSerializer):
    """
        电话薄
    """
    area_id = serializers.IntegerField(required = False)

    class Meta:
        model = models.Contact
        depth = 1
        fields = ['id', 'first_named', 'phoned', 'bith', 'area_id', 'area', 'gender', 'email', 'status', 'add_time', 'star']

    def create(self, data):
        super().create(data)
        area_id = data.pop('area_id')
        contact = models.Contact.objects.create(**data)
        contact.area = Area.objects.get(id = area_id)
        contact.save()
        return contact
 
    def update(self, instance, validated_data):
        super().update(instance, validated_data)
        area_id = validated_data.get('area_id', None)
        if area_id != None:
            instance.area = Area.objects.get(id = area_id)
            instance.save()
        return instance
