from django import forms

from .models import Appointment

class AppointmentTimeForm(forms.Form):
	date = forms.DateField()
	time = forms.TimeField()

class AppointmentTimeModelForm(forms.ModelForm):
	class Meta:
		model = Appointment
		fields = [
		'appointmentid',
		'date',
		'time',
		'did',
		'pid'
		]
	
