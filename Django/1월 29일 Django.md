# 1월 29일 Django



```html
{% load static %}
<img class="card-img-top" src="{% static 'images/olaf1.png' %}" alt="Card image" style="width:100%">
<img class="card-img-top" src="/static/images/olaf1.png" alt="Card image" style="width:100%">
```

- static 폴더가 같은 프로젝트 폴더에 있기 때문에 경로명을 통해서도 호출 가능
- 하지만 환경(서버에 배포)에 따라 경로에 변동이 있을 수 있기 때문에 태그를 이용한다.



```python
path('exam16/', views.exam16, name='unico'),
```

- 경로명의 name 속성은 다른 것과 중복되지 않으면 상관없다.

```python
<form action="{% url 'unico' %}" method="GET">
	<input type="text" name="message">
    <input type="submit">
</form>
```

- 매핑 정보에 등록된 이름으로 url을 가져올 수 있다.
- input 태그로 받은 메세지도 전달된다.
- 새로운 페이지로 이동하게 되면 이전 페이지는 사라진다.



```python
def exam16(request):
    print(request.GET.get('message'))
    msg_list = ['안녕', '방가방가', '하이']
    message = request.GET.get('message')
    context = {
        'message': message,
        'msg_list': msg_list,
    }
    return render(request, 'exam16.html', context)
```

- view에서 print를 하게 되면 웹이 아닌 파이참 터미널에 출력
- return으로 반환해 주는 것만 웹에 영향을 준다.



---



### XML(Extensible Markup Language)

> HTML과 마찬가지로 마크업 언어이다.

GML -> SGML -> XML : 규격화시킨 문서를 만들고 싶을 때 사용, 태그명을 용도에 맞게 직접 정의하여 사용

​							HTML : 웹페이지 제작에 사용되는 전용 마크업 언어



### JSON(JavaScript Object Notation)

프로그래밍 언어나 플랫폼에 독립적, 그래도 자바스크립트와 가장 잘 맞는다.

json 객체는 파이썬에서 딕셔너리가 된다.



#### 형식 비교

![image-20210129101427225](C:\Users\dwinf\AppData\Roaming\Typora\typora-user-images\image-20210129101427225.png)



### AJAX

기존 웹 통신에서는 서버에서 통신이 왔을 때 기존 웹 페이지를 지우고 새로 렌더링한다. AJAX에서는 페이지 전체가 아닌 일부만 갱신하도록 한다.



##### AJAX 웹 통신

![image-20210129104225845](C:\Users\dwinf\AppData\Roaming\Typora\typora-user-images\image-20210129104225845.png)

- Ajax Engine을 이용해 실시간으로 갱신이 가능하도록 함
- 서버가 응답을 하는 동안 클라이언트는 다른 일을 할 수 있다.



1. JSON(XML) 형식으로 응답하는 뷰를 준비해야 한다.

   (템플릿을 거치지 않고 뷰가 직접 응답)

2. JavaScript만 사용해서 AJAX 요청을 구현하는 방법

   ```javascript
   var xhr = XMLHpptRequest()
   xhr.onload = 함수	//ajax 엔진을 초기화
   xgr.open("GET", "대상URL", true)
   xhr.send() //서버에 ajax통신 요청
   ```

   JQuery API를 사용하여 AJAX 요청을 구현하는 방법

   ```javascript
   $.getJSON("대상URL", 함수)
   $ajax( {자바스크립트객체} )
   ```

   - 둘 중 하나 사용



JSON 뷰파일

```python
def json1(request):
    return JsonResponse({
        'message': '안녕 파이썬 장고',
        'items': ['가나다', '파이썬', '장고', '자바스크립트', 'CSS3'],
        'num': 100
    }, json_dumps_params={'ensure_ascii': False}) # 한글이 들어갈 경우 필수

def json2(request):
    data = [{'name': 'Peter', 'email': 'peter@example.org'},
            {'name': 'Julia', 'email': 'julia@example.org'}]
    return JsonResponse(data, safe=False)

def json3(request):
    return JsonResponse({"name": "자바스크립트", "age": 21, "kind": "웹앱개발 전용 OOP 언어"}, json_dumps_params={'ensure_ascii': False})
```

- json_dumps_params={'ensure_ascii': False}) : 한글이 들어갈 경우 필수

- JsonResponse(data, safe=False) : 객체를 덩어리로 전달할 경우 safe= False

  

```html
$(document).ready(function() {
   $.ajax({
        type : 'get',
        url : 'http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=75474bdfc6c0a4eb738939dd66c101b5&targetDt=20210127',
        dataType : 'json',	//json으로 받는다.
        error: function(xhr, status, error){	//응답이 없으면
            alert(error);
        },
        success : function(json){	//응답이 있으면, json객체를 받아온 것을 아규먼트로 사용
            console.log(json)
			console.log(typeof json)
            $('div').html(JSON.stringify(json))
            console.log(json.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
        }
    });
});
```

- get하는 것이 json이 아니면 가져올 수 없다. 

```
$(document).ready(function() {
   $.getJSON('http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=75474bdfc6c0a4eb738939dd66c101b5&targetDt=20210127',
        function(json){
            console.log(json)
            $('div').html(JSON.stringify(json))
            console.log(json.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
        }
    );
});
```

- 조금 더 간단히 구현할 수 있다.
  - $.ajax vs $.getJSON



#### AJAX 보안규약

##### Same Origin Policy(SOP) 

- 브라우저에서 보안상의 이슈로 동일 사이트의 자원(Resource)만 접근해야 한다는 제약이다. 
- AJAX는 이 제약에 영향을 받으므로 Origin 서버가 아니면 AJAX 로 요청핚 컨텐츠를 수신할 수 없다. 

##### Cross Origin Resource Sharing(CORS)

- 초기에는 Cross Domain이라고 하였다.(동읷 도메읶에서 포트만 다른 경우, 로컬 파일인 경우 등으로 인해 Origin이라는 으로 용어 통일됨)
- Origin 이 아닌 다른 사이트의 자원을 접근하여 사용한다는 의미이다.
- Open API 의 활성화와 공공 DB 의 활용에 의해서 CORS 의 중요성이 강조되고 있다.
- HTTP Header에 CORS 와 관련된 항목을 추가한다