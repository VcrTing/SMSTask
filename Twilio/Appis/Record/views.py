import json
import datetime
from django import views
from django.shortcuts import render, redirect
from django.views.generic.base import View
from django.http import HttpResponsePermanentRedirect, HttpResponse, JsonResponse
from django.db.models import Q
from django.forms.models import model_to_dict
from django.core import serializers as djSerializer

from rest_framework import filters, pagination
from rest_framework import mixins, viewsets, views, status, generics
from rest_framework.response import Response
from django_filters.rest_framework.backends import DjangoFilterBackend

from Appis.Record import models
from Appis.Sms import models as sms_modles
from Appis.User.models import Contact
from Appis.Record import serializers

from . import APSTask as APSTask
from Appis.Tool.func.validate import val_send_time, val_future_datetime
from Appis.Tool.func import danger
from Appis import common as common
from Twilio import settings as settings

# Create your views here.
class SmsTaskViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    """
        短信任务
    """
    queryset = models.SmsTask.objects.all()
    serializer_class = serializers.SmsTaskSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('status', )
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination

class SmsTaskRecordViewSet(viewsets.ModelViewSet):
    """
        电话薄
    """
    queryset = models.SmsTaskRecord.objects.all()
    serializer_class = serializers.SmsTaskRecordSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('status', )
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination

class EveryTaskViewSet(viewsets.ModelViewSet):
    """
        短信队列
    """
    queryset = models.EveryTask.objects.all()
    serializer_class = serializers.EveryTaskSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('status', 'send_finish_time', 'contact', 'send_status', 'apply_status')
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination

    def get_queryset(self):
        start_date = self.request.query_params.get('start_date', None)
        end_date = self.request.query_params.get('end_date', None)

        if (start_date) and start_date != '':
            return models.EveryTask.objects.filter(
                Q(send_finish_time__range = (start_date, end_date)) & 
                Q(status = True)
                )
        return models.EveryTask.objects.filter(
            Q(status = True)
            )

class RuningTaskViewSet(mixins.ListModelMixin,viewsets.GenericViewSet):
    queryset = models.EveryTask.objects.all()
    serializer_class = serializers.EveryTaskSerializer
            
    def get_queryset(self):
        yesterday = val_future_datetime(-2, 0)
        tomorrow = val_future_datetime(1, 0)
        now = datetime.datetime.now()
        
        start_date = datetime.date(yesterday.year, yesterday.month, yesterday.day)
        end_date = datetime.date(tomorrow.year, tomorrow.month, tomorrow.day)
        """
        start_date = datetime.date(2020, 4, 16)
        end_date = datetime.date(2020, 4, 17)
        """

        return models.EveryTask.objects.filter(
            Q(send_finish_time__range = (start_date, end_date)) & 
            Q(status = True) & 
            Q(send_status = False))

# ============================================= V ===============================================

def val_time_rule_belong(trb):
    trb = int(trb)
    for t in common.TIME_RULE:
        if trb == t[0]:
            return t[1]
def val_send_origin_time(trb):
    if trb == '0':
        return '提交即发送'
    return val_send_time(trb, settings.EACH_DAY, 0)

