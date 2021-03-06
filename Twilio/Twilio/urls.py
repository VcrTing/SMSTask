from django.contrib import admin
from django.urls import path, include, re_path
from django.conf.urls import static
from django.views.static import serve

from rest_framework import routers
from rest_framework.documentation import include_docs_urls

from . import settings
from .company import TEST
# from .catch import handler

from Appis.Web import views as Web
from Appis.Web import views_option as Webop
from Appis.Sms import views as Sms
from Appis.User import views as User
from Appis.Record import views as Record
from Appis.Additional import views as Additional

# REST
router = routers.DefaultRouter()

router.register('img', Web.ImgViewSet)
router.register('sms_conf', Web.SMSConfViewSet)
router.register('system_msg', Web.SystemMsgViewSet)
router.register('running', Web.RunningViewSet)

router.register('contact', User.ContactViewSet)
router.register('tag', User.TagViewSet)

# router.register('service', Sms.ServiceViewSet)
router.register('area', Sms.AreaViewSet)
router.register('category', Sms.CategoryViewSet)
router.register('sms_template', Sms.SmsTemplateViewSet)

# router.register('member', MemberView.MemberViewSet)
router.register('record', Record.SmsTaskRecordViewSet)
router.register('task', Record.SmsTaskViewSet)
router.register('every_task', Record.EveryTaskViewSet)
router.register('running_task', Record.RuningTaskViewSet)
router.register('contact_task', Record.ContactTaskViewSet)

router.register('email_template', Additional.EmailTemplateViewSet)
router.register('email_apply', Additional.EmailApplyViewSet)
router.register('email_collect', Additional.EmailCollectViewSet)
router.register('running_email', Additional.RuningEmailViewSet)


# URL
urlpatterns = [    
    path('', Web.WebView.as_view()),
    path('img/', Web.ImgView.as_view()),
    path('other/', Web.HelpView.as_view()),
    path('login/', User.LoginView.as_view()),
    path('login-out/', User.LoginOutView.as_view()),
    path('service/', Sms.ServiceView.as_view()),
    path('contact/', User.ContactView.as_view()),
    path('tag/', User.TagView.as_view()),
    path('task/', Record.TaskView.as_view()),
    path('email/', Additional.EmailView.as_view()),
    path('email_template/', Additional.EmailTemplateView.as_view()),
    path('email_apply/', Additional.EmailApplyView.as_view()),
    path('email_collect/', Additional.EmailCollectView.as_view()),

    path('every_task/', Record.EveryTaskView.as_view()),
    path('sms_task_record/', Record.SmsTaskRecordView.as_view()),
    path('task_add_success/', Record.AddSuccessView.as_view()),
    path('task_preview/', Record.TaskPreView.as_view()),
    path('contact_tasker/', User.ContactTaskerView.as_view()),

    path('scret_window/', Web.SMSConfView.as_view()),
    path('init/', Web.DataView.as_view()),
    path('backup/', Web.BackUpView.as_view()),
    path('danger/', Web.DangerView.as_view()),
    path('feedback/',User.FeedBackView.as_view()),

    path('num/', Web.NumView.as_view()),
    path('style/', Web.StyleView.as_view()),
    path('task_running/', Web.TaskView.as_view()),
    path('incentive_task/', Web.IncentiveView.as_view()),
    
    path('import/',Webop.ImportView.as_view()),
    path('option/delete/',Webop.OptionDeleteView.as_view()),

    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    re_path(r'^media/(?P<path>.*)$',  serve, {'document_root': settings.MEDIA_ROOT}),
    re_path(r'^static/(?P<path>.*)$', serve, {'document_root': settings.STATIC_URL}),

]

if TEST:
    urlpatterns += [
        path('docs/', include_docs_urls(title='SMS任务管理系统')),
        path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    ]

# handler404 = handler.unfound
# handler500 = handler.unright
# handler400 = handler.unrequest