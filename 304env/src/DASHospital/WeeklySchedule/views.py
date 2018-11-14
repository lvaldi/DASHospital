from django.shortcuts import render
from django.views import View
from .forms import WeeklyscheduleForm, ScheduledTimeForm

from .models import *



class ScheduledTime_create_view(View):
	template_name = "ScheduledTime/create.html"
	def get(self, request, wid, *args, **kwargs):
		form = ScheduledTimeForm()
		context = {"form": form,
					"wid": wid}
		return render(request,self.template_name, context)

	def post(self,request,wid,*args,**kwargs):
		form = ScheduledTimeForm(request.POST)
		if form.is_valid():
			data = form.cleaned_data
			ddate = data.get('date')
			st = data.get('starttime')
			et = data.get('endtime')
			nt = data.get('notes')
			schedule = Weeklyschedule.objects.get(id=wid)
			ScheduledTime.objects.create(date = ddate, starttime = st, endtime = et, wid = schedule, notes = nt)
			print(ScheduledTime.objects.get(wid=10400001))
		# if form.is_valid():
		# 	form.save()
		# 	# form.save()
		context = {"form": form,
					"wid": wid}
		return render(request,self.template_name,context)
	

class ScheduledTime_update_view(View):
	template_name = "ScheduledTime/update.html"
	def get_object(self):
		wid = self.kwargs.get('wid')
	def get(self, request, wid, *args, **kwargs):
		form = ScheduledTimeForm()
		context = {"form": form,
					"wid": wid}
		return render(request,self.template_name, context)

	def post(self,request,wid,*args,**kwargs):
		form = ScheduledTimeForm(request.POST)
		if form.is_valid():
			data = form.cleaned_data
			ddate = data.get('date')
			st = data.get('starttime')
			et = data.get('endtime')
			nt = data.get('notes')
			schedule = Weeklyschedule.objects.get(id=wid)
			ScheduledTime.objects.create(date = ddate, starttime = st, endtime = et, wid = schedule, notes = nt)
			print(ScheduledTime.objects.get(wid=10400001))
		# if form.is_valid():
		# 	form.save()
		# 	# form.save()
		context = {"form": form,
					"wid": wid}
		return render(request,self.template_name,context)
	
# Create your views here.
