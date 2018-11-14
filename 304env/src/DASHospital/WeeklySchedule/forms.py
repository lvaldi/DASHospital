from django import forms

from .models import Weeklyschedule, ScheduledTime

class WeeklyscheduleForm(forms.ModelForm):
	def __init__(self, *args, **kwargs):
		super(WeeklyscheduleForm, self).__init__(*args, **kwargs)
		self.fields['sid'].widget.attrs['readonly'] = True
	class Meta:
		model = Weeklyschedule
		fields = [
		'id',
		'sid'
		]

class ScheduledTimeForm(forms.Form):
	date = forms.DateField()
	starttime = forms.TimeField()
	endtime = forms.TimeField()
	notes = forms.CharField(required=False)

class ScheduledTimeModelForm(forms.ModelForm):
	class Meta:
		model = ScheduledTime
		fields = [
		'wid',
		'date',
		'starttime',
		'endtime',
		'notes'
		]
	
