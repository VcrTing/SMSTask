from django.shortcuts import render, redirect
from django.views.generic.base import View
from django.db.models import Q
from django.contrib.auth.hashers import make_password, check_password
from django.http import HttpResponsePermanentRedirect,HttpResponse,JsonResponse

import os
import Twilio.settings as settings
# Create your views here.
from rest_framework import filters, pagination
from rest_framework import mixins, viewsets, views, status, generics
from rest_framework.response import Response
from django_filters.rest_framework.backends import DjangoFilterBackend

from Appis.User import models as user_models
from Appis.Record import models as record_models
from Appis.Sms import models as sms_models
from Appis.Additional import models as addit_models
from Appis.User import serializers
from Appis.Sms.serializers import AreaSerializer

from Appis import common as common
from Twilio import settings as settings
from Appis.Record import APSTask as APSTask

# FOR USERFROFILE
class LoginView(View):
    def get(self, request):
        return render(request, 'login.html', { 'title': '登录' })
    
    def post(self, request):
        msg = '无此账号！！！'
        email = request.POST.get('email', '')
        pwd = request.POST.get('pwd', '')
        users = user_models.UserProfile.objects.all()

        for user in users:
            if user.email == email:
                if check_password(pwd, user.password):
                    
                    request.session['user'] = user.email
                    request.session['isLogin'] = True
                    return redirect('/task/?option=add')
                msg = '密码错误，若忘记密码，可联系工作人员获得密码，谢谢合作！！！'
        return render(request, 'login.html', { 'title': '登录', 'msg': msg })

class LoginOutView(View):
    def get(self, request):
        request.session['isLogin'] = False
        request.session['user'] = None
        return render(request, 'login.html', { 'title': '登录' })

# REST

class ContactViewSet(viewsets.ModelViewSet):
    """
        联系人
    """
    queryset = user_models.Contact.objects.all()
    serializer_class = serializers.ContactSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('status', 'area', 'gender', 'email', 'phoned', 'star')
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination

    def get_queryset(self):
        start_birth = self.request.query_params.get('start_birth', None)
        end_birth = self.request.query_params.get('end_birth', None)
        filter_status = self.request.query_params.get('filter_status', 0)

        age_f = self.request.query_params.get('age_f', False)
        
        res = user_models.Contact.objects.filter(
            Q(status = True) )
        if age_f == 'true':
            res = res.filter(
                Q(bith__range = (end_birth, start_birth)) )
        if filter_status != '':
            filter_status = int(filter_status)
            if filter_status == 1:
                res = res.filter( ~Q(phoned = ''))

            elif filter_status == 2:
                res = res.filter(Q(phoned__isnull = True) | Q(phoned = ''))
                
            elif filter_status == 3:
                res = res.filter( ~Q(email = ''))
                
            elif filter_status == 4:
                res = res.filter(Q(email__isnull = True) | Q(email = ''))
                
        return res

# FUNCTION
class ContactView(View):
    page_flag = 'contact'
    def get(self, request):
        option = request.GET.get('option', None)
        if option:
            if option == 'task':
                res_hk, res_en, category_list = [], [], []
                lang_hk, lang_en = common.LANG[0][0], common.LANG[1][0]
                for cate in common.CATEGORY:
                    if len(str(cate[0])) == 1:
                        category = sms_models.Category.objects.filter(flag = cate[0])
                        if category[0]:
                            st_hk = sms_models.SmsTemplate.objects.filter(Q(category = category[0].id) & Q(status = True) & Q(lang = lang_hk))
                            res_hk.append( st_hk )
                            
                            st_en = sms_models.SmsTemplate.objects.filter(Q(category = category[0].id) & Q(status = True) & Q(lang = lang_en))
                            res_en.append( st_en )

                        category_list.append(category[0])

            if option == 'email':
                res = []
                for cate in common.CATEGORY:
                    if len(str(cate[0])) == 2:
                        c_id = sms_models.Category.objects.get(flag = cate[0])
                        ets = addit_models.EmailTemplate.objects.filter(Q(category = c_id) & Q(status = True))
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
            if option == 'task':
                return render(request, 'record/contact_task.html', 
                    { 
                        'title': '電話薄 - 新建任務', 
                        'page_flag': self.page_flag,
                        'page_flag_sub': 'contact_tasker',
                        'sms_list_hk': res_hk,
                        'sms_list_en': res_en,
                        'category_list': category_list
                    }
                )
            elif option == 'email':
                return render(request, 'email/email_tasker.html', 
                    { 
                        'title': '首页 - 邮件增加', 
                        'page_flag': self.page_flag,
                        'page_flag_sub': self.page_flag + '_add',
                        'email_template_list': res
                    }
                )

        contact_list = user_models.Contact.objects.filter(status = True)
        areas = sms_models.Area.objects.filter(status = True)
        return render(request, 'user/contact.html', 
            { 
                'title': '电话薄', 
                'page_flag': self.page_flag,
                'contact_list': contact_list,
                'areas': areas
            }
        )

    def post(self, request):
        
        first_named = request.POST.get('first_named', None)
        area = request.POST.get('area', None)
        phoned = request.POST.get('phoned', None)
        email = request.POST.get('email', None)
        # gender = request.POST.get('gender', None)
        bith = request.POST.get('bith', None)

        option = request.GET.get('option', None)

        if option == 'update':
            pk = request.GET.get('id', None)
            if pk is None:
                return Response({'status': False})
            contact = user_models.Contact.objects.get(pk = id)
        else:
            
            contact = user_models.Contact()
            
        contact.first_named = first_named 
        contact.area = sms_models.Area.objects.get(id = area) 
        contact.phoned = phoned 
        contact.email = email
        # contact.gender = gender 
        if bith:
            contact.bith = bith
        contact.save()

        return JsonResponse({
            'res': True,
            'instance': ''
        })

class ContactTaskerView(View):
    def get(self, request):
        option = request.GET.get('option', None)

        if option:
            if option == 'success':
                task_num = request.GET.get('task_num', 0)
                contact_num = request.GET.get('contact_num', 0)

                return render(request, 'record/tasker_success.html', 
                    { 
                        'title': '首页', 
                        'page_flag': 'task',
                        'page_flag_sub': 'task_add_success',
                        'task_num': task_num,
                        'contact_num': contact_num
                    }
                )

        return redirect('/')

    def post(self, request):
        
        sms_id = request.POST.get('sms_id', None)
        tasker = request.POST.get('tasker', None)
        
        tasker = [int(i) for i in tasker.split(',') if i is not '']
        
        task_num = 0
        for pk in tasker:
            contact = user_models.Contact.objects.get(id = pk)
            task = record_models.SmsTask()
            task.named = contact.first_named
            task.phoned = contact.phoned
            task.area = contact.area
            sms_template = sms_models.SmsTemplate.objects.get(id = sms_id)
            task.sms_template = sms_template
            task.save()
            ids = []
            
            for index, time_rule_belong in enumerate(sms_template.service.time_rule):
                
                every_task = record_models.EveryTask()
                every_task.sms_task = task
                every_task.numed = index
                every_task.contact_id = contact.id
                every_task.time_rule_belong = time_rule_belong
                every_task.save()
                ids.append(every_task.id)

                task_num += 1

            worker = APSTask.TaskProcess(ids, common.WAY[0][0])
            worker.start()

        return JsonResponse({
            'res': tasker,
            'task_num': task_num
        })