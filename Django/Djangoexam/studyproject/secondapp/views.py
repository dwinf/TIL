from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader


def exam1(request):
    template = loader.get_template('exam1.html')
    return HttpResponse(template.render(None, request))


def exam2(request):
    template = loader.get_template('exam2.html')
    if request.method == 'GET':
        msg = "GET방식으로 요청했군요"
    else:
        msg = "POST방식으로 요청했군요"
    context = {'result': msg}
    return HttpResponse(template.render(context, request))


'''def exam2_1(request):
    template = loader.get_template('exam2_1.html')
    if request.method == 'GET':
        msg = request.GET.get("info1", "없음") + "-" + request.GET.get("info2", "없음") + "-" + request.GET.get("info3", "없음")
    else:
        msg = request.POST.get("info1", "없음") + "-" + request.POST.get("info2", "없음") + "-" + request.POST.get("info3", "없음")
    context = {'result': msg}
    return HttpResponse(template.render(context, request))'''


def exam2_1(request) :
    if request.method == 'GET' :
       msg = request.GET.get("info1", "없음") + "-" + request.GET.get("info2", "없음") + "-" + request.GET.get("info3", "없음")
    else :
       msg = request.POST.get("info1", "없음")  + "-" + request.POST.get("info2", "없음")  + "-" + request.POST.get("info3", "없음")
    context = {'result' : msg}
    return render(request, 'exam2_1.html', context)


def exam3(request):
    context = {'number': 5}
    return render(request, 'exam3.html', context)


def exam4(request):
    context = {'numbers': [1, 2, 3, 4, 5, 6]}
    return render(request, 'exam4.html', context)


def exam5(request):
    name = request.GET.get('name', "게스트")
    address = request.GET.get('address', "작성안함")
    context = {'name': name, 'address': address}
    return render(request, 'exam5.html', context)


def exam6(request):
    if request.method == 'POST':
        num = int(request.POST['number'])
        context = {'num': num * num}
    else:
        context = None
    return render(request, 'exam6.html', context)


# 테스트 전에 dir 설정할것
def exam7(request):
    foods = ['족발', '햄버거', '치킨', '초밥']
    pick = random.choice(foods)
    context = {
        'pick': pick,
    }
    return render(request, 'exam7.html', context)


def exam8(request):
    query = 'q' in request.GET
    if query:
        result = request.GET['q']
    else:
        result = 'q=xxx 형식으로 쿼리를 보내지 않았슈'
    context = {
        'result': result,
    }
    return render(request, 'exam8.html', context)
