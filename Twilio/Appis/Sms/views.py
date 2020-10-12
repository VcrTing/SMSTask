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

from Appis.Tool.func import danger

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

                cate = None
                time_rule = list(service.time_rule)
                if smsT:
                    cate = [ s.category for s in smsT ][0]
                if smsT_en:
                    cate = [ s.category for s in smsT_en ][0]

                return render(request, 'sms/service_update.html', 
                    { 
                        'title': '服務項目修改', 
                        'page_flag': self.page_flag,
                        'page_flag_sub': self.page_flag + '_update',
                        'category': category,
                        'named': "{{named}}",
                        'numed': "{{numed}}",
                        'cate': cate,
                        'time_rule': [int(i) for i in time_rule],
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

        if option:
            if option == 'update' or option == 'add':

                cate = request.POST.get('cate', None)
                cate = models.Category.objects.get(id = cate)

                time_rule = request.POST.get('time_rule', None)
                content = request.POST.get('content', None)
                content_sub = request.POST.get('content_sub', None)
                content_en = request.POST.get('content_en', None)
                content_sub_en = request.POST.get('content_sub_en', None)

                time_rule = [int(i) for i in time_rule.split(',') if i is not '']


                if danger.xss(named):
                    return JsonResponse({ 'status': False, 'msg': 'xss' })
                if danger.xss(content):
                    return JsonResponse({ 'status': False, 'msg': 'xss' })
                if danger.xss(content_sub):
                    return JsonResponse({ 'status': False, 'msg': 'xss' })
                if danger.xss(content_en):
                    return JsonResponse({ 'status': False, 'msg': 'xss' })
                if danger.xss(content_sub_en):
                    return JsonResponse({ 'status': False, 'msg': 'xss' })

                smsT = None
                smsT_en = None
                service = None

                if option == 'add':
                    service = models.Service()
                    smsT = models.SmsTemplate()
                    smsT_en = models.SmsTemplate()

                elif option == 'update':
                    service_id = request.POST.get('service_id', None)
                    sms_template_id = request.POST.get('sms_template_id', None)
                    sms_template_en_id = request.POST.get('sms_template_en_id', None)

                    service = models.Service.objects.get(id = service_id)
                    smsT = models.SmsTemplate.objects.get(id = sms_template_id)
                    smsT_en = models.SmsTemplate.objects.get(id = sms_template_en_id)

                service.time_rule = time_rule
                service.named = named
                service.save()

                smsT.category = cate
                smsT.content = content
                smsT.content_sub = content_sub

                smsT_en.category = cate
                smsT_en.content = content_en
                smsT_en.content_sub = content_sub_en

                if option == 'add':
                    smsT.service = service
                    smsT.sms_id = '00'
                    smsT.sms_id_sub = '00'
                    smsT.lang = 1

                    smsT_en.service = service
                    smsT_en.sms_id = '00'
                    smsT_en.sms_id_sub = '00'
                    smsT_en.lang = 2

                smsT.save()
                smsT_en.save()

            if option == 'trash':

                pk = request.GET.get('id', None)
                service = models.Service.objects.get(id = pk)

                smsT = models.SmsTemplate.objects.filter(service = service)
                for s in smsT:
                    s.status = False
                    s.save()

                service.status = False
                service.save()

            if option == 'same':
                res['same'] = False
                service = models.Service.objects.filter(Q(status = True) & Q(named = named))

                if len(service) > 0:
                    res['same'] = True

        return JsonResponse(res)
                
