from django.contrib import admin
from django.db import models as djmodel
from django.contrib.auth.admin import UserAdmin

from . import models
from Twilio.settings import ADMIN_CONF

admin.site.site_title = ADMIN_CONF['admin_title']
admin.site.site_header = ADMIN_CONF['admin_header']

# Register your models here.

@admin.register(models.UserProfile)
class UserProfileAdmin(UserAdmin):
    list_display = ['username', 'nickName', 'phone', 'email', 'gender', 'status']
    search_fields = ['phone', 'email']
    list_filter = ['gender', 'status']
    readonly_fields = ['last_login']
    exclude = ['id']
    fieldsets = (
        ("账号信息", {
            "fields": (
                'username', 'email', 'password'
            ),
        }),
        ("权限相关", {
            "fields": (
                'is_staff', 'is_active', 'groups'
            ),
        }),
        ("个人资料", {
            "fields": (
                'nickName', 'bith', 'phone', 'gender'
            ),
        }),
        ("其他", {
            "fields": (
                'last_login', 'date_joined'
            ),
        }),
    )
    list_per_page = 50
    empty_value_display = ADMIN_CONF['empty_value_display']

@admin.register(models.Contact)
class ContactAdmin(admin.ModelAdmin):
    list_display = ['phoned', 'first_named', 'bith' , 'gender', 'area', 'add_time']
    search_fields = ['phoned', 'first_named']
    readonly_fields = ['add_time']
    exclude = ['id']
    fieldsets = (
        ("联系人资料", {
            "fields": (
                'first_named', 'bith', 'gender'
            ),
        }),
        ("联络信息", {
            "fields": (
                'email', 'phoned', 'area', 'star', 'tag'
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

@admin.register(models.Tag)
class TagAdmin(admin.ModelAdmin):
    list_display = ['named', 'add_time']
    search_fields = ['named']
    readonly_fields = ['add_time']
    exclude = ['id']
    fieldsets = (
        ("标签信息", {
            "fields": (
                'named', 
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