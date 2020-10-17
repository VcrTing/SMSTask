from django.shortcuts import render, redirect
from django.views.generic.base import View
from django.forms.models import model_to_dict
from django.db.models.query import QuerySet
from django.db.models import Q
from django.contrib.auth.hashers import make_password, check_password
from django.http import HttpResponsePermanentRedirect,HttpResponse,JsonResponse

import os, time
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
from Appis.Web.models import SystemMsg, Running

from Twilio.company import Now as company
from Appis.Tool.working.sys import mail
from Appis.Tool.func import danger

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
                    request.session['company'] = company
                    request.session['layout'] = settings.FUNC_LAYOUT
                    
                    return redirect('/')
                msg = '密码错误，若忘记密码，可联系工作人员获得密码，谢谢合作！！！'
        return render(request, 'login.html', { 'title': '登录', 'msg': msg })

class LoginOutView(View):
    def get(self, request):
        request.session['isLogin'] = False
        request.session['user'] = None
        request.session['company'] = None
        request.session['layout'] = None
        return render(request, 'login.html', { 'title': '登录' })

# REST
class TagViewSet(viewsets.ModelViewSet):
    """
        标签
    """
    queryset = user_models.Tag.objects.all()
    serializer_class = serializers.TagSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('named', )
    ordering_fields = ('add_time', )
    pagination_class = pagination.LimitOffsetPagination

class ContactViewSet(viewsets.ModelViewSet):
    """
        联系人
    """
    queryset = user_models.Contact.objects.all()
    serializer_class = serializers.ContactSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('status', 'area', 'gender', 'email', 'phoned', 'star')
    ordering_fields = ('add_time', 'phoned', 'first_named', 'star')
    pagination_class = pagination.LimitOffsetPagination

    def get_queryset(self):
        start_birth = self.request.query_params.get('start_birth', None)
        end_birth = self.request.query_params.get('end_birth', None)
        filter_status = self.request.query_params.get('filter_status', 0)
        filter_tag = self.request.query_params.get('filter_tag', '')

        search = self.request.query_params.get('search', None)
        search_flag = self.request.query_params.get('search_flag', False)

        age_f = self.request.query_params.get('age_f', False)
        
        res = user_models.Contact.objects.filter(
            Q(status = True) )

        if age_f == 'true':
            res = res.filter(
                Q(bith__range = (end_birth, start_birth)) )
        
        if filter_tag != '':
            ids = []
            for contact in res:
                tag_in = contact.tag.values('id').filter(id = filter_tag) # Tag QuerySet Only Id

                if tag_in:
                    ids.append(contact.id)
                
            res = user_models.Contact.objects.filter(pk__in = ids)

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

        if search_flag != '' and search != None:
            if int(search_flag) == 1:
                res = res.filter( phoned__icontains = search )
            elif int(search_flag) == 2:
                res = res.filter( email__icontains = search )
            else:
                res = res.filter( first_named__icontains = search )

        return res

