import json
import time
import datetime
from django import views
from django.shortcuts import render, redirect
from django.views.generic.base import View
from django.http import HttpResponsePermanentRedirect, HttpResponse, JsonResponse
from django.db.models import Q
from django.forms.models import model_to_dict
from django.core import serializers as djSerializer
from django.db import connection 

from rest_framework import filters, pagination
from rest_framework import mixins, viewsets, views, status, generics
from rest_framework.response import Response
from django_filters.rest_framework.backends import DjangoFilterBackend

from Appis.Additional import models
from Appis.Additional import serializers
from Appis.Sms import models as sms_modles
from Appis.User import models as user_modles
from Appis.Web import models as web_models

from Appis.Tool.func.validate import val_send_time, val_future_datetime
from Appis import common as common
from Twilio import settings as settings

from Appis.Record import APSTask as APSTask

from Appis.Tool.func.slice import get_conf
from Appis.Tool.func import danger

# REST
class EmailTemplateViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    """
        邮件模版
    """
    queryset = models.EmailTemplate.objects.all()
    serializer_class = serializers.EmailTemplateSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('status', 'category')
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination

class EmailApplyViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    """
        邮件任务申请列表
    """
    queryset = models.EmailApply.objects.all()
    serializer_class = serializers.EmailApplySerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('status', 'visit_time', 'send_status')
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination

    def get_queryset(self):
        cate = self.request.query_params.get('category', None)
        start_visit = self.request.query_params.get('start_visit', None)
        end_visit = self.request.query_params.get('end_visit', None)
        time_rule = self.request.query_params.get('time_rule', None)
        
        if end_visit != '':
            if start_visit == '':
                start_visit = "2001-1-1"
        if start_visit != '':
            if end_visit == '':
                end_visit = datetime.datetime.now().strftime("%Y-%m-%d")

        res = models.EmailApply.objects.filter (
            Q(status = True)
            )
        if (time_rule) and time_rule != '':
            res = res.filter (
                Q( email_template__time_rule = time_rule) )

        if end_visit != '' and start_visit != '':
            res = res.filter (
                Q( visit_time__range = (start_visit, end_visit)) )

        if (cate) and cate != '':
            res = res.filter(
                Q( email_template__category = cate) )
        return res

class EmailCollectViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    """
        单期邮件记录
    """
    queryset = models.EmailCollect.objects.all()
    serializer_class = serializers.EmailCollectSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('status', 'success_status', 'send_time')
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination
    
    def get_queryset(self):
        cate = self.request.query_params.get('category', None)
        
        res = models.EmailCollect.objects.filter (
            Q(status = True)
            )
        if (cate) and cate != '':
            res = res.filter(
                Q(email_template__category = cate)
                )
        return res
        
class RuningEmailViewSet(mixins.ListModelMixin,viewsets.GenericViewSet):
    queryset = models.EmailApply.objects.all()
    serializer_class = serializers.EmailApplySerializer
            
    def get_queryset(self):
        
        yesterday = val_future_datetime(-1, 0)
        now = datetime.datetime.now()
        
        start_date = datetime.date(yesterday.year, yesterday.month, yesterday.day)
        end_date = datetime.date(now.year, now.month, now.day)
        
        res = models.EmailApply.objects.filter(
            Q(next_time__range = (start_date, end_date)) &
            Q(status = True) & 
            # Q(send_status = True) &
            Q(over_status = False)
            )
        return res

# ============================================= V ===============================================

class EmailView(View):
    page_flag = 'email'
    def get(self, request):
        option = request.GET.get('option', None)

        nper = [
            {
                'val': nr[0],
                'txt': nr[1]
            } for nr in common.NPER
        ]
                
        if option:
            if option == 'add':

                res = []
                
                for cate in common.CATEGORY:
                    if len(str(cate[0])) == 2:
                        c_id = sms_modles.Category.objects.get(flag = cate[0])
                        ets = models.EmailTemplate.objects.filter(Q(category = c_id) & Q(status = True))
                        res.append({
                            'k': c_id.named,
                            'v': [
                                {
                                    'id': et.id,
                                    'service': et.service,
                                    'time_rule': et.time_rule
                                } for et in ets
                            ]
                        })
                api, dom, sender = get_conf('mailgun')
                time_rule = [
                    {
                        'val': tr[0],
                        'txt': tr[1]
                    } for tr in common.TIME_RULE_EMAIL
                ]
                return render(request, 'email/task_add.html', 
                    { 
                        'title': '首页 - 邮件增加', 
                        'page_flag': self.page_flag,
                        'page_flag_sub': self.page_flag + '_add',
                        'email_template_list': res,
                        'reply': sender,
                        'time_rule': time_rule,
                        'nper': nper
                    }
                )
        
        email_apply = models.EmailApply.objects.filter(status = True)
        cate = sms_modles.Category.objects.filter(Q(status = True) & Q(way = common.WAY[1][0]))
        
        return render(request, 'email/email.html', 
            { 
                'title': '首页 - 邮件', 
                'page_flag': self.page_flag,
                'email_apply': email_apply,
                'category': cate,
                'nper': nper
            }
        )

