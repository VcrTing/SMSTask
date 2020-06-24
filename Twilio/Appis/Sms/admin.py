from django.contrib import admin

from . import models
from Twilio.settings import ADMIN_CONF

admin.site.site_title = ADMIN_CONF['admin_title']
admin.site.site_header = ADMIN_CONF['admin_header']

# Register your models here.

@admin.register(models.Area)
class AreaAdmin(admin.ModelAdmin):
    list_display = ['named', 'phoned_prefix', 'status', 'add_time']
    search_fields = ['phoned_prefix', 'named']
    readonly_fields = ['add_time']
    exclude = ['id']
    fieldsets = (
        ("电话信息", {
            "fields": (
                'named', 'phoned_prefix'
            ),
        }),
        ("其他", {
            "fields": (
                'status', 'add_time',
            ),
        }),
    )
    list_per_page = 50
    empty_value_display = ADMIN_CONF['empty_value_display']

    def get_ordering(self, request):
        return ['-add_time', ]

@admin.register(models.SmsTemplate)
class SmsTemplateAdmin(admin.ModelAdmin):
    list_display = ['service', 'category', 'lang', 'content', 'add_time']
    search_fields = ['content', 'lang']
    list_filter = ['lang', 'category']
    readonly_fields = ['add_time']
    exclude = ['id']
    fieldsets = (
        ("信息", {
            "fields": (
                'sms_id', 'content', 'sms_id_sub', 'content_sub'
            ),
        }),
        ("所属服务", {
            "fields": (
                'service', 'category'
            ),
        }),
        ("其他", {
            "fields": (
                'lang', 'status', 'add_time'
            ),
        }),
    )

    list_per_page = 50
    empty_value_display = ADMIN_CONF['empty_value_display']

    def get_ordering(self, request):
        return ['add_time', ]

@admin.register(models.Service)
class ServiceAdmin(admin.ModelAdmin):
    list_display = ['named', 'time_rule', 'add_time']
    search_fields = ['time_rule', 'named']
    readonly_fields = ['add_time']
    exclude = ['id']
    fieldsets = (
        ("电话信息", {
            "fields": (
                'named', 'time_rule'
            ),
        }),
        ("其他", {
            "fields": (
                'add_time',
            ),
        }),
    )
    list_per_page = 50
    empty_value_display = ADMIN_CONF['empty_value_display']

    def get_ordering(self, request):
        return ['-add_time', ]

@admin.register(models.Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ['named', 'flag', 'way', 'add_time']
    search_fields = ['flag', 'named']
    readonly_fields = ['add_time']
    exclude = ['id']
    fieldsets = (
        ("分类信息", {
            "fields": (
                'named', 'flag', 'way'
            ),
        }),
        ("其他", {
            "fields": (
                'status',
                'add_time',
            ),
        }),
    )
    list_per_page = 50
    empty_value_display = ADMIN_CONF['empty_value_display']

    def get_ordering(self, request):
        return ['-add_time', ]
