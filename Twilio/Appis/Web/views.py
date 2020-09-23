from django.shortcuts import render, redirect
from django.views.generic.base import View
from django.db.models import Q
from django.forms.models import model_to_dict
from django.http import HttpResponsePermanentRedirect, HttpResponse, JsonResponse

import os, json, uuid
from PIL import Image
import Twilio.settings as settings

from rest_framework import filters, pagination
from rest_framework import mixins, viewsets, views, status, generics
from rest_framework.response import Response
from django_filters.rest_framework.backends import DjangoFilterBackend

from Appis.Web import models
from Appis.Sms import models as sms_models
from Appis.Additional import models as additional_models
from Appis.Record import models as record_models
from Appis.Web import serializers

from Appis.Tool.working import num, sys
from Appis.Tool.scret import scret
from Appis.Tool.send import mailgun_now
from Appis.Tool.func import img as voez
from Appis.Tool.func import imports as imports
from Appis.Tool.func.slice import save_key
from Appis.Tool.index import running_task

from Media.data.insert import init as data_insert

from Media.data.tool import change_conf, load, scopy

from Twilio.company import Now as company
from Twilio.company import SYS_MAIL
from Twilio.settings import BASE_DIR, MEDIA_ROOT
from Appis.common  import SYSTEMMSGTYPED, ICON, BGIMG
# Create your views here.

class SMSConfViewSet(viewsets.ModelViewSet):
    """
        短信模版
    """
    queryset = models.SMSConf.objects.all()
    serializer_class = serializers.SMSConfSerializer
    ordering_fields = ('add_time', )
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('flag', )
    pagination_class = pagination.LimitOffsetPagination

class SystemMsgViewSet(viewsets.ModelViewSet):
    """
        系统消息
    """
    queryset = models.SystemMsg.objects.all()
    serializer_class = serializers.SystemMsgSerializer
    ordering_fields = ('add_time', )
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filter_fields = ('success_status', 'status')
    pagination_class = pagination.LimitOffsetPagination

class ImgViewSet(viewsets.ModelViewSet):
    """
        图片
    """
    queryset = models.Img.objects.all()
    serializer_class = serializers.ImgSerializer
    ordering_fields = ('add_time', )
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    pagination_class = pagination.LimitOffsetPagination

# ===================================================================
class WebView(View):
    def get(self, request):
        if company == '123medhk':
            return redirect('/task/?option=add')
        elif company == 'eye':
            return redirect('/email/?option=add')
        return redirect('/email/')

class StyleView(View):
    _icon = 'Icon'
    _banner = 'Banner'
    _bgimg = 'Background'
    bridge = 'bridge_'
    i_def = 'default.jpg'
    b_def = 'default.jpg'
    common_path = os.path.join(BASE_DIR, 'Static', 'Common')

    def _change(self, the_dir, old, new):
        old = os.path.join(self.common_path, the_dir, old)
        new = os.path.join(self.common_path, the_dir, new)
        
        return scopy(old, new)
    
    def _del(self, the_dir, name):
        _name = os.path.join(self.common_path, the_dir, name)
        
        os.remove(_name)
        return True
    
    def do_change(self, the_dir, the_def, origin):
        res = self._del(the_dir, the_def)
        if res:
            res = self._change(the_dir, origin, the_def)
            if res:
                return 2
            return 1
        return 0

    def get(self, request):
        return JsonResponse({ 'status': True })

    def post(self, request):
        res = {
            'icon': 0,
            'bgimg': 0,
            'banner': 0
        }

        oi = int(request.POST.get('old_icon', '0'))
        ob = int(request.POST.get('old_bgimg', '0'))
        ni = int(request.POST.get('new_icon', '0'))
        nb = int(request.POST.get('new_bgimg', '0'))

        if oi == ni:
            i = 0
        else:
            _origin = ICON[ni]['def']

            res['icon'] = self.do_change(self._icon, self.i_def, _origin)

            change_conf(company, ni, False)

        if ob == nb:
            i = 0
        else:
            _origin = BGIMG[nb]['def']
            
            res['bgimg'] = self.do_change(self._bgimg, self.b_def, _origin)
            res['banner'] = self.do_change(self._banner, self.b_def, _origin)

            change_conf(company, False, nb)
            
        return JsonResponse(res)

