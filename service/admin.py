from django.contrib import admin
from .models import *


@admin.register(UserTransport)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('model', 'color', 'weight')
    list_filter = ('model', 'color', 'weight')
    search_fields = ('title', 'body')


@admin.register(WorkStation)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('name', 'location')
    list_filter = ('name', 'location')
    search_fields = ('name', 'location')


@admin.register(StatusOrder)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('name',)
    list_filter = ('name',)
    search_fields = ('name',)


@admin.register(Detail)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('name', 'detail_code', 'price', 'quantity', 'serial_number')
    search_fields = ('name', 'detail_code', 'price', 'quantity', 'serial_number')


@admin.register(OrderDetail)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('description', 'quantity', 'order', 'detail')
    search_fields = ('description', 'quantity', 'order', 'detail')


@admin.register(Order)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('order_date', 'order_deadline', 'description', 'user_transport')
    search_fields = ('order_date', 'order_deadline', 'description')


@admin.register(Malfunction)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('date_create', 'description')
    search_fields = ('date_create', 'description')


@admin.register(OrderDocument)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('description', 'total_price', 'advice')
    search_fields = ('description', 'total_price', 'advice')


@admin.register(PaymentMethod)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('payment_date', 'status', 'transaction_number')
    list_filter = ('payment_date', 'status')
    search_fields = ('payment_date', 'status', 'transaction_number')


@admin.register(Employee)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'degree', 'sex',)
    list_filter = ('degree', 'sex')
    search_fields = ('first_name', 'last_name', 'middle_name')

admin.site.site_header = "Ген-дир Поплавский М.А."