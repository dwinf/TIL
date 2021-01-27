from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader


def exercise1(request):
    template = loader.get_template('exercise1.html')
    context = {'result': "kdc"}
    return HttpResponse(template.render(context, request))


def exercise2(request):
    if request.method == 'POST':
        num = int(request.POST['number'])
        context = {'num': num * num}
    else:
        context = None
    return render(request, 'exercise2.html', context)
# Create your views here.
