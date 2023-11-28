from rest_framework import permissions
from rest_framework.viewsets import ModelViewSet
from rest_framework.views import APIView
from .serializers import *

from django_filters import rest_framework as filters


class UserPermission(permissions.BasePermission):

    def has_permission(self, request, view):
        if not request.user.is_authenticated:
            return False
        if view.action in ['retrieve', 'list']:
            return True
        elif view.action in ['update', 'partial_update', 'destroy', 'create'] and request.user.is_superuser:
            return True
        else:
            return False


class IsAdmin(permissions.BasePermission):
    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.is_superuser


class IsOwner(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.user_transport.user == request.user


class ClientTransportFilter(filters.FilterSet):
    class Meta:
        model = UserTransport
        fields = '__all__'


class HangarFilter(filters.FilterSet):
    class Meta:
        model = WorkStation
        fields = '__all__'


class MaintenanceFilter(filters.FilterSet):
    class Meta:
        model = Order
        fields = '__all__'


class PaymentMethodFilter(filters.FilterSet):
    class Meta:
        model = PaymentMethod
        fields = {
            "total_sum": ['exact', 'gte', 'lte'],
        }


class DetailFilter(filters.FilterSet):
    class Meta:
        model = Detail
        fields = {
            "name": ['exact'],
            "price": ['exact', 'gte', 'lte'],
        }


class EmployeeFilter(filters.FilterSet):
    class Meta:
        model = Employee
        fields = {
            "age": ['exact', 'gte', 'lte'],
            "degree": ['exact'],
            "sex": ['exact'],
        }


class ClientTransportViewSet(ModelViewSet):
    queryset = UserTransport.objects.all()
    serializer_class = ClientTransportSerializer
    filterset_class = ClientTransportFilter
    # permission_classes = (IsAdmin,)


class UserViewSet(ModelViewSet):
    queryset = User.objects.all()
    serializer_class = ClientSerializer
    # permission_classes = (IsAdmin,)


class HangarViewSet(ModelViewSet):
    queryset = WorkStation.objects.all()
    serializer_class = HangarSerializer
    # permission_classes = (IsAdmin,)
    filterset_class = HangarFilter


class StatusMaintenanceViewSet(ModelViewSet):
    queryset = StatusOrder.objects.all()
    serializer_class = StatusMaintenanceSerializer
    # permission_classes = (IsAdmin,)


class PartViewSet(ModelViewSet):
    queryset = Detail.objects.all()
    serializer_class = PartSerializer
    filterset_class = DetailFilter

    # permission_classes = (IsAdmin,)


class WorkPartViewSet(ModelViewSet):
    queryset = OrderDetail.objects.all()
    serializer_class = WorkPartSerializer
    # filterset_class = DetailFilter
    # permission_classes = (IsAdmin,)


class MaintenanceViewSet(ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = MaintenanceSerializer
    filterset_class = MaintenanceFilter

    # permission_classes = (UserPermission,)

    def get_queryset(self):
        if self.request.user.is_superuser:
            return self.queryset
        return self.queryset.filter(user_transport__user=self.request.user)


class PrimaryDiagnosisViewSet(ModelViewSet):
    queryset = Malfunction.objects.all()
    serializer_class = PrimaryDiagnosisSerializer
    # permission_classes = (IsAdmin,)


class RepairDocumentViewSet(ModelViewSet):
    queryset = OrderDocument.objects.all()
    serializer_class = RepairDocumentSerializer
    # permission_classes = (IsAdmin,)


class PaymentMethodViewSet(ModelViewSet):
    queryset = PaymentMethod.objects.all()
    serializer_class = PaymentMethodSerializer
    filterset_class = PaymentMethodFilter

    # permission_classes = (IsAdmin,)


class RepairerViewSet(ModelViewSet):
    queryset = Employee.objects.all()
    serializer_class = RepairerSerializer
    filterset_class = EmployeeFilter
    # permission_classes = (IsAdmin,)


class get_top_1_spending_customerViewSet(APIView):
    def get(self, request):
        from django.db import connection
        from django.http import JsonResponse
        with connection.cursor() as cursor:
            cursor.execute("select get_top_1_spending_customer();")
            row = cursor.fetchone()
        print(row)
        return JsonResponse({'res': row})


class get_top_3_expensive_orderViewSet(APIView):
    def get(self, request):
        from django.db import connection
        from django.http import JsonResponse
        with connection.cursor() as cursor:
            cursor.execute("select get_top_3_expensive_order();")
            row = cursor.fetchone()
        print(row)
        return JsonResponse({'res': row})


from rest_framework import serializers


class AirModelSerializer(serializers.Serializer):
    model = serializers.CharField(max_length=200)


from drf_spectacular.utils import extend_schema, OpenApiParameter, OpenApiExample
from drf_spectacular.types import OpenApiTypes


class get_count_crashed_by_modelViewSet(APIView):
    @extend_schema(
        request=AirModelSerializer,
        responses={204: None},
        methods=["POST"]
    )
    def post(self, request):
        import json
        data = json.loads(request.body.decode('utf-8'))
        from django.db import connection
        from django.http import JsonResponse
        with connection.cursor() as cursor:
            cursor.execute(f"select get_count_crashed_by_model('{data['model']}');")
            row = cursor.fetchone()
        print(row)
        return JsonResponse({'res': row})


class update_overdue_orderViewSet(APIView):
    def get(self, request):
        from django.db import connection
        from django.http import JsonResponse
        with connection.cursor() as cursor:
            cursor.execute("select update_overdue_order();")
            row = cursor.fetchone()
        print(row)
        return JsonResponse({'status': True})


class remove_old_orderViewSet(APIView):
    def get(self, request):
        from django.db import connection
        from django.http import JsonResponse
        with connection.cursor() as cursor:
            cursor.execute("select remove_old_order();")
            row = cursor.fetchone()
        print(row)
        return JsonResponse({'status': True})
