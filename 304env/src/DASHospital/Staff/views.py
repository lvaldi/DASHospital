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
def specialist_detail_view(request):
	userid = request.user.id
	#specialist = Specialist.objects.get(id=userid)
	specialist = Doctor.objects.get(id=1013)
	specialistStaff = specialist.id
	special = Specialist.objects.get(id= specialistStaff.id)
	avalibleforemergency = specialist.availableforemergency
	schedule = Weeklyschedule.objects.get(sid=specialistStaff.id)
	schduletimeset = ScheduledTime.objects.filter(wid = schedule.id)
	appids = Appointment.objects.filter(did = specialistStaff.id)
	nurseids = Nurse.objects.filter(did = specialistStaff.id).values_list('id', flat = True)
	nurseList = Staff.objects.filter(id__in=nurseids)
	prescriptions = Treats.objects.filter(did = specialistStaff.id)

	context = {
		'doctor': specialistStaff,
		'availableforemergency': avalibleforemergency,
		'type': 'Specialist',
		'specialization': special,
		'scheduleslist': schduletimeset,
		'appointmentlists' : appointmentlists,
		'nurses': nurseList,
		'prescriptionsgiven': prescriptions
	}
	return render(request, "Doctor/detail.html", context)

def gp_detail_view(request):
	userid = request.user.id
	#gp = Doctor.objects.get(id=userid)
	gp = Doctor.objects.get(id=1008)
	gpStaff = gp.id
	avalibleforemergency = gp.availableforemergency
	schedule = Weeklyschedule.objects.get(sid=gpStaff.id)
	schduletimeset = ScheduledTime.objects.filter(wid = schedule.id)
	appointmentlists = Appointment.objects.filter(did = gpStaff.id)
	nurseids = Nurse.objects.filter(did = gpStaff.id).values_list('id', flat = True)
	nurseList = Staff.objects.filter(id__in=nurseids)
	prescriptions = Treats.objects.filter(did = gpStaff.id)

	context = {
		'doctor': gpStaff,
		'availableforemergency': avalibleforemergency,
		'type': 'General Practitioner',
		'scheduleslist': schduletimeset,
		'appointmentlists' : appointmentlists,
		'nurses': nurseList,
		'prescriptionsgiven': prescriptions
	}
	return render(request, "Doctor/detail.html", context)
