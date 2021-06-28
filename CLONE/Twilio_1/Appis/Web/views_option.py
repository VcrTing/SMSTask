from django.shortcuts import render, redirect
from django.views.generic.base import View
from django.db.models import Q
from django.forms.models import model_to_dict
from django.http import HttpResponsePermanentRedirect, HttpResponse, JsonResponse

import os, json, uuid, time
from PIL import Image
import Twilio.settings as settings

from rest_framework import filters, pagination
from rest_framework import mixins, viewsets, views, status, generics
from rest_framework.response import Response
from django_filters.rest_framework.backends import DjangoFilterBackend

from Appis.Web import models
from Appis.Sms import models as sms_models
from Appis.User import models as user_models
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
            elif option == 'import':
                f = request.POST.get('file', None)
                field = str(f).split('.')[0]
                f = os.path.join(MEDIA_ROOT, 'data', company, typed, f)
                
                rec, index = imports.import_csv(f, field)
                res['index'] = index
                res['rec'] = rec
        return JsonResponse(res)

class OptionDeleteView(View):
    def get(self, request):
        res = { }
        pwd = request.GET.get('pwd', None)
        if pwd == 'vcrting':
            print('START')
            res['status'] = True

            tag = user_models.Tag.objects.filter(named = '屈醫生')
            print(tag)

            cons = user_models.Contact.objects.filter(tag = tag[0])
            print(len(cons))

            index = 0
            for c in cons:
                c.delete()

                index += 1
                if index % 10 == 0:
                    time.sleep(0.1)

        return JsonResponse(res)