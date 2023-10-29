from rest_framework import permissions
from rest_framework.viewsets import ModelViewSet

from .serializers import *


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


class ClientTransportViewSet(ModelViewSet):
    queryset = UserTransport.objects.all()
    serializer_class = ClientTransportSerializer
    # permission_classes = (IsAdmin,)


class UserViewSet(ModelViewSet):
    queryset = User.objects.all()
    serializer_class = ClientSerializer
    permission_classes = (IsAdmin,)


class HangarViewSet(ModelViewSet):
    queryset = WorkStation.objects.all()
    serializer_class = HangarSerializer
    # permission_classes = (IsAdmin,)


class StatusMaintenanceViewSet(ModelViewSet):
    queryset = StatusOrder.objects.all()
    serializer_class = StatusMaintenanceSerializer
    # permission_classes = (IsAdmin,)


class PartViewSet(ModelViewSet):
    queryset = Detail.objects.all()
    serializer_class = PartSerializer
    # permission_classes = (IsAdmin,)


class WorkPartViewSet(ModelViewSet):
    queryset = OrderDetail.objects.all()
    serializer_class = WorkPartSerializer
    # permission_classes = (IsAdmin,)


class MaintenanceViewSet(ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = MaintenanceSerializer
    # permission_classes = (UserPermission,)

    def get_queryset(self):
        if self.request.user.is_superuser:
            return self.queryset
        return self.queryset.filter(client_transport__client=self.request.user)


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
    # permission_classes = (IsAdmin,)


class RepairerViewSet(ModelViewSet):
    queryset = Employee.objects.all()
    serializer_class = RepairerSerializer
    # permission_classes = (IsAdmin,)
