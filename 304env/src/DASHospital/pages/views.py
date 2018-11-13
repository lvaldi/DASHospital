from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.
def sign_in_view(request, *args, **kwargs):
    print(args, kwargs)
    print(request.user)
    # return HttpResponse("<h1>Hello World</h1>")
    return render(request, "home.html", {})


def create_user_view(request, *args, **kwargs):
    print(request.user)
    return HttpResponse("<h1>Create User</h1>")
