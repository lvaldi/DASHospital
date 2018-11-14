from django.shortcuts import render

from .models import *

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
