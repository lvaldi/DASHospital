from django.shortcuts import render

from .models import *
from django.views import View
from WeeklySchedule.models import *
from django.db import connection


# Create your views here.
class nurse_detail_view(View):
	# userid = request.user.id
	# nurse = Nurse.objects.get(id=userid)
	template_name = "Nurse/detail.html"
	def get(self, request, id, *args, **kwargs):
		# nurse = Nurse.objects.raw('SELECT * FROM "nurse" WHERE ID = %s', [id])[0]
		# nurse = Nurse.objects.get(id=1030)
		# nurseStaff = nurse.id
		# nurseset = Nurse.objects.filter(id=1030)
		# print(nurseset.query)
		nurse = connection.cursor().execute('SELECT "nurse"."id", "nurse"."did" FROM "nurse" WHERE "nurse"."id" = 1030')
		nurseStaff = connection.cursor().execute('SELECT * FROM "staff" WHERE "staff"."id" = 1030')
		# connection.cursor().execute('SELECT * FROM "nurse" WHERE "nurse"."id" = 1030')
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
	
		return render(request,self.template_name,context)

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
	appointmentlists= Appointment.objects.filter(did = specialistStaff.id)
	nurseids = Nurse.objects.filter(did = specialistStaff.id).values_list('id', flat = True)
	nurseList = Staff.objects.filter(id__in=nurseids)
	prescriptions = Treats.objects.filter(did = specialistStaff.id).values_list('prescriptionid',flat=True)


	context = {
		'doctor': specialistStaff,
		'availableforemergency': avalibleforemergency,
		'type': 'Specialist',
		'special': special,
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
	prescriptions = Treats.objects.filter(did = gpStaff.id).values_list('prescriptionid',flat=True)
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
