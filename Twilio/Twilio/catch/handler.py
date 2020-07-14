from django.shortcuts import render, redirect

def unfound(request):
    return render(request, 'catch/404.html')

def unright(request):
    return render(request, 'catch/500.html')

def unrequest(request):
    return render(request, 'catch/400.html')