# FUNCTION
class TagView(View):
    def get(self, request):
        option = request.GET.get('option', None)
        if option:
            if option == 'user':
                contact_id = request.GET.get('contact_id', None)
                contact = user_models.Contact.objects.get(id = contact_id)
                
                return JsonResponse({
                    'tags': [tag for tag in contact.tag.values('id', 'named')]
                })
                
        return render(request, 'other/test.html', 
            { 
                'title': '首页 - 邮件增加', 
                'user': contact
            }
        )
    
    def post(self, request):
        option = request.GET.get('option', None)
        if option:
            if option == 'user':
                contact_id = request.GET.get('contact_id', None)
                tags = request.GET.get('tags', None)

                contact = user_models.Contact.objects.get(id = contact_id)

                contact.tag.clear()
                if tags:
                    tags = [int(i) for i in tags.split(',')]
                    for tag in tags:
                        contact.tag.add(tag)
                contact.save()

        return JsonResponse({
            'status': True
        })

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
                            if category[0].status:
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

                nper = [
                    {
                        'val': nr[0],
                        'txt': nr[1]
                    } for nr in common.NPER
                ]
                time_rule = [
                    {
                        'val': tr[0],
                        'txt': tr[1]
                    } for tr in common.TIME_RULE_EMAIL
                ]
                return render(request, 'email/email_tasker.html', 
                    { 
                        'title': '首页 - 邮件增加', 
                        'page_flag': self.page_flag,
                        'page_flag_sub': self.page_flag + '_add',
                        'email_template_list': res,
                        'time_rule': time_rule,
                        'nper': nper
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
        option = request.GET.get('option', None)
        if option == 'delete':
            pk = request.GET.get('id', None)
            contact = user_models.Contact.objects.get(id = pk)
            contact.delete()
            return JsonResponse({ 'status': True })
        
        first_named = request.POST.get('first_named', None)
        area = request.POST.get('area', None)
        phoned = request.POST.get('phoned', None)
        email = request.POST.get('email', None)
        gender = request.POST.get('gender', None)
        bith = request.POST.get('bith', None)
        tags = request.POST.get('tags', None)

        if danger.xss(first_named):
            return JsonResponse({ 'status': False, 'msg': 'xss' })

        if option == 'update':
            pk = request.GET.get('id', None)
            if pk is None:
                return Response({'status': False})
            contact = user_models.Contact.objects.get(pk = id)
        else:
            
            contact = user_models.Contact()
            
        contact.first_named = first_named 
        if area:
            contact.area = sms_models.Area.objects.get(id = area) 
        else:
            contact.area = sms_models.Area.objects.all()[0]
        contact.phoned = phoned 
        contact.email = email
        contact.gender = gender 

        if bith:
            contact.bith = bith
        contact.save()
        
        if tags:
            tags = [int(i) for i in tags.split(',')]
            
            contact.tag.clear()
            for tag in tags:
                contact.tag.add(tag)
            
            contact.save()
        try:
            return JsonResponse({
                'res': True,
                'instance': model_to_dict(contact)
            })
        except:
            return JsonResponse({
                'res': True
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
        EVERY = settings.EVERY
        
        sms_id = request.POST.get('sms_id', None)
        tasker = request.POST.get('tasker', None)
        time_rule_active = request.POST.get('time_rule_active', None)
        
        tasker = [int(i) for i in tasker.split(',') if i is not '']
        time_rule_active = [int(i) for i in time_rule_active.split('_') if i is not '']
        
        tasks = []
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
                
                if int(time_rule_belong) in time_rule_active:
                    every_task = record_models.EveryTask()
                    every_task.sms_task = task
                    every_task.numed = (index + 1)
                    every_task.contact = contact
                    every_task.time_rule_belong = time_rule_belong
                    every_task.save()
                    ids.append(str(every_task.id))

                    task_num += 1

            tasks.append('@'.join(ids))
            if len(tasks) % 5 == 0:
                time.sleep(0.5)

        tasks = [ tasks[i: i + EVERY] for i in range(0, len(tasks), EVERY) ]
        
        for ts in tasks:
            
            ts = '_'.join(ts)
            running = Running()
            running.way = common.WAY[0][0]
            running.ids = ts
            running.done_status = False
            running.block_status = False

            running.save()
            
        return JsonResponse({
            'res': tasker,
            'task_num': task_num
        })

class FeedBackView(View):
    page_flag = 'feedback'

    def get(self, request):
        author = settings.AUTHOR
        return render(request, 'other/feedback.html', 
            { 
                'title': '意见反馈', 
                'page_flag': self.page_flag
            }
        )

    def post(self, request):
        msg = request.POST.get('message', None)
        code = 112
        sub = ''
        res = {
            'suc': 0,
            'msg': '發送失敗！原因可能是賬戶余額不足，若非余額不足請致電 Manfulls公司。'
        }
        
        if danger.xss(msg):
            return JsonResponse({ 'status': False, 'msg': 'xss' })

        for i in common.SYSTEMMSGTYPED:
            if i[0] == code:
                sub = i[1]
                
        for au in settings.AUTHOR:
            
            suc = mail(sub, msg, code, au)
            if suc:
                res['suc'] = res['suc'] + 1

        return JsonResponse(res)