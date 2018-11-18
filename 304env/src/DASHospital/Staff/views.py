from django.shortcuts import render
from django.http import HttpResponseRedirect
from .models import *
from django.views import View
from WeeklySchedule.models import *
from django.db import connection
import collections
from .forms import AppointmentTimeForm, AppointmentTimeModelForm


# Create your views here.
class nurse_detail_view(View):
	template_name = "Nurse/detail.html"
	def get(self, request, id, *args, **kwargs):
		nurseStaff = Staff.objects.raw('SELECT * FROM "staff", "nurse" WHERE "staff"."id"="nurse"."id" AND "staff"."id" = %s',[id])[0]
		scheduletimeset = Weeklyschedule.objects.raw('SELECT * FROM "staff", "weeklyschedule", "scheduled_time" WHERE "staff"."id" = "weeklyschedule"."sid" AND "scheduled_time"."wid" = "weeklyschedule"."id" AND "staff"."id" = %s', [id])
		doctorStaff = Staff.objects.raw('SELECT * FROM "staff", "doctor" WHERE "staff"."id"="doctor"."id" AND "staff"."id" = %s',[nurseStaff.did])[0]
		doctorAppointmentList = Nurse.objects.raw('SELECT * FROM "nurse", "doctor", "appointment" WHERE "nurse"."did" = "doctor"."id" AND "doctor"."id" = "appointment"."did" AND "nurse"."id" = %s', [id])
		context = {
			'nurse': nurseStaff,
			'scheduleslist': scheduletimeset,
			'doctor': doctorStaff,
			'appointmentlists' : doctorAppointmentList
			}

		return render(request,self.template_name,context)

class nurse_login_view(View):
	template_name = "Nurse/login.html"
	def get(self, request, *args, **kwargs):

		context = {
			}
		if request.GET.get('nid', ''):
			return HttpResponseRedirect('%s/detail/' % request.GET.get('nid', ''))
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

class lab_technician_login_view(View):
	template_name = "LabTechnician/login.html"
	def get(self, request, *args, **kwargs):

		context = {
			}
		if request.GET.get('lid', ''):
			return HttpResponseRedirect('%s/detail/' % request.GET.get('lid', ''))
		return render(request,self.template_name,context)

class doctor_login_view(View):
	template_name = "Doctor/login.html"
	def get(self, request, *args, **kwargs):

		context = {
			}
		print(request.GET.get('type', ''))
		if request.GET.get('did', ''):
			if request.GET.get('type', '') == "GP":
				return HttpResponseRedirect('/GP/%s/detail/' % request.GET.get('did', ''))
			elif request.GET.get('type', '') == "SPEC":
				return HttpResponseRedirect('/Specialist/%s/detail/' % request.GET.get('did', ''))
		return render(request,self.template_name,context)

class specialist_detail_view(View):
	template_name = "Doctor/detail.html"
	def get(self, request, id, *args, **kwargs):
		specialistStaff = Staff.objects.raw('SELECT * FROM "staff", "doctor" WHERE "staff"."id"="doctor"."id"AND "staff"."id" = %s',[id])[0]
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
		prescriptions = Treats.objects.raw('SELECT * FROM "prescription", "treats", "doctor", "contains", "medicine" WHERE "prescription"."prescriptionid" = "treats"."prescriptionid" AND "treats"."did" = "doctor"."id" AND "doctor"."id" = %s AND "prescription"."prescriptionid" = "contains"."prescriptionid" AND "contains"."din" = "medicine"."din"', [id])
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

class Appointment_delete_view(View):
	template_name = "Appointment/delete.html"
	form_class = AppointmentTimeModelForm
	def get_object(self):
		date = self.kwargs.get("date")
		date_ = datetime.strptime(date, '%Y-%m-%d').date()
		time = self.kwargs.get("time")
		#t = datetime.strptime(starttime, '%X').time()
		appointmentid = self.kwargs.get("appointmentid")
		did = self.kwargs.get("did")
		pid = self.kwargs.get("pid")
		obj = Appointment.objects.raw('SELECT * FROM "appointment" WHERE "appointment"."appointmentid" = %s',(appointmentid))
		return obj[0]

	def get(self, request, id, *args, **kwargs):
		context = {}
		obj = self.get_object()
		if obj is not None:
			context['obj']=obj
		return render(request,self.template_name, context)

	def post(self,request, id, *args,**kwargs):
		date = self.kwargs.get("date")
		date_ = datetime.strptime(date, '%Y-%m-%d').date()
		time = self.kwargs.get("time")
		t = datetime.strptime(time, '%X').time()
		appointmentid = self.kwargs.get("appointmentid")
		did = self.kwargs.get("did")
		pid = self.kwargs.get("pid")
		str ="../../"
		context = {}
		obj = self.get_object()
		if obj is not None:
			context['obj'] = None
			connection.cursor().execute('DELETE FROM "appointment" WHERE "appointment"."appointmentid" = %s',(appointmentid))
			return redirect(str)
		return render(request,self.template_name,context)
class gp_account_information_view(View):
	template_name = "Doctor/information.html"
	def get(self, request, id, *args, **kwargs):
		gpStaff = Staff.objects.raw('SELECT * FROM "staff", "doctor" WHERE "staff"."id"="doctor"."id" AND "staff"."id" = %s',[id])[0]
		avalibleforemergency = gpStaff.availableforemergency
		context = {
			'doctor': gpStaff,
			'availableforemergency': avalibleforemergency,
			'type': 'General Practitioner',
		}
		return render(request, self.template_name, context)


class specialist_account_information_view(View):
	template_name = "Doctor/information.html"
	def get(self, request, id, *args, **kwargs):
		specialistStaff = Staff.objects.raw('SELECT * FROM "staff", "doctor", "specialist" WHERE "staff"."id"="doctor"."id" AND "staff"."id" = %s AND "doctor"."id" = "specialist"."id"',[id])[0]
		avalibleforemergency = specialistStaff.availableforemergency
		context = {
			'doctor': specialistStaff,
			'availableforemergency': avalibleforemergency,
			'type': 'Specialist',
		}
		return render(request, self.template_name, context)


class nurse_account_information_view(View):
	template_name = "Nurse/information.html"
	def get(self, request, id, *args, **kwargs):
		nurseStaff = Staff.objects.raw('SELECT * FROM "staff", "nurse" WHERE "staff"."id"="nurse"."id" AND "staff"."id" = %s',[id])[0]
		context = {
			'nurse': nurseStaff,
		}
		return render(request,self.template_name, context)


class lab_technician_account_information_view(View):
	template_name = "LabTechnician/information.html"
	def get(self, request, id, *args, **kwargs):
		ltStaff = Staff.objects.raw('SELECT * FROM "staff", "lab_technician" WHERE "staff"."id"="lab_technician"."id" AND "staff"."id" = %s',[id])[0]
		context = {
			'lt' : ltStaff,
		}
		return render(request,self.template_name, context)
