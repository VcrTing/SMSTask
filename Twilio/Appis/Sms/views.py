from django import views
from django.shortcuts import render, redirect
from django.views.generic.base import View

from rest_framework import filters, pagination
from rest_framework import mixins, viewsets, views, status, generics
from rest_framework.response import Response
from django_filters.rest_framework.backends import DjangoFilterBackend

from Appis.Sms import models
from Appis.Sms import serializers

# Create your views here.

class CategoryViewSet(viewsets.ModelViewSet):
    """
        分类
    """
    queryset = models.Category.objects.all()
    serializer_class = serializers.CategorySerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('status', 'typed')
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination

class SmsTemplateViewSet(viewsets.ModelViewSet):
    """
        短信模版
    """
    queryset = models.SmsTemplate.objects.all()
    serializer_class = serializers.SmsTemplateSerializer
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination

class ServiceViewSet(viewsets.ModelViewSet):
    """
        服务项
    """
    queryset = models.Service.objects.all()
    serializer_class = serializers.ServiceSerializer
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination

class AreaViewSet(viewsets.ModelViewSet):
    """
        地域与电话号码前缀
    """
    queryset = models.Area.objects.all()
    serializer_class = serializers.AreaSerializer
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination
    

# ============================================= V ===============================================

class ServiceView(View):
    page_flag = 'service'
    def get(self, request):
        option = request.GET.get('option', None)

        if option:
            id = request.GET.get('id', None)
            if option == 'trash':
                service = models.Service.objects.get(id =id)
                service.status = False
                service.save()

        service_list = models.Service.objects.filter(status = True)
        return render(request, 'sms/service.html', 
            { 
                'title': '首页', 
                'page_flag': self.page_flag,
                'service_list': service_list
            }
        )
    
    def post(self, request):
        option = request.GET.get('option', None)

        named = request.POST.get('named', None)

        if option:
            id = request.GET.get('id', None)
            service = models.Service.objects.get(id =id)
            if option == 'update':
                time_rule = request.POST.getlist('time_rule', None)
                service.named = named
                service.time_rule = time_rule
                service.save()

        return redirect('/sms/')
