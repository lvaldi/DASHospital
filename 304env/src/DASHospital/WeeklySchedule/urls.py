from django.urls import path
from WeeklySchedule.views import ScheduledTime_create_view, ScheduledTime_update_view

app_name = 'WeeklySchedule'
urlpatterns = [
    path('schedule/<int:wid>/create/', ScheduledTime_create_view.as_view(), name = 'schedule-create')
]