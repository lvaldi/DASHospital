from django.shortcuts import render

from .models import *
from django.views import views
from Staff.models import *
from django.db import connection

class patient_detail_view(View):
    template_name = "Patient/detail.html"
    def get(self, request, id, *args, **kwargs):
		patient = Patient.objects.raw('SELECT * FROM "patient" WHERE "patient"."id" = %s',[id])[0]
		appointment = Appointment.objects.raw('SELECT * FROM "appointment" WHERE "patient"."id" = "appointment"."pid" AND "patient"."id" = %s', [id])
		doctorStaff = Staff.objects.raw('SELECT * FROM "staff", "doctor" WHERE "staff"."id"="doctor"."id" AND "staff"."id" = %s',[appointment.did])[0]
		context = {
			'patient': patient,
			'appointment': appointment,
			'doctor': doctorStaff
			}
	
		return render(request,self.template_name,context)

class patient_create_view(View):
    template_name = "Patient/create.html"
	def get(self, request, id, *args, **kwargs):
		form = ScheduledTimeForm()
		context = {"form": form,
					"id": id}
		return render(request,self.template_name, context)

    def post(self,request,id,*args,**kwargs):
		form = ScheduledTimeForm(request.POST)
		if form.is_valid():
			data = form.cleaned_data
			name = data.get('name')
			email = data.get('email')
			phone = data.get('phone')
			healthcard = data.get('healthcard')
			connection.cursor().execute('INSERT into "patient" values(%s,%s,%s,%s)',(email,name,healthcard,phone))
		context = {"form": form,
					"wid": wid}
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