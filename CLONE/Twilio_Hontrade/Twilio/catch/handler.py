from django.shortcuts import render, redirect

def unfound(request, exception, template_name='catch/404.html'):
    return render(request, template_name)

def unright(request, exception, template_name='catch/500.html'):
    return render(request, template_name)

def unrequest(request, exception, template_name='catch/400.html'):
    return render(request, template_name)