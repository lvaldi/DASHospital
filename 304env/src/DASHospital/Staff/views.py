from django.shortcuts import render

from .models import *
from django.views import View
from WeeklySchedule.models import *
from django.db import connection
import collections


# Create your views here.
class nurse_detail_view(View):
	template_name = "Nurse/detail.html"
	def get(self, request, id, *args, **kwargs):
		nurseStaff = Staff.objects.raw('SELECT * FROM "staff", "nurse" WHERE "staff"."id"="nurse"."id" AND "staff"."id" = %s',[id])[0]
		scheduletimeset = Weeklyschedule.objects.raw('SELECT * FROM "staff", "weeklyschedule", "scheduled_time" WHERE "staff"."id" = "weeklyschedule"."sid" AND "scheduled_time"."wid" = "weeklyschedule"."id" AND "staff"."id" = %s', [id])
		doctorStaff = Staff.objects.raw('SELECT * FROM "staff", "doctor" WHERE "staff"."id"="doctor"."id" AND "staff"."id" = %s',[nurseStaff.did])[0]
		context = {
			'nurse': nurseStaff,
			'scheduleslist': scheduletimeset,
			'doctor': doctorStaff
			}
	
		return render(request,self.template_name,context)

class lab_technician_detail_view(View):
	template_name = "LabTechnician/detail.html"
	def get(self, request, id, *args, **kwargs):
		ltStaff = Staff.objects.raw('SELECT * FROM "staff", "lab_technician" WHERE "staff"."id"="lab_technician"."id" AND "staff"."id" = %s',[id])[0]
	
		scheduletimeset = Weeklyschedule.objects.raw('SELECT * FROM "staff", "weeklyschedule", "scheduled_time" WHERE "staff"."id" = "weeklyschedule"."sid" AND "scheduled_time"."wid" = "weeklyschedule"."id" AND "staff"."id" = %s', [id])
		facility= Facility.objects.get(id = ltStaff.fid)
		# facility = Facility.objects.raw('SELECT * FROM "facility" WHERE "facility"."id" = %s' %ltStaff.fid)[0]
	# I use get method since raw select query doesn't work because of migration issue.	
		# appointmentlists = Appointment.objects.raw('SELECT * FROM "facility", "Books", "appointment" WHERE "facility"."id" = "Books"."FID" AND "Books"."AppointmentID" = "appointment"."appointmentid" AND "facility"."id" = %s' %facility.id)
		appointmentids = Books.objects.filter(fid=facility.id).values_list('appointmentid',flat = True)
		appointmentlists = Appointment.objects.filter(appointmentid__in = appointmentids)

		context = {
			'lt' : ltStaff,
			'scheduleslist': scheduletimeset,
			'facility': facility,
			'appointmentlists': appointmentlists
		}
		return render(request,self.template_name,context)
class specialist_detail_view(View):
	template_name = "Doctor/detail.html"
	def get(self, request, id, *args, **kwargs):
		specialistStaff = Staff.objects.raw('SELECT * FROM "staff", "doctor" WHERE "staff"."id"="doctor"."id" AND "staff"."id" = %s',[id])[0]
		special = Specialist.objects.raw('SELECT * FROM "specialist" WHERE "specialist"."id" = %s', [specialistStaff.id])
		avalibleforemergency = specialistStaff.availableforemergency
		scheduletimeset = Weeklyschedule.objects.raw('SELECT * FROM "staff", "weeklyschedule", "scheduled_time" WHERE "staff"."id" = "weeklyschedule"."sid" AND "scheduled_time"."wid" = "weeklyschedule"."id" AND "staff"."id" = %s', [id])
		appointmentlists = Appointment.objects.raw('SELECT * FROM "doctor", "appointment" WHERE "doctor"."id" = "appointment"."did" AND "doctor"."id" = %s',[id])
		# appointmentlists= Appointment.objects.filter(did = specialistStaff.id)
		nurseList = Staff.objects.raw('SELECT * FROM "staff", "nurse" WHERE "staff"."id" = "nurse"."id" AND "nurse"."did" = %s',[id])
		prescriptions = Treats.objects.raw('SELECT * FROM "treats", "doctor" WHERE "treats"."did" = "doctor"."id" AND "doctor"."id" = %s', [id])
		# prescriptions = Treats.objects.filter(did = specialistStaff.id).values_list('prescriptionid',flat=True)


		context = {
			'doctor': specialistStaff,
			'availableforemergency': avalibleforemergency,
			'type': 'Specialist',
			'special': special,
			'scheduleslist': scheduletimeset,
			'appointmentlists' : appointmentlists,
			'nurses': nurseList,
			'prescriptionsgiven': prescriptions
		}
		return render(request, self.template_name, context)

class gp_detail_view(View):
	template_name = "Doctor/detail.html"
	def get(self, request, id, *args, **kwargs):	
		gpStaff = Staff.objects.raw('SELECT * FROM "staff", "doctor" WHERE "staff"."id"="doctor"."id" AND "staff"."id" = %s',[id])[0]
		avalibleforemergency = gpStaff.availableforemergency
		scheduletimeset = Weeklyschedule.objects.raw('SELECT * FROM "staff", "weeklyschedule", "scheduled_time" WHERE "staff"."id" = "weeklyschedule"."sid" AND "scheduled_time"."wid" = "weeklyschedule"."id" AND "staff"."id" = %s', [id])
		appointmentlists = Appointment.objects.raw('SELECT * FROM "doctor", "appointment" WHERE "doctor"."id" = "appointment"."did" AND "doctor"."id" = %s',[id])
		nurseList = Staff.objects.raw('SELECT * FROM "staff", "nurse" WHERE "staff"."id" = "nurse"."id" AND "nurse"."did" = %s',[id])
		prescriptions = Treats.objects.raw('SELECT * FROM "prescription", "treats", "doctor" WHERE "prescription"."prescriptionid" = "treats"."prescriptionid" AND "treats"."did" = "doctor"."id" AND "doctor"."id" = %s', [id])
		context = {
			'doctor': gpStaff,
			'availableforemergency': avalibleforemergency,
			'type': 'General Practitioner',
			'scheduleslist': scheduletimeset,
			'appointmentlists' : appointmentlists,
			'nurses': nurseList,
			'prescriptionsgiven': prescriptions
		}
		return render(request, self.template_name, context)

class stat_view(View):
	template_name = "Doctor/stat.html"
	def get(self, request, *args, **kwargs):
		c = connection.cursor()
		context = {}
		c.execute('SELECT "brand", count(*) as count FROM "contains", "medicine" WHERE "contains"."din" = "medicine"."din" group by "brand" order by count desc')
		ComplaintRecord = collections.namedtuple('ComplaintRecord', 'brand, count')
		context['bv'] = map(ComplaintRecord._make, c.fetchall())
		c.execute('SELECT ingredients, count(*) as count from contains, medicine where contains.din = medicine.din group by ingredients order by count desc')
		ComplaintRecord = collections.namedtuple('ComplaintRecord', 'ingredients, count')
		context['iv'] = map(ComplaintRecord._make, c.fetchall())
		c.execute('SELECT DISTINCT din FROM "contains" as sx WHERE NOT EXISTS ((SELECT p."prescriptionid" FROM "prescription" as p )EXCEPT(SELECT sp."prescriptionid" FROM contains as sp WHERE sp.din = sx.din ) )')
		ComplaintRecord = collections.namedtuple('ComplaintRecord', 'din')
		context['dv'] = map(ComplaintRecord._make, c.fetchall())
		return render(request, self.template_name, context)


