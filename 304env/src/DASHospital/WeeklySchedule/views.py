from django.shortcuts import render, get_object_or_404, redirect
from django.views import View
from .forms import WeeklyscheduleForm, ScheduledTimeForm, ScheduledTimeModelForm
from django.views.generic import *
from datetime import datetime, time
from django.db import connection


from .models import *


class ScheduledTime_list_view(ListView):
	template_name = "ScheduledTime/schedule_list.html"
	def get(self,request, wid):
		queryset = ScheduledTime.objects.raw('SELECT * FROM "scheduled_time" WHERE "scheduled_time"."wid"=%s', [wid])
		ws = Weeklyschedule.objects.raw('SELECT * FROM "weeklyschedule" WHERE "weeklyschedule"."id"=%s', [wid])[0]
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
			connection.cursor().execute('INSERT into "scheduled_time" values(%s,%s,%s,%s,%s)',(ddate,st,et,wid,nt))
		context = {"form": form,
					"wid": wid}
		return render(request,self.template_name,context)

	

class ScheduledTime_update_view(UpdateView):
	template_name = "ScheduledTime/update.html"
	form_class = ScheduledTimeModelForm
	def get_object(self):
		date = self.kwargs.get("date")
		date_ = datetime.strptime(date, '%Y-%m-%d').date()
		starttime = self.kwargs.get("starttime")
		st = datetime.strptime(starttime, '%X').time()
		endtime = self.kwargs.get("endtime")
		et = datetime.strptime(endtime, '%X').time()
		wid = self.kwargs.get("wid")
		obj = ScheduledTime.objects.raw('SELECT * FROM "scheduled_time" WHERE "scheduled_time"."date" = %s AND "scheduled_time"."starttime" = %s AND "scheduled_time"."endtime" = %s AND "scheduled_time"."wid" = %s',(date,starttime,endtime,wid)) 
		return obj[0]

	def get_success_url(self):
		wid = self.kwargs.get("wid")
		str =""
		str = str + '/schedule/' + wid + '/list/'
		return str

class ScheduledTime_delete_view(View):
	template_name = "ScheduledTime/delete.html"
	form_class = ScheduledTimeModelForm
	def get_object(self):
		date = self.kwargs.get("date")
		date_ = datetime.strptime(date, '%Y-%m-%d').date()
		starttime = self.kwargs.get("starttime")
		st = datetime.strptime(starttime, '%X').time()
		endtime = self.kwargs.get("endtime")
		et = datetime.strptime(endtime, '%X').time()
		wid = self.kwargs.get("wid")
		obj = ScheduledTime.objects.raw('SELECT * FROM "scheduled_time" WHERE "scheduled_time"."date" = %s AND "scheduled_time"."starttime" = %s AND "scheduled_time"."endtime" = %s AND "scheduled_time"."wid" = %s',(date,starttime,endtime,wid)) 
		return obj[0]

	def get(self, request, *args, **kwargs):
		context = {}
		obj = self.get_object()
		if obj is not None:
			context['obj']=obj
		return render(request,self.template_name, context)

	def post(self,request,*args,**kwargs):
		date = self.kwargs.get("date")
		date_ = datetime.strptime(date, '%Y-%m-%d').date()
		starttime = self.kwargs.get("starttime")
		st = datetime.strptime(starttime, '%X').time()
		endtime = self.kwargs.get("endtime")
		et = datetime.strptime(endtime, '%X').time()
		wid = self.kwargs.get("wid")
		str =""
		str = str + '/schedule/' + wid + '/list/'
		context = {}
		obj = self.get_object()
		if obj is not None:
			context['obj'] = None
			connection.cursor().execute('DELETE FROM "scheduled_time" WHERE "scheduled_time"."date" = %s AND "scheduled_time"."starttime" = %s AND "scheduled_time"."endtime" = %s AND "scheduled_time"."wid" = %s',(date,starttime,endtime,wid))
			return redirect(str)
		return render(request,self.template_name,context)
