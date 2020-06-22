from django.contrib import admin

from . import models
from Twilio.settings import ADMIN_CONF

admin.site.site_title = ADMIN_CONF['admin_title']
admin.site.site_header = ADMIN_CONF['admin_header']

# Register your models here.
@admin.register(models.EmailTemplate)
class EmailTemplateAdmin(admin.ModelAdmin):

    list_display = ['subject', 'message', 'time_rule', 'service', 'category', 'status', 'add_time']
    # filter_horizontal = ('time_rule', )
    
    search_fields = ['subject', 'service']
    list_filter = ['status', 'category']
    readonly_fields = ['add_time']
    exclude = ['id']
    fieldsets = (
        ("邮件内容", {
            "fields": (
                'subject', 'message'
            ),
        }),
        ("所属分类", {
            "fields": (
                'service', 'category', 'time_rule'
            ),
        }),
        ("其他", {
            "fields": (
                'status', 'add_time'
            ),
        }),
    )
    list_per_page = 50
    empty_value_display = ADMIN_CONF['empty_value_display']

    def get_ordering(self, request):
        return ['-add_time', ]

@admin.register(models.EmailApply)
class EmailApplyAdmin(admin.ModelAdmin):

    list_display = ['email_template', 'contact', 'send_status', 'over_status', 'status', 'add_time']
    # filter_horizontal = ('time_rule', )
    
    search_fields = ['add_time', ]
    list_filter = ['status', ]
    readonly_fields = ['add_time']
    exclude = ['id']
    fieldsets = (
        ("接收者", {
            "fields": (
                'contact', 'visit_time', 
            ),
        }),
        ("任务信息", {
            "fields": (
                'email_template', 'now_index', 'next_time'
            ),
        }),
        ("任务状态", {
            "fields": (
                'apply_status', 'send_status', 'over_status'
            ),
        }),
        ("其他", {
            "fields": (
                'status', 'add_time'
            ),
        })
    )
    list_per_page = 50
    empty_value_display = ADMIN_CONF['empty_value_display']

    def get_ordering(self, request):
        return ['-add_time', ]

@admin.register(models.EmailCollect)
class EmailCollectAdmin(admin.ModelAdmin):

    list_display = ['email_apply', 'email_template', 'send_time', 'index', 'success_status', 'status', 'add_time']
    # filter_horizontal = ('time_rule', )
    
    search_fields = ['send_time', ]
    list_filter = ['status', 'send_time', 'success_status']
    readonly_fields = ['add_time']
    exclude = ['id']
    fieldsets = (
        ("邮件相关", {
            "fields": (
                'email_apply', 'email_template', 'success_status', 
            ),
        }),
        ("发送相关", {
            "fields": (
                'send_time', 'index', 'json_response'
            ),
        }),
        ("其他", {
            "fields": (
                'status', 'add_time'
            ),
        })
    )
    list_per_page = 50
    empty_value_display = ADMIN_CONF['empty_value_display']

    def get_ordering(self, request):
        return ['-add_time', ]