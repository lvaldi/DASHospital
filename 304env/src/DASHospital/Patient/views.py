from django.shortcuts import render

from .models import *
from django.views import View
from Staff.models import *
from django.db import connection
from .forms import *

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

'''
# Create your views here.
def create_patient(request):
	return render(request,"Patient/register.html", {})

def profile(request):
    return render(request,"Patient/profile.html", {})


def account_information(request):
    # patient_id = request.user.id
    # patient = Patient.objects.get(id=userid)
    patient = Patient.objects.get(id=100000)
    patient_id = patient.id
    patient_email = patient.email
    patient_name = patient.name
    patient_healthcard = patient.healthcard
    patient_phone = patient.phone

    context = {
        'patient': patient
    }

    return render(request,"Patient/information.html", context)
'''