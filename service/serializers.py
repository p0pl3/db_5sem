from django.contrib.auth.hashers import make_password
from rest_framework.serializers import ModelSerializer
from .models import *


class ClientTransportSerializer(ModelSerializer):
    class Meta:
        model = UserTransport
        fields = '__all__'


class ClientSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

    def create(self, validated_data):
        user = User.objects.create(
            username=validated_data['username']
        )
        user.set_password(validated_data['password'])
        user.save()
        return user


class HangarSerializer(ModelSerializer):
    class Meta:
        model = WorkStation
        fields = '__all__'


class StatusMaintenanceSerializer(ModelSerializer):
    class Meta:
        model = StatusOrder
        fields = '__all__'


class PartSerializer(ModelSerializer):
    class Meta:
        model = Detail
        fields = '__all__'


class WorkPartSerializer(ModelSerializer):
    class Meta:
        model = OrderDetail
        fields = '__all__'



class PrimaryDiagnosisSerializer(ModelSerializer):
    class Meta:
        model = Malfunction
        fields = '__all__'


class RepairDocumentSerializer(ModelSerializer):
    class Meta:
        model = OrderDocument
        fields = '__all__'


class PaymentMethodSerializer(ModelSerializer):
    class Meta:
        model = PaymentMethod
        fields = '__all__'


class RepairerSerializer(ModelSerializer):
    class Meta:
        model = Employee
        fields = '__all__'

class MaintenanceSerializer(ModelSerializer):
    client_transport = ClientTransportSerializer()
    status_maintenance = StatusMaintenanceSerializer()
    hangar = HangarSerializer()
    repair_document = RepairDocumentSerializer()
    primary_diagnosis = PrimaryDiagnosisSerializer()
    repairer = RepairerSerializer(many=True)

    class Meta:
        model = Order
        fields = '__all__'
