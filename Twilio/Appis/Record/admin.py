from django.contrib import admin

from . import models
from Twilio.settings import ADMIN_CONF

admin.site.site_title = ADMIN_CONF['admin_title']
admin.site.site_header = ADMIN_CONF['admin_header']

# Register your models here.
@admin.register(models.SmsTask)
class SmsTaskAdmin(admin.ModelAdmin):

    list_display = ['sms_template', 'named', 'phoned', 'task_status', 'status', 'add_time']
    # filter_horizontal = ('time_rule', )
    
    search_fields = ['time_rule', 'add_time']
    list_filter = ['status', ]
    readonly_fields = ['add_time']
    exclude = ['id']
    fieldsets = (
        ("SMS详情", {
            "fields": (
                'sms_template', 'task_status'
            ),
        }),
        ("联系人", {
            "fields": (
                'area', 'phoned', 'named', 'end_time'
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

@admin.register(models.EveryTask)
class EveryTaskAdmin(admin.ModelAdmin):
    list_display = ['schedule_id', 'time_rule_belong', 'send_finish_time', 'apply_status', 'send_status', 'sms_task']
    search_fields = ['send_finish_time']
    list_filter = ['send_status', ]
    fieldsets = (
        ("极光字段", {
            "fields": (
                'schedule_id', 'time_rule_belong', 'send_finish_time'
            ),
        }),
        ("队列", {
            "fields": (
                'numed', 'sms_task', 'send_status'
            ),
        }),
        ("返回结果", {
            "fields": (
                'temp_para', 'jsms_response', 'apply_status'
            )
        }),
        ("其他", {
            "fields": (
                'contact_key', 
                'status',
                'add_time'
            ),
        })
    )
    list_per_page = 50
    empty_value_display = ADMIN_CONF['empty_value_display']

    def get_ordering(self, request):
        return ['-add_time', ]


@admin.register(models.SmsTaskRecord)
class SmsTaskRecordAdmin(admin.ModelAdmin):
    list_display = ['title', 'sms_template', 'phoned', 'send_time', 'every_task', 'status', 'add_time']
    search_fields = ['title', 'phoned', 'send_time']
    list_filter = ['status', ]
    exclude = ['id']
    fieldsets = (
        ("信息", {
            "fields": (
                'title',
            ),
        }),
        ("SMS详情", {
            "fields": (
                'phoned', 'sms_template', 'send_time'
            ),
        }),
        ("队列", {
            "fields": (
                'every_task',
            ),
        }),
        ("其他", {
            "fields": (
                'status',
                'add_time'
            ),
        })
    )
    list_per_page = 50
    empty_value_display = ADMIN_CONF['empty_value_display']

    def get_ordering(self, request):
        return ['-add_time', ]
