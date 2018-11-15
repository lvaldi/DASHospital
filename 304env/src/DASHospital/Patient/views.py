from django.shortcuts import render

from .models import *
from django.views import View
from Staff.models import *
from django.db import connection
from .forms import *
import collections

class patient_detail_view(View):
	template_name = "Patient/detail.html"
	def get(self, request, id, *args, **kwargs):
		patient = Patient.objects.raw('SELECT * FROM "patient" WHERE "patient"."id" = %s',[id])[0]
		appointments = Appointment.objects.raw('SELECT * FROM "appointment", "doctor", "staff" WHERE  "appointment"."did" = "doctor"."id" AND "doctor"."id" = "staff"."id" AND "appointment"."pid" = %s ', [id])
		# doctorStaff = Staff.objects.raw('SELECT * FROM "staff", "doctor" WHERE "staff"."id"="doctor"."id" AND "staff"."id" = %s',[appointment.did])[0]
		context = {
			'patient': patient,
			'appointments': appointments
			}
		return render(request,self.template_name,context)


class patient_update_view(View):
	template_name = "Patient/update.html"

class patient_create_view(View):
	template_name = "Patient/create.html"
	def get(self, request, *args, **kwargs):
		form = PatientRegisterForm()
		context = {"form": form}
		return render(request, self.template_name, context)

	def post(self, request, *args,**kwargs):
		print(request.POST)
		form = PatientRegisterForm(request.POST)
		print(form.is_valid())
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
