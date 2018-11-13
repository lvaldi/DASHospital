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

def lab_technician_detail_view(request):
	# userid = request.user.id
	# lt = LabTechnician.objects.get(id=userid)
	lt = LabTechnician.objects.get(id=1042)
	ltStaff = lt.id
	schedule = Weeklyschedule.objects.get(sid=ltStaff.id)
	scheduletimeset = ScheduledTime.objects.filter(wid = schedule.id)
	facility = lt.fid
	appids= Books.objects.filter(fid = facility.id).values_list('appointmentid',flat = True)
	appointmentlists = Appointment.objects.filter(appointmentid__in =appids)

	context = {
		'lt' : ltStaff,
		'scheduleslist': scheduletimeset,
		'facility': facility,
		'appointmentlists': appointmentlists
	}
	return render(request,"LabTechnician/detail.html",context)
