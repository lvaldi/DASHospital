from django.shortcuts import render

from .forms import WeeklyscheduleForm

from .models import *



def Weeklyschedule_create_view(request):
	form = WeeklyscheduleForm(request.POST or None)
	if form.is_valid():
		form.save()

	context = {
		'form':form
	}
	return render(request,"Weeklyschedule/create.html",context)


# Create your views here.
