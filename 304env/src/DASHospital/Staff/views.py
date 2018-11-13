from django.shortcuts import render

from .models import *
from WeeklySchedule.models import *


# Create your views here.
def nurse_detail_view(request):
	# userid = request.user.id
	# nurse = Nurse.objects.get(id=userid)
	nurse = Nurse.objects.get(id=1030)
	nurseStaff = nurse.id
	schedule = Weeklyschedule.objects.get(sid=nurseStaff.id)
	scheduletimeset = ScheduledTime.objects.filter(wid = schedule.id)
	doctor = nurse.did
	doctorStaff = doctor.id
	# dschedule = Weeklyschedule.objects.get(sid=doctorStaff.id)
	# doctorschedulelist = ScheduledTime.objects.filter(wid=dschedule.id)


	context = {
		'nurse': nurseStaff,
		'scheduleslist': scheduletimeset,
		'doctor': doctorStaff
		
	}
	
	return render(request,"Nurse/detail.html",context)