class DataView(View):
    def get(self, request):
        res = {
            "status": False,
            "areas": True,
            "cates": True,
            "is_new": True
        }
        option = request.GET.get('option', None)
        
        if option:
            areas = sms_models.Area.objects.filter(status = True)
            cates = sms_models.Category.objects.filter(status = True)
            
            if len(areas) == 0:
                res['areas'] = False
            if len(cates) == 0:
                res['cates'] = False
            if res['areas']:
                if res['cates']:
                    res['is_new'] = False

            return JsonResponse(res)

        return render(request, 'other/data.html', { 
            'title': '数据处理', 
            'page_flag': 'data'
        })
    
    def post(self, request):
        res = {
            'status': False
        }
        option = request.GET.get('option', None)
        if option:
            if option == 'doing':
                working = int(request.POST.get('working', 0))

                if working == 1:

                    rec = data_insert(company)

                    if rec:
                        res['status'] = True
                        res['area'] = rec['area']
                        res['category'] = rec['cate']

                elif working == 21:

                    pass

                elif working == 22:
                    pass
                    # 删除短信服务
                
        return JsonResponse(res)

class DangerView(View):
    def get(self, request):
        res = {
            'msg': '危險，您的該項操作或輸入，會對網站造成困擾！！！'
        }
        option = request.GET.get('option', None)
        if option:
            if option == 'xss':
                res['msg'] = '警告！檢測到XSS腳本攻擊輸入，我們已撤銷您剛才的申請。'
            if option == 'blocking':
                res['msg'] = '警告！該網站已限速，請勿惡意點擊。'

        return render(request, 'catch/danger.html', res)

class ImportView(View):
    def get(self, request):
        res = {
            'title': '数据导入导出',
            'msg': '没有任何数据可导入'
        }
        option = request.GET.get('option', 'csv')
        res['typed'] = option
        return render(request, 'other/import.html', res)
    
    def _loadFile(self, typed, request):
        company = request.session.get('company')
        _dir = os.path.join(MEDIA_ROOT, 'data', company, typed)
        fs = os.listdir(_dir)
        return [f for f in fs if f.endswith(typed)]

    def post(self, request):
        option = request.GET.get('option', None)
        typed = request.GET.get('typed', 'csv')
        res = {
            'status': True
        }
        if option:
            if option == 'load':
                fs = self._loadFile(typed, request)
                res['files'] = fs
                print('files =', res['files'])
            elif option == 'import':
                f = request.POST.get('file', None)
                field = str(f).split('.')[0]
                f = os.path.join(MEDIA_ROOT, 'data', company, typed, f)

                rec = imports.import_csv(f, field)
        return JsonResponse(res)

class HelpView(View):
    def get(self, request):
        now = load('_conf', company)
        if now:
            pass
        else:
            now = { 'now_icon': 0, 'now_bgimg': 0 }

        return render(request, 'other/other.html', { 
            'title': '首页', 
            'page_flag': 'other',
            'icons': ICON,
            'bgimgs': BGIMG,
            'now_icon': now['now_icon'],
            'now_bgimg': now['now_bgimg']
        })

class NumView(View):
    page_flag = 'sms_num'
    def get(self, request):
        res = {
            'status': True
        }
        option = request.GET.get('option', None)

        if option == 'jt':
            """
            jsms = num.jsms_num()
            try:
                if 'dev_industry' in jsms:
                    res['jsms'] = jsms
                else:
                    res['status'] = False
            except:
                res['status'] = False
            """

            twilio = num.twilio_num()
            if twilio is None:
                res['twilio'] = { 'currency': 'USD', 'balance': 0 }
            else:
                res['twilio'] = twilio

        return JsonResponse(res)

class IncentiveView(View):
    

    def post(self, request):
        res = {
            'status': False
        }
        option = request.POST.get('opion', None)

        if option:
            if option == 'sms':
                pass 
            if option == 'email':
                email = additional_models.EmailApply.objects.filter(
                    Q(status = True) &
                    Q(apply_status = False)
                )
                
            if option == 'notification':
                pass 
        
        return JsonResponse(res)

class SMSConfView(View):

    def get(self, request):
        res = {
            'status': True
        }
        option = request.GET.get('option', None)

        if option == 'view':
            return render(request, 'other/conf.html')

        if option == 'get':
            try:
                flag = request.GET.get('flag', None)
                sc = models.SMSConf.objects.filter(flag = flag)[0]
                res['sid'] = scret.desalt( sc.sid )
                res['token'] = scret.desalt( sc.token )
                res['sender'] = sc.sender
            except:
                return JsonResponse({ 'status': False })
        return JsonResponse(res)

    def post(self, request):
        res = {
            'status': False
        }
        option = request.GET.get('option', None)

        if option == 'plus':
            sid = request.POST.get('sidkey', None)
            token = request.POST.get('scret', None)
            flag = request.POST.get('named', None)
            sender = request.POST.get('sender', None)
            
            conf = models.SMSConf()
            conf.sid = scret.ensalt(sid) 
            conf.token = scret.ensalt(token)
            conf.sender = sender
            conf.flag = flag

            saving = save_key(conf.sid, conf.token, conf.flag, conf.sender)
            res['status'] = saving

        return JsonResponse(res, safe=False)

