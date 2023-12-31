import datetime

from django.contrib.auth.models import AbstractUser, User
from django.db import models

from django.conf import settings

from django.contrib.auth import get_user_model


# User_ = get_user_model()


class UserTransport(models.Model):
    model = models.CharField(max_length=127)
    color = models.CharField(max_length=127)
    serial_number = models.CharField(max_length=127)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    weight = models.DecimalField(max_digits=8, decimal_places=2)

    class Meta:
        db_table = 'user_transport'
        verbose_name = 'Транспорт клиента'
        verbose_name_plural = 'Транспорты клиента'


class WorkStation(models.Model):
    name = models.CharField(max_length=127)
    location = models.CharField(max_length=255)

    class Meta:
        db_table = 'work_station'
        verbose_name = 'Рабочая станция'
        verbose_name_plural = 'Рабочие станции'


class StatusOrder(models.Model):
    name = models.CharField(max_length=127)

    class Meta:
        db_table = 'status_order'
        verbose_name = 'Статус Заказа'
        verbose_name_plural = 'Статусы Заказов'


class Detail(models.Model):
    name = models.CharField(max_length=127)
    detail_code = models.CharField(max_length=127)
    price = models.DecimalField(max_digits=8, decimal_places=2)
    quantity = models.PositiveIntegerField()
    serial_number = models.CharField(max_length=127)

    class Meta:
        db_table = 'detail'
        verbose_name = 'Деталь'
        verbose_name_plural = 'Детали'


class OrderDetail(models.Model):
    description = models.CharField(max_length=127, null=True)
    quantity = models.PositiveIntegerField()
    order = models.ForeignKey("Order", on_delete=models.CASCADE)
    detail = models.ForeignKey("Detail", on_delete=models.CASCADE)

    class Meta:
        db_table = 'order_detail'
        verbose_name = 'Деталь Заказа'
        verbose_name_plural = 'Детали Заказов'


class Order(models.Model):
    order_date = models.DateTimeField(default=datetime.datetime.now())
    order_deadline = models.DateTimeField()
    description = models.CharField(max_length=511)
    user_transport = models.ForeignKey(UserTransport, on_delete=models.CASCADE, related_name='transport_order')
    status_order = models.ForeignKey(StatusOrder, on_delete=models.CASCADE, related_name='order_status_order')
    work_station = models.ForeignKey(WorkStation, on_delete=models.CASCADE, related_name='work_station_order')
    order_document = models.OneToOneField('OrderDocument', on_delete=models.SET_NULL, null=True,
                                          related_name='order_document_order')
    malfunction = models.OneToOneField('Malfunction', on_delete=models.SET_NULL, null=True,
                                       related_name='malfunction_order')
    employee = models.ManyToManyField('Employee')

    class Meta:
        db_table = 'order'
        verbose_name = 'Заказ'
        verbose_name_plural = 'Заказы'


class Malfunction(models.Model):
    date_create = models.DateTimeField(default=datetime.datetime.now())
    description = models.CharField(max_length=511)

    class Meta:
        db_table = 'malfunction'
        verbose_name = 'Поломка'
        verbose_name_plural = 'Поломки'


class OrderDocument(models.Model):
    date_start = models.DateTimeField()
    date_end = models.DateTimeField()
    description = models.CharField(max_length=511)
    total_price = models.DecimalField(max_digits=8, decimal_places=2)
    payment_method = models.OneToOneField('PaymentMethod', on_delete=models.SET_NULL, null=True)
    advice = models.CharField(max_length=511)

    class Meta:
        db_table = 'order_document'
        verbose_name = 'Документ по заказу'
        verbose_name_plural = 'Документы по заказам'


class PaymentMethod(models.Model):
    payment_date = models.DateTimeField()
    status = models.BooleanField(default=False)
    total_sum = models.DecimalField(max_digits=8, decimal_places=2)
    transaction_number = models.CharField(max_length=511)

    class Meta:
        db_table = 'payment_method'
        verbose_name = 'Метод Оплаты'
        verbose_name_plural = 'Методы Оплаты'


class Employee(models.Model):
    first_name = models.CharField(max_length=127)
    middle_name = models.CharField(max_length=127, null=True)
    last_name = models.CharField(max_length=127)
    phone = models.CharField(max_length=12)
    salary = models.DecimalField(max_digits=8, decimal_places=2)
    age = models.PositiveIntegerField()
    degree = models.CharField(max_length=127)
    email = models.CharField(max_length=127)
    sex = models.CharField(max_length=127)

    class Meta:
        db_table = 'employee'
        verbose_name = 'Сотрудник'
        verbose_name_plural = 'Сотрудники'
