"""DASHospital URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from pages.views import sign_in_view
#create_patient_view
from Staff.views import nurse_detail_view, lab_technician_detail_view
# from WeeklySchedule.views import ScheduledTime_create_view, ScheduledTime_update_view
from pages.views import sign_in_view, create_user_view
<<<<<<< HEAD
from Staff.views import nurse_detail_view, lab_technician_detail_view, specialist_detail_view, gp_detail_view, stat_view
=======
from Staff.views import doctor_login_view, nurse_detail_view, nurse_login_view,lab_technician_detail_view, lab_technician_login_view, specialist_detail_view, gp_detail_view, stat_view
>>>>>>> d1066c9588981e9dccf8e7e5eca3048363b835b7
from WeeklySchedule.views import ScheduledTime_create_view, ScheduledTime_update_view,ScheduledTime_list_view, ScheduledTime_delete_view
from Patient.views import patient_detail_view, patient_create_view, patient_update_view, doctor_availble_for_emergency_view, doctor_availble_for_emergency_view_phone


urlpatterns = [
    path('', sign_in_view, name='home'),
    # path('createPatient/', create_patient),
    # path('main/', profile),
    # path('information/', account_information),
    path('Nurse/<int:id>/detail/', nurse_detail_view.as_view()),
    path('admin/', admin.site.urls),
    path('LabTechnician/<int:id>/detail/', lab_technician_detail_view.as_view()),
    path('LabTechnician/', lab_technician_login_view.as_view()),
    path('Doctor/', doctor_login_view.as_view()),
    path('Specialist/<int:id>/detail/', specialist_detail_view.as_view()),
    path('GP/<int:id>/detail/', gp_detail_view.as_view()),
    # path('schedule/<int:wid>/create/', ScheduledTime_create_view.as_view(), name = 'schedule-create')

    path('schedule/<str:wid>/create/', ScheduledTime_create_view.as_view(), name = 'schedule-create'),
    path('schedule/<str:wid>/list/', ScheduledTime_list_view.as_view(), name = 'schedule-list'),
    path('schedule/<str:wid>/<str:date>/<str:starttime>/<str:endtime>/update/',ScheduledTime_update_view.as_view()),
    path('schedule/<str:wid>/<str:date>/<str:starttime>/<str:endtime>/delete/',ScheduledTime_delete_view.as_view()),

    path('Patient/create/', patient_create_view.as_view(),name = 'patient-create'),
    path('Patient/<int:id>/detail/', patient_detail_view.as_view()),
    path('Patient/<int:id>/update/', patient_update_view.as_view()),
    path('Doctor/emergency/', doctor_availble_for_emergency_view.as_view()),
    path('Doctor/emergency/phone/', doctor_availble_for_emergency_view_phone.as_view()),
    path('Doctor/stat/', stat_view.as_view())



]
