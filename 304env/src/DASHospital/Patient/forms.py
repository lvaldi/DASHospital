from django import forms

from .models import Patient

class PatientRegisterForm(forms.Form):
	name = forms.CharField()
	email = forms.CharField()
	phone = forms.CharField()
	healthcard = forms.CharField()

class PatientModelForm(forms.ModelForm):
	class Meta:
		model = Patient
		fields = [
		'id',
		'name',
		'email',
		'phone',
		'healthcard'
		]
	
