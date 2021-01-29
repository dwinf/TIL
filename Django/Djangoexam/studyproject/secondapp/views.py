from datetime import datetime
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.template import loader
import random


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


def exam2_1(request):
    if request.method == 'GET':
        msg = request.GET.get("info1", "없음") + "-" + request.GET.get("info2", "없음") + "-" + request.GET.get("info3",
                                                                                                            "없음")
    else:
        msg = request.POST.get("info1", "없음") + "-" + request.POST.get("info2", "없음") + "-" + request.POST.get("info3",
                                                                                                               "없음")
    context = {'result': msg}
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


def exam9(request):
    context = None
    foodstr = ""
    if request.method == 'POST':
        foods = request.POST.getlist("food", "없음")  # 전달되는 것이 둘 이상일 경우 getlist
        for f in foods:
            foodstr += f + " "
        fcolor = request.POST.get("fcolor", "없음")
        year = request.POST.get("year", "없음")
        memo = request.POST.get("memo", "없음")
        birth = request.POST.get("birth", "없음")
        context = {
            'info': {
                'info1': foodstr,
                'info2': fcolor,
                'info3': year,
                'info4': memo,
                'info5': birth,
            }
        }
    return render(request, 'exam9.html', context)


def exam10(request, name):
    context = {
        'name': name,
    }
    return render(request, 'exam10.html', context)


def exam11(request, name, age):
    context = {
        'name': name,
        'age': age,
    }
    return render(request, 'exam11.html', context)


def exam12(request, num1, num2):
    result = num1 * num2
    context = {
        'num1': num1,
        'num2': num2,
        'result': result,
    }
    return render(request, 'exam12.html', context)


def exam13(request):
    foods = ['짜장면', '초밥', '차돌짬뽕', '콩국수']
    empty_list = []
    messages = 'Life is short, You need Python'
    datetime_now = datetime.now()
    context = {
        'foods': foods,
        'empty_list': empty_list,
        'messages': messages,
        'datetime_now': datetime_now,
    }
    return render(request, 'exam13.html', context)


def exam14(request, word, num1, num2):
    if word == '올라프1':
        result = True
    else:
        result = False
    context = {
        'result': result,
        'num1': num1,
        'num2': float(num2),
    }
    return render(request, 'exam14.html', context)


def exam15(request):
    return render(request, 'exam15.html')


def exam16(request):
    print(request.GET.get('message'))
    msg_list = ['안녕', '방가방가', '하이']
    message = request.GET.get('message')
    context = {
        'message': message,
        'msg_list': msg_list,
    }
    return render(request, 'exam16.html', context)


def exam17(request):
    return render(request, 'exam17.html')


def exam18(request):
    name = request.GET.get('name')
    numbers = range(1, 46)
    pick = sorted(random.sample(numbers, 6))
    context = {
        'name': name,
        'pick': pick,
    }
    return render(request, 'exam18.html', context)


def exam19(request):
    dt = datetime.now()
    context = {'current_date': dt}
    return render(request, 'exam19.html', context)


def exam20(request):
    return render(request, 'exam20.html')


def exam21(request):
    return render(request, 'exam21.html')


def exam22(request):
    return render(request, 'exam22.html')


def exam24(request):
    return render(request, 'exam24.html')


def exam23(request):
    return render(request, 'exam23.html')


def json1(request):
    return JsonResponse({
        'message': '안녕 파이썬 장고',
        'items': ['가나다', '파이썬', '장고', '자바스크립트', 'CSS3'],
        'num': 100
    }, json_dumps_params={'ensure_ascii': False})


def json2(request):
    data = [{'name': 'Peter', 'email': 'peter@example.org'},
            {'name': 'Julia', 'email': 'julia@example.org'}]
    return JsonResponse(data, safe=False)


def json3(request):
    return JsonResponse({"name": "자바스크립트", "age": 21, "kind": "웹앱개발 전용 OOP 언어"},
                        json_dumps_params={'ensure_ascii': False})


def product1(request):
    return render(request, "product1.html", {'datas': [x for x in range(1, 11)]})


def basket1(request):
    pid = request.GET.get("pid")
    context = {'pid': pid, 'count': 1}
    return render(request, "basket1.html", context)


def product2(request):
    return render(request, "product2.html", None)


def basket2(request):
    pid = request.GET.get("pid")
    jsonContent = {"pid": pid, "count": 1}
    return JsonResponse(jsonContent)


def ggmap1(request):
    return render(request, "ggmap1.html", None)


def ggmap2(request):
    return render(request, "ggmap2.html", None)


def ggmap3(request):
    return render(request, "ggmap3.html", None)


def ggmap4(request):
    return render(request, "ggmap4.html", None)


def ggmap5(request):
    return render(request, "ggmap5.html", None)


def ggmap6(request):
    return render(request, "ggmap6.html", None)


def ggmap7(request):
    lat = [37.5115, 37.5094, 37.5080, 37.5110, 37.5088]
    lng = [127.0500, 127.0503, 127.0600, 127.0590, 127.0560];
    hname = ['듀크1', '듀크2', '듀크3', '듀크4', '듀크5'];
    address = ['aaa', 'bbb', 'ccc', 'ddd', 'eee'];
    context = {
        'lat': lat, 'lng': lng, 'hname': hname, 'address': address
    }
    return render(request, "ggmap7.html", context)


def kkmap1(request):
    return render(request, "kkmap1.html", None)


def kkmap2(request):
    return render(request, "kkmap2.html", None)


def kkmap3(request):
    return render(request, "kkmap3.html", None)


def kkmap4(request):
    return render(request, "kkmap4.html", None)


def kkmap5(request):
    return render(request, "kkmap5.html", None)


def kkmap6(request):
    return render(request, "kkmap6.html", None)


def kkmap7(request):
    return render(request, "kkmap7.html", None)
