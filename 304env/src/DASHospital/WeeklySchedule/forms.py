from django import forms

from .models import Weeklyschedule, ScheduledTime

class WeeklyscheduleForm(forms.ModelForm):
	class Meta:
		model = Weeklyschedule
		fields = [
			'id',
			'sid'
		]