class EmailTemplateView(View):
    page_flag = 'email_template'
    def get(self, request):
        option = request.GET.get('option', None)
        if option:
            category = sms_modles.Category.objects.filter(way = 2)
            time_rule = [{
                    'value': i[0],
                    'view': i[1]
                } for i in common.TIME_RULE_EMAIL]
            if option == 'add':
                email_template = models.EmailTemplate.objects.filter(status = True).order_by('-add_time')

                return render(request, 'service/email_template_add.html', 
                    { 
                        'title': '首页 - 模版新增', 
                        'page_flag': self.page_flag,
                        'page_flag_sub': self.page_flag + '_add',
                        'time_rule': time_rule,
                        'category': category,
                        'email_template': email_template
                    }
                )
            if option == 'update':
                pk = request.GET.get('id', None)
                et = models.EmailTemplate.objects.get(id = pk)
                email_template = models.EmailTemplate.objects.filter(status = True).order_by('-add_time')
                return render(request, 'service/email_template_update.html', 
                    { 
                        'title': '首页 - 模版修改', 
                        'page_flag': self.page_flag,
                        'page_flag_sub': self.page_flag + '_update',
                        'email_template': email_template,
                        'et': et,
                        'time_rule': time_rule,
                        'category': category,
                    }
                )

            if option == 'trash':
                email_template_id = request.GET.get('id', None)
                email_template = models.EmailTemplate.objects.get(id = email_template_id)
                email_template.status = False
                email_template.save()

        email_template = models.EmailTemplate.objects.filter(status = True)
        return render(request, 'service/email_template.html', 
            { 
                'title': '首页 - 模版', 
                'page_flag': self.page_flag,
                'email_template': email_template
            }
        )
    
    def sel(self, message):
        # return message.replace('/media/img/HSIZE_', settings.HOST + '/media/img/HSIZE_')
        return message

    def post(self, request):
        option = request.GET.get('option', None)
        res = {
            'status': True
        }

        if option:
            service = request.POST.get('service', None)
            category = request.POST.get('category', None)
            time_rule = request.POST.get('time_rule', None)
            subject = request.POST.get('subject', None)
            message = request.POST.get('message', None)

            if danger.xss(service) or danger.xss(subject):
                return JsonResponse({ 'status': False, 'msg': 'xss' })
            if danger.xss(message):
                return JsonResponse({ 'status': False, 'msg': 'xss' })

            if option == 'add':
                et = models.EmailTemplate()

            if option == 'update':
                pk = request.GET.get('id', None)
                
                et = models.EmailTemplate.objects.get(id = pk)

            et.category = sms_modles.Category.objects.get(flag = category)
            et.service = service
            et.subject = subject
            et.message = self.sel(message)
            et.time_rule = time_rule

            et.save()

        return JsonResponse(res)

