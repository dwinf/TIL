from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader


def exam1(request):
    template = loader.get_template('exam1.html')
    return HttpResponse(template.render(None, request))


def exam2(request):
    template = loader.get_template('exam2.html')
    if request.method == 'GET':
        msg = "GET방식으로 했군요"
    else:
        msg = "POST방식으로 했군요"
    context = {'result': msg}
    return HttpResponse(template.render(context, request))


def exam2_1(request):
    template = loader.get_template('exam2_1.html')
    if request.method == 'GET':
        msg = request.GET.get("info1", "없음") + "-" + request.GET.get("info2", "없음") + "-" + request.GET.get("info3","없음")
    else:
        msg = request.POST.get("info1", "없음") + "-" + request.POST.get("info2", "없음") + "-" + request.POST.get("info3","없음")
    context = {'result': msg}
    return HttpResponse(template.render(context, request))
