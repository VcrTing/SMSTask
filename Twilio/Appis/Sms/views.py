from django import views
from django.shortcuts import render, redirect
from django.views.generic.base import View
from django.forms.models import model_to_dict
from django.db.models import Q
from django.http import HttpResponsePermanentRedirect, HttpResponse, JsonResponse

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
    filter_fields = ('status', )
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination

class SmsTemplateViewSet(viewsets.ModelViewSet):
    """
        短信模版
    """
    queryset = models.SmsTemplate.objects.all()
    serializer_class = serializers.SmsTemplateSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('service', )
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
            pk = request.GET.get('id', None)
            if option == 'trash':
                service = models.Service.objects.get(id =pk)
                service.status = False
                service.save()

            if option == 'add':
                category = models.Category.objects.filter(way = 1)
                return render(request, 'sms/service_add.html', 
                    { 
                        'title': '服務項目新增', 
                        'page_flag': self.page_flag,
                        'page_flag_sub': self.page_flag + '_add',
                        'category': category,
                        'named': "{{named}}",
                        'numed': "{{numed}}"
                    }
                )
            
            if option == 'update':
                service = models.Service.objects.get(id =pk)
                category = models.Category.objects.filter(way = 1)
                smsT = models.SmsTemplate.objects.filter(Q(service = service.id) & Q(lang = 1))
                smsT_en = models.SmsTemplate.objects.filter(Q(service = service.id) & Q(lang = 2))

                return render(request, 'sms/service_update.html', 
                    { 
                        'title': '服務項目修改', 
                        'page_flag': self.page_flag,
                        'page_flag_sub': self.page_flag + '_update',
                        'category': category,
                        'named': "{{named}}",
                        'numed': "{{numed}}",
                        'service': service,
                        'sms_template': smsT,
                        'sms_template_en': smsT_en
                    }
                )
                
            if option == 'view':
                service = models.Service.objects.get(id =pk)
                smsT = models.SmsTemplate.objects.filter(Q(service = service.id) & Q(lang = 1))
                smsT_en = models.SmsTemplate.objects.filter(Q(service = service.id) & Q(lang = 2))

                return JsonResponse({
                    'res': True,
                    'service': model_to_dict(service),
                    # 'category': model_to_dict(smsT.category),
                    'sms_template': model_to_dict(smsT),
                    'sms_template_en': model_to_dict(smsT_en)
                })

        service_list = models.Service.objects.filter(status = True).order_by('-add_time')
        
        return render(request, 'sms/service.html', 
            { 
                'title': '首页', 
                'page_flag': self.page_flag,
                'service_list': service_list
            }
        )
    
    def post(self, request):
        res = {
            'status': True
        }
        option = request.GET.get('option', None)
        named = request.POST.get('named', None)
        pk = request.GET.get('id', None)

        if option:
            if option == 'update':

                service = models.Service.objects.get(id =pk)
                time_rule = request.POST.getlist('time_rule', None)
                service.named = named
                service.time_rule = time_rule
                service.save()

            if option == 'add':
                try :
                    cate = request.POST.get('cate', None)
                    cate = models.Category.objects.get(id = cate)

                    time_rule = request.POST.get('time_rule', None)
                    content = request.POST.get('content', None)
                    content_sub = request.POST.get('content_sub', None)
                    content_en = request.POST.get('content_en', None)
                    content_sub_en = request.POST.get('content_sub_en', None)

                    time_rule = [int(i) for i in time_rule.split(',') if i is not '']

                    serive = models.Service()
                    serive.time_rule = time_rule
                    serive.named = named
                    serive.save()

                    smsT = models.SmsTemplate()
                    smsT.service = serive
                    smsT.sms_id = '00'
                    smsT.sms_id_sub = '00'
                    smsT.content = content
                    smsT.content_sub = content_sub
                    smsT.lang = 1
                    smsT.category = cate
                    smsT.save()

                    smsT_en = models.SmsTemplate()
                    smsT_en.service = serive
                    smsT_en.sms_id = '00'
                    smsT_en.sms_id_sub = '00'
                    smsT_en.content = content_en
                    smsT_en.content_sub = content_sub_en
                    smsT_en.lang = 2
                    smsT_en.category = cate
                    smsT_en.save()
                except err:
                    res['status'] = False

            if option == 'trash':

                service = models.Service.objects.get(id =pk)

                smsT = models.SmsTemplate.objects.filter(service = service)
                for s in smsT:
                    s.status = False
                    s.save()

                service.status = False
                service.save()

        return JsonResponse(res)
                
