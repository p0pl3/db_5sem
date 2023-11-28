from django.urls import include, path
from rest_framework.routers import DefaultRouter
from .views import *

router = DefaultRouter()
router.register(r'client_transport', ClientTransportViewSet, basename='clienttransport')
router.register(r'user', UserViewSet, basename='client')
router.register(r'hangar', HangarViewSet, basename='hangar')
router.register(r'status_maintenance', StatusMaintenanceViewSet, basename='statusmaintenance')
router.register(r'part', PartViewSet, basename='part')
router.register(r'work_part', WorkPartViewSet, basename='workpart')
router.register(r'maintenance', MaintenanceViewSet, basename='maintenance')
router.register(r'primary_diagnosis', PrimaryDiagnosisViewSet, basename='primarydiagnosis')
router.register(r'repair_docdument', RepairDocumentViewSet, basename='repairdocument')
router.register(r'payment_method', PaymentMethodViewSet, basename='paymentmethod')
router.register(r'repairer', RepairerViewSet, basename='repairer')

urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('get_top_1_spending_customer/', get_top_1_spending_customerViewSet.as_view()),
    path('get_top_3_expensive_order/', get_top_3_expensive_orderViewSet.as_view()),
    path('get_count_crashed_by_model/', get_count_crashed_by_modelViewSet.as_view()),
    path('update_overdue_order/', update_overdue_orderViewSet.as_view()),
    path('remove_old_order/', remove_old_orderViewSet.as_view()),
]