class ImgView(View):
    def get(self, request):
        option = request.GET.get('option', 'page')

        comp = settings.COMP
        if option == 'trash':
            pk = request.GET.get('id', None)
            
            if pk == None:
                return JsonResponse({ 'status': False, 'msg': '未找到要刪除的對象！！！' })
            img = models.Img.objects.get(id = pk)
            img.delete()

            return JsonResponse({ 'status': True })

        return render(request, 'other/library.html', { 
            'option': option, 
            'page_flag': 'library',
            'title': '媒體庫',
            'comp': comp
        })

    def post(self, request):
        res = {
            'status': False
        }
        _img = request.FILES.get('img', None)
        ext = request.POST.get('ext', False)
        s = request.POST.get('size', None)

        option = request.GET.get('option', None)

        try:
            rec = Image.open(_img)
            w = rec.width
            h = rec.height

            mo_img = models.Img()
            mo_img.w = w 
            mo_img.h = h 

            if ext == 'gif':
                mo_img.img = _img
                mo_img.img_tiny = mo_img.img 

            else:
                quality = voez._quality(s)
                thum = voez._thum(w, h, s)

                img_name = voez.save(rec, ext, 'img', quality)
                mo_img.img = img_name

                if thum == 100:
                    mo_img.img_tiny = mo_img.img
                else:
                    mo_img.img_tiny = voez.save(rec, ext, 'img_tiny', thum)

            mo_img.save()

            if option == 'ckeditor':
                res = {
                    'uploaded': 1,
                    'url': str(mo_img.img)
                }
            else:
                res['status'] = True
                res['instance'] = {
                    'img': str(mo_img.img),
                    'img_tiny': str(mo_img.img_tiny),
                    'w': w,
                    'h': h,
                    'id': mo_img.id
                }
            
            mo_img.save()
        except:
            res['msg'] = '該照片有問題，後臺無法識別！！！'
        return JsonResponse(res)

class BackUpView(View):
    def get(self, request):
        from Appis.Tool.backup.index import backup, trash
        option = request.GET.get('option', None)
        if option == 'backup':
            backup()
        elif option == 'trash':
            trash()

        return JsonResponse( { 
            "status": True  
        } )

class TaskView(View):
    def get(self, request):
        typed = 111
        for i in SYSTEMMSGTYPED:
            if i[0] == typed:
                sys.mail(
                    '[ERROR] ' + i[1],
                    '网站：' + company + '\n请登录后台查看，或联系开发人员解决问题，请务必两日内解决该问题！！！',
                    typed,
                    SYS_MAIL
                )
        return JsonResponse({ 'status': True })

"""
    定时任务

"""
import time, logging
import apscheduler

from Appis.Tool.index import running_task as rt

from Appis.Web.task.aps import init_scheduler_options

from apscheduler.schedulers.background import BackgroundScheduler
from apscheduler.events import EVENT_JOB_ERROR, EVENT_JOB_MISSED, EVENT_JOB_EXECUTED

logger = logging.getLogger('job')

def fun():
    rt()

def job_listener(Event):
    job = sch.get_job(Event.job_id)

    if not Event.exception:
        logger.info("jobname=%s|jobtrigger=%s|jobtime=%s|retval=%s", job.name, job.trigger,
                    Event.scheduled_run_time, Event.retval)
    else:
        logger.error("jobname=%s|jobtrigger=%s|errcode=%s|exception=[%s]|traceback=[%s]|scheduled_time=%s", job.name,
                     job.trigger, Event.code,
                     Event.exception, Event.traceback, Event.scheduled_run_time)

sch = BackgroundScheduler(**init_scheduler_options)

sch.add_listener(
    job_listener, 
    EVENT_JOB_ERROR | \
    EVENT_JOB_MISSED | \
    EVENT_JOB_EXECUTED
)

sch.add_job(fun, 'interval', seconds = 60*10, id = company, misfire_grace_time = 60*11)
sch.start()