class TaskView(View):
    page_flag = 'task'
    def get(self, request):
        option = request.GET.get('option', None)
        if option:
            if option == 'add':
                res = []
                category_list = []
                lang = request.GET.get('lang', 1)
                for cate in common.CATEGORY:
                    if len(str(cate[0])) == 1:
                        category = sms_modles.Category.objects.filter(Q(flag = cate[0]))
                        if category[0]:
                            sms_templates = sms_modles.SmsTemplate.objects.filter(Q(category = category[0].id) & Q(status = True) & Q(lang = lang))
                            res.append( sms_templates )
                        category_list.append(category[0])

                areas = sms_modles.Area.objects.filter(status = True)
                return render(request, 'record/task_add.html', 
                    { 
                        'title': '首页', 
                        'page_flag': self.page_flag,
                        'page_flag_sub': self.page_flag + '_add',
                        'areas': areas,
                        'sms_template_list': res,
                        'category_list': category_list,
                        'lang': lang
                    }
                )
            if option == 'trash':
                every_task_id = request.GET.get('id', None)
                every_task = models.EveryTask.objects.get(id = every_task_id)
                every_task.status = False
                every_task.save()

            if option == 'collect':
                return render(request, 'collect/sms_collect.html', 
                    { 
                        'title': '首页', 
                        'page_flag': self.page_flag + '_collect'
                    }
                )

        task_list = models.EveryTask.objects.filter(status = True)
        return render(request, 'record/task.html', 
            { 
                'title': '首页', 
                'page_flag': self.page_flag,
                'task_list': task_list
            }
        )

    def post(self, request):
        option = request.GET.get('option', None)

        if option:

            area = request.POST.get('area', None)
            named = request.POST.get('named', None)
            phoned = request.POST.get('phoned', None)
            sms_template = request.POST.get('sms_template', None)

            if danger.xss(named):
                return redirect('/danger/?option=xss')

            if option == 'add':
                task = models.SmsTask()
                
                task.named = named
                task.phoned = phoned
                area = models.Area.objects.get(id = area)
                task.area = area
                sms_template = models.SmsTemplate.objects.get(id = sms_template)
                task.sms_template = sms_template
                task.save()

                ids = []
                contact_key = request.POST.get('contact_key', None)
                used = request.POST.get('used', None)
                used = used.split(',')
                
                task.save()
                for index, time_rule_belong in enumerate(sms_template.service.time_rule):
                
                    if time_rule_belong in used:
                        every_task = models.EveryTask()
                        every_task.sms_task = task
                        every_task.numed = (index + 1)
                        every_task.contact = Contact.objects.get(id = contact_key)
                        every_task.time_rule_belong = time_rule_belong
                        every_task.save()
                        ids.append(every_task.id)
                worker = APSTask.TaskProcess(ids, common.WAY[0][0])
                worker.start()
                
                return redirect('/task_add_success/')
        
        return redirect('/task/')

class EveryTaskView(View):
    page_flag = 'every_task'
    def get(self, request):
        option = request.GET.get('option', None)

        if option:
            if option == 'every_task':
                pk = request.GET.get('id', 0)
                e = models.EveryTask.objects.get(id = pk)
                return JsonResponse({
                    'a': ''
                })

        return HttpResponse(None)
    

class SmsTaskRecordView(View):
    page_flag = 'sms_task_record'
    def get(self, request):

        sms_task_record_list = models.SmsTaskRecord.objects.filter(status = True)
        return render(request, 'record/smsTaskRecord.html', 
            {
                'title': '首页', 
                'page_flag': self.page_flag,
                'sms_task_record_list': sms_task_record_list
            }
        )

class AddSuccessView(View):
    def get(self, request):
        return render(request, 'record/add_success.html', 
            {
                'title': '首页',
                'page_flag': 'task',
                'page_flag_sub': 'task_add_success',
                'wait_minute': settings.WAIT_MINUTES
            }
        )

class TaskPreView(View):
    def get(self, request):

        named = request.GET.get('named', None)
        sms_template_id = request.GET.get('id', None)

        sms_template = models.SmsTemplate.objects.get(id = sms_template_id)
        time_rule = sms_template.service.time_rule

        res = []

        for time_rule_belong in time_rule:
            i = {
                'time_rule_belong': val_time_rule_belong(time_rule_belong),
                'real_time_rule_belong': int(time_rule_belong),
                'send_origin_time': val_send_origin_time(time_rule_belong),
                'temp_para': {
                    'named': named,
                    'sick_time': val_send_time(time_rule_belong, settings.EACH_DAY, settings.DAY_OFFSET)
                },
                'content': sms_template.content,
                'content_sub': sms_template.content_sub
            }
            res.append(i)

        return JsonResponse({
            'res': res,
            'service': model_to_dict(sms_template.service),
            'sms_template': model_to_dict(sms_template)
        })