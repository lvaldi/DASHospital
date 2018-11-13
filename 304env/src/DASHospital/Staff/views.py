from django.shortcuts import render

from .models import *
from WeeklySchedule.models import *


# Create your views here.
def nurse_detail_view(request):
	nurse = Nurse.objects.get(id=1020)
	nurseStaff = Staff.objects.get(id=nurse.id.id)
	schedule = Weeklyschedule.objects.get(sid=nurse.id.id)
	scheduletimeset = ScheduledTime.objects.filter(wid = schedule.id)

	print(nurse)
	print(nurseStaff.name)

	context = {
		'nurse': nurseStaff,
		'scheduleslist': scheduletimeset
	}
	
	return render(request,"Nurse/detail.html",context)