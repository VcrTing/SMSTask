from django.shortcuts import render, redirect
from django.views.generic.base import View
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
from Appis.Web import serializers

from Appis.Tool.working import num
from Appis.Tool.scret import scret
from Appis.Tool.send import mailgun_now
from Appis.Tool.func import img as voez

from Media.data.insert import insert as data_insert
from Media.data.insert import insert_service as data_insert_service
from Twilio.company import Now as company
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
        
        return redirect('/email/')

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
                print('working =', working)

                if working == 1:

                    rec = data_insert(company)

                    if rec:
                        res['status'] = True
                        res['area'] = rec['area']
                        res['category'] = rec['cate']

                elif working == 21:

                    rec = data_insert_service(company)
                    print('service rec =', rec)

                    if rec:
                        res['status'] = True
                        res['service'] = rec['service']
                        res['template'] = rec['template']

                elif working == 22:
                    pass
                    # 删除短信服务
              
        print('Res =', res)      
        return JsonResponse(res)

class HelpView(View):
    def get(self, request):

        return render(request, 'other/help.html', { 'title': '首页', 'page_flag': 'help' })

class NumView(View):
    page_flag = 'sms_num'
    def get(self, request):
        res = {
            'status': True
        }
        option = request.GET.get('option', None)

        if option == 'jt':
            jsms = num.jsms_num()
            try:
                if 'dev_industry' in jsms:
                    res['jsms'] = jsms
                else:
                    res['status'] = False
            except:
                res['status'] = False

            twilio = num.twilio_num()
            if twilio is None:
                res['twilio'] = { 'currency': 'USD', 'balance': 0 }
            else:
                res['twilio'] = twilio

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

            saving = self.save_key(conf.sid, conf.token, conf.flag, conf.sender)
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

        try:
            rec = Image.open(_img)
            w = rec.width
            h = rec.height
            mo_img = models.Img()

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

            mo_img.w = w 
            mo_img.h = h 
            mo_img.save()
            
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