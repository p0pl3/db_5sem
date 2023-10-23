



list = ['ClientTransport', 'Client', 'Hangar', 'StatusMaintenance', 'Part', 'WorkPart', 'Maintenance', 'PrimaryDiagnosis', 'RepairDocument', 'PaymentMethod', 'Repairer']


for i in list:
#     print(f'''
# class {i}ViewSet(ModelViewSet):
#     queryset = {i}.objects.all()
#     serializer_class = {i}Serializer
#     ''')

#     print(f'''
# class {i}Serializer(ModelSerializer):
#     class Meta:
#         model = {i}
#         fields = '__all__'
# ''')


    print(f'''
    router.register(r'', {i}ViewSet, basename='{i.lower()}')
    ''')