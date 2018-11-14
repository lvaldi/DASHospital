from django.shortcuts import render, get_object_or_404
from django.views import View
from .forms import WeeklyscheduleForm, ScheduledTimeForm, ScheduledTimeModelForm
from django.views.generic import *
from datetime import datetime, time


from .models import *


class ScheduleListView(ListView):
	template_name = "ScheduledTime/schedule_list.html"
	queryset = ScheduledTime.objects.all()

class ScheduledTime_list_view(ListView):
	template_name = "ScheduledTime/schedule_list.html"
	def get(self,request, wid):
		queryset = ScheduledTime.objects.filter(wid = wid)
		ws = Weeklyschedule.objects.get(id= wid)
		staff = ws.sid

		return render(request,self.template_name,{'object_list' : queryset, 'wid' : wid, 'staff': staff})


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
			# print(ScheduledTime.objects.get(wid=10400001))
		# if form.is_valid():
		# 	form.save()
		# 	# form.save()
		context = {"form": form,
					"wid": wid}
		return render(request,self.template_name,context)
	

class ScheduledTime_update_view(UpdateView):
	template_name = "ScheduledTime/update.html"
	form_class = ScheduledTimeModelForm
	def get_object(self):
		date = self.kwargs.get("date")
		print(date)
		date_ = datetime.strptime(date, '%Y-%m-%d').date()
		starttime = self.kwargs.get("starttime")
		st = datetime.strptime(starttime, '%X').time()
		endtime = self.kwargs.get("endtime")
		et = datetime.strptime(endtime, '%X').time()
		wid = self.kwargs.get("wid")
		ww = Weeklyschedule.objects.get(id = wid)
		obj = get_object_or_404(ScheduledTime, wid = ww, starttime = st, endtime = et, date = date_)
		return obj

	def get_success_url(self):
		wid = self.kwargs.get("wid")
		str =""
		str = str + '/schedule/' + wid + '/list/'
		return str
class ScheduledTime_delete_view(DeleteView):
	template_name = "ScheduledTime/delete.html"
	form_class = ScheduledTimeModelForm
	def get_object(self):
		date = self.kwargs.get("date")
		print(date)
		date_ = datetime.strptime(date, '%Y-%m-%d').date()
		starttime = self.kwargs.get("starttime")
		st = datetime.strptime(starttime, '%X').time()
		endtime = self.kwargs.get("endtime")
		et = datetime.strptime(endtime, '%X').time()
		wid = self.kwargs.get("wid")
		ww = Weeklyschedule.objects.get(id = wid)
		obj = get_object_or_404(ScheduledTime, wid = ww, starttime = st, endtime = et, date = date_)
		return obj

	def get_success_url(self):
		wid = self.kwargs.get("wid")
		str =""
		str = str + '/schedule/' + wid + '/list/'
		return str

	# def get(self,request, *args, **kwargs):
		
	# 	obj = self.get_object()
	# 	if obj is not None:
	# 		form = ScheduledTimeModelForm(instance = obj)
	# 		context = {"form": form,
	# 					"obj": obj}
	# 	return render(request,self.template_name, context)

	# def post(self, request, wid, *args, **kwargs):
	# 	obj = self.get_object()
	# 	# print(obj)
	# 	# print(hello)
	# 	form = ScheduledTimeModelForm(request.POST, instance = obj)
	# 	# print(form.is_valid())
	# 	if form.is_valid():
	# 		# print(hello)
	# 		form.save()
	# 	context = {"form": form,
	# 					"obj": obj}
	# 	return render(request,self.template_name,context)
	
# Create your views here.