class EmailApplyView(View):
    page_flag = 'email_apply'
    def get(self, request):
        option = request.GET.get('option', None)
        if option:
            if option == 'success':
                id = request.GET.get('id', None)
                if id:
                    ea = models.EmailApply.objects.get(id = id)
                    return render(request, 'email/add_success.html', 
                        { 
                            'title': '首页 - 邮件增加成功', 
                            'page_flag': self.page_flag,
                            'page_flag_sub': self.page_flag + '_success',
                            'wait_minute': settings.WAIT_MINUTES,
                            'email_apply': ea
                        }
                    )

            if option == 'status':
                success = request.GET.get('success', 0)
                count = request.GET.get('count', 0)
                return render(request, 'email/status_success.html', 
                    { 
                        'title': '首页 - 邮件增加成功', 
                        'page_flag': self.page_flag,
                        'page_flag_sub': self.page_flag + '_success',
                        'success': success,
                        'count': count,
                        'wait_minute': settings.WAIT_MINUTES
                    }
                )
            
            if option == 'contact':
                contact_id = request.GET.get('contact', None)
                ea = models.EmailApply.objects.filter(Q(contact = contact_id) & Q(status = True))
                for e in ea:
                    print(e.add_time)
                    print(e.email_template)
                return JsonResponse( djSerializer.serialize('json', ea), safe = False )

    def post(self, request):
        res = {
            'status': False
        }
        option = request.GET.get('option', None)
        if option:
            if option == 'add':
                addr = request.POST.get('addr', None)
                named = request.POST.get('named', None)
                newer = request.POST.get('newer', None)
                nper = request.POST.get('nper', None)
                time_rule = request.POST.get('time_rule', None)
                first_status = request.POST.get('first_status', None)

                if danger.xss(named):
                    return JsonResponse({ 'status': False, 'msg': 'xss' })
                
                if (newer == 'true') or (newer == True):
                    contact = user_modles.Contact()
                    contact.email = addr
                    contact.first_named = named
                    contact.save()
                else:
                    contact = user_modles.Contact.objects.filter(Q(email = addr) & Q(status = True))
                    contact = contact[0]
                
                visit_time = request.POST.get('visit_time', None)
                email_template = request.POST.get('email_template', None)
                
                ea = models.EmailApply()

                if (first_status == 'false') or (first_status == False):
                    ea.first_status = False
                ea.nper = nper
                ea.now_time_rule = time_rule
                ea.contact = user_modles.Contact.objects.get(id = contact.id )
                ea.visit_time = visit_time
                ea.email_template = models.EmailTemplate.objects.get(id = int(email_template))
                
                ea.save()

                connection.close()
                worker = APSTask.TaskProcess([ea.id], common.WAY[1][0])
                worker.start()

                res['id'] = ea.id
                res['status'] = True

            if option == 'tasker':
                numed = settings.EVERY
                tasks = []
                index = 0
                ids = request.POST.get('ids', None)

                ids = ids.split(',')

                nper = request.POST.get('nper', None)
                time_rule = request.POST.get('time_rule', None)

                visit_time = request.POST.get('visit_time', None)
                email_template = request.POST.get('email_template', None)

                first_status = request.POST.get('first_status', None)
                if (first_status == 'false') or (first_status == False):
                    first_status = False
                else:
                    first_status = True
                    
                for e in ids:
                    contact = user_modles.Contact.objects.filter(Q(id = e) & Q(status = True))
                    if contact:
                        contact = contact[0]
                        
                        ea = models.EmailApply()
                        ea.nper = nper
                        ea.now_time_rule = time_rule
                        ea.contact = contact
                        ea.visit_time = visit_time
                        ea.email_template = models.EmailTemplate.objects.get(id = int(email_template))
                        ea.first_status = first_status
                        ea.save()
                        
                        tasks.append(str(ea.id))
                        if len(tasks) % 5 == 0:
                            time.sleep(0.5)

                index = len(tasks)
                tasks = [ tasks[i: i + numed] for i in range(0, len(tasks), numed) ]
                
                for ts in tasks:
                    ts = '_'.join(ts)
                    running = web_models.Running()
                    running.way = common.WAY[1][0]
                    running.ids = ts
                    running.done_status = False
                    running.block_status = False
                    running.save()
                res['status'] = True
                res['numed'] = index
                
            if option == 'update':
                pk = request.POST.get('id', None)
                if pk is None:
                    return JsonResponse(res)
                send_status = request.POST.get('send_status', None)
                
                visit_time = request.POST.get('visit_time', None)
                if int(send_status) == 1:
                    send_status = False
                else:
                    send_status = True
                ea = models.EmailApply.objects.get(id = pk)
                ea.visit_time = visit_time
                ea.send_status = send_status
                ea.save()
                res['status'] = True
                res['instance'] = {
                    'visit_time': visit_time,
                    'send_status': send_status
                }

            if option == 'trash':
                pk = request.GET.get('id', None)
                print(pk)
                print(pk)
                print(pk)
                if pk is None:
                    return JsonResponse(res)
                print(pk)
                ea = models.EmailApply.objects.get(id = pk)
                ea.status = False
                ea.save()
                res['status'] = True 
                """
                res['instance'] = {
                    'named': ea.contact.first_named,
                    'addr': ea.contact.email,
                    'service': ea.email_template.service
                }
                """

        return JsonResponse(res)

class EmailCollectView(View):
    page_flag = 'email_collect'
    def get(self, request):
        option = request.GET.get('option', None)

        nper = [
            {
                'val': nr[0],
                'txt': nr[1]
            } for nr in common.NPER
        ]
                
        if option:
            if option == 'more':
                pk = request.GET.get('id', None)
                ecs = models.EmailCollect.objects.filter(email_apply = pk)
                return render(request, 'collect/email_collect_more.html', 
                    { 
                        'title': '首页 - 邮件记录 - 更多', 
                        'page_flag': self.page_flag,
                        'email_collect': ecs,
                        'nper': nper
                    }
                )
        
        ecs = models.EmailCollect.objects.filter(status = True)
        cate = sms_modles.Category.objects.filter(Q(status = True) & Q(way = common.WAY[1][0]))
        return render(request, 'collect/email_collect.html', 
            { 
                'title': '首页 - 邮件记录', 
                'page_flag': self.page_flag,
                'email_collect': ecs,
                'category': cate,
                'nper': nper
            }
        )
    
    def post(self, request):
        res = {
            'status': False
        }
        option = request.GET.get('option', None)
        if option:
            if option == 'trash':
                pk = request.POST.get('id', None)
                if pk is None:
                    return JsonResponse(res)
                ec = models.EmailCollect.objects.get(id = pk)
                ec.status = False
                ec.save()
                res['status'] = True 
            
        return JsonResponse(res)

