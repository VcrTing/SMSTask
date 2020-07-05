from django.contrib import admin

from . import models
# Register your models here.
from Twilio.settings import ADMIN_CONF

admin.site.site_title = ADMIN_CONF['admin_title']
admin.site.site_header = ADMIN_CONF['admin_header']

@admin.register(models.SystemMsg)
class SystemMsgAdmin(admin.ModelAdmin):
    list_display = ['subject', 'message', 'way', 'status', 'add_time']
    readonly_fields = ['add_time']
    exclude = ['id']
    fieldsets = (
        ("消息", {
            "fields": (
                'subject', 'message', 'success_status'
            ),
        }),
        ("定位", {
            "fields": (
                'typed', 'way'
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

@admin.register(models.Img)
class ImgAdmin(admin.ModelAdmin):
    list_display = ['add_time', 'img', 'w', 'h']
    readonly_fields = ['add_time']
    exclude = ['id']
    list_per_page = 50
    empty_value_display = ADMIN_CONF['empty_value_display']

    def get_ordering(self, request):
        return ['-add_time', ]
    
    