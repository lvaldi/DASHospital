from django.shortcuts import render
from django.http import HttpResponseRedirect
from .models import *
from django.views import View
from Staff.models import *
from django.db import connection
from .forms import *
import collections

class patient_login_view(View):
	template_name = "Patient/login.html"
	def get(self, request, *args, **kwargs):

		context = {
			}
		if request.GET.get('pid', ''):
			return HttpResponseRedirect('%s/detail/' % request.GET.get('pid', ''))
		return render(request,self.template_name,context)

class patient_detail_view(View):
	template_name = "Patient/detail.html"
	def get(self, request, id, *args, **kwargs):
		patient = Patient.objects.raw('SELECT * FROM "patient" WHERE "patient"."id" = %s',[id])[0]
		appointments = Appointment.objects.raw('SELECT * FROM "doctor", "appointment", "patient", "Books", "facility" WHERE "doctor"."id" = "appointment"."did" AND "appointment"."pid" = "patient"."id" AND "doctor"."id" = %s AND "appointment"."appointmentid" = "Books"."AppointmentID" AND "Books"."FID" = "facility"."id"',[id])
		# doctorStaff = Staff.objects.raw('SELECT * FROM "staff", "doctor" WHERE "staff"."id"="doctor"."id" AND "staff"."id" = %s',[appointment.did])[0]
		prescriptions = Treats.objects.raw('SELECT * FROM "prescription", "treats", "patient", "contains", "medicine" WHERE "prescription"."prescriptionid" = "treats"."prescriptionid" AND "treats"."pid" = "patient"."id" AND "patient"."id" = %s AND "prescription"."prescriptionid" = "contains"."prescriptionid" AND "contains"."din" = "medicine"."din"', [id])
		context = {
			'patient': patient,
			'appointments': appointments,
			'prescriptionsreceived': prescriptions
			}
		return render(request,self.template_name,context)


class patient_update_view(View):
	template_name = "Patient/update.html"
	def get_object(self):
		id = self.kwargs.get("id")
		obj = Patient.objects.raw('SELECT * FROM "patient" WHERE "id" = %s', [id])[0]
		return obj

	def get(self, request, id, *args, **kwargs):
		context = {}
		obj = self.get_object()
		form = PatientModelForm(instance=obj)
		context ['obj'] = obj
		context ['form'] = form
		return render(request, self.template_name, context)

	def post(self, request, id, *args, **kwargs):
		obj = self.get_object()
		context = {}
		form = PatientModelForm(request.POST, instance=obj)
		if form.is_valid():
			data = form.cleaned_data
			name = data.get('name')
			email = data.get('email')
			phone = data.get('phone')
			healthcard = data.get('healthcard')
			connection.cursor().execute('UPDATE "patient" SET "name" = %s , "email" = %s , "healthcard" = %s , "phone" = %s WHERE "id" = %s',(name,email,healthcard,phone,id))
		context ['obj'] = obj
		context ['form'] = form
		return render(request,self.template_name,context)

class patient_create_view(View):
	template_name = "Patient/create.html"
	def get(self, request, *args, **kwargs):
		form = PatientRegisterForm()
		context = {"form": form}
		return render(request, self.template_name, context)

	def post(self, request, *args,**kwargs):
		form = PatientRegisterForm(request.POST)
		if form.is_valid():
			data = form.cleaned_data
			name = data.get('name')
			email = data.get('email')
			phone = data.get('phone')
			healthcard = data.get('healthcard')
			connection.cursor().execute('INSERT into "patient"("email","name","healthcard","phone") values(%s,%s,%s,%s)',(email,name,healthcard,phone))
		context = {"form": form}
		return render(request,self.template_name,context)

class doctor_availble_for_emergency_view(View):
	template_name = "Doctor/availableforemergency.html"
	def get(self, request, *args, **kwargs):
		context = {}
		c = connection.cursor()
		c.execute('CREATE OR REPLACE VIEW AllAVAILABLE AS SELECT "doctor"."id", "staff"."name", "doctor"."availableforemergency", "staff"."email", "staff"."phone" FROM "doctor", "staff" WHERE "doctor"."id" = "staff"."id" AND "doctor"."availableforemergency" = TRUE')
		c.execute('SELECT "id", "name" FROM AllAVAILABLE')
		ComplaintRecord = collections.namedtuple('ComplaintRecord', 'id, name')
		context['list'] = map(ComplaintRecord._make, c.fetchall())
		return render(request,self.template_name,context)

class doctor_availble_for_emergency_view_phone(View):
	template_name = "Doctor/availableforemergencyphone.html"
	def get(self, request, *args, **kwargs):
		context = {}
		c = connection.cursor()
		c.execute('CREATE OR REPLACE VIEW AllAVAILABLE AS SELECT "doctor"."id", "staff"."name", "doctor"."availableforemergency", "staff"."email", "staff"."phone" FROM "doctor", "staff" WHERE "doctor"."id" = "staff"."id" AND "doctor"."availableforemergency" = TRUE')
		c.execute('SELECT "id", "name", "phone" FROM AllAVAILABLE')
		ComplaintRecord = collections.namedtuple('ComplaintRecord', 'id, name, phone')
		context['list'] = map(ComplaintRecord._make, c.fetchall())
		return render(request,self.template_name,context)


class patient_account_information_view(View):
	template_name = "Patient/information.html"
	def get(self, request, id, *args, **kwargs):
		patient = Patient.objects.raw('SELECT * FROM "patient" WHERE "patient"."id" = %s',[id])[0]
		context = {
			'patient': patient,
		}
		return render(request, self.template_name, context)
