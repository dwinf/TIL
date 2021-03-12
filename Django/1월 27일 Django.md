# 1월 27일 Django



![image-20210127090440191](https://user-images.githubusercontent.com/73389275/110779957-80fac700-82a7-11eb-89f2-cef0ea63b93f.png)

 웹 클라이언트(브라우저)의 요청을 받아 장고에서 MTV 모델에 따라 처리하는 과정

- 클라언트로부터 요청을 받으면 URLconf 모듈을 이용하여 URL을 분석한다.

- URL 분석 결과를 통해 해당 URL에 매칭되는 뷰들 실행한다.

- 뷰는 자신의 로직을 실행하고, 데이터베이스 처리가 필요하면 모델을 통해 처리하고 그 결과를 반환 받는다.

- 뷰는 자신의 로직 처리가 끝나면 템플릿을 사용하여 클라이언트에 전송할 HTML 파일을 생성한다.

- 뷰는 최종 결과로 HTML 파일을 클라이언트에게 보내 응답한다.



##### URL 문자열

http://localhost:8000/welcome/

http://127.0.0.1:8000/welcome/ ---> firstapp.views.welcome

http://localhost:8000/secondapp/ ---> views.exam1

http://localhost:8000/secondapp/exam2/ ---> views.exam2

http://localhost:8000/secondapp/exam2_1/

- 포트번호 다음부터는 URI



```python
def exam2(request):
    template = loader.get_template('exam2.html')
    if request.method == 'GET':
        msg = "GET방식으로 했군요"
    else:
        msg = "POST방식으로 했군요"
    context = {'result': msg}
    return HttpResponse(template.render(context, request))
```



- HttpRequest : HTTP 프로토콜 기반으로 요청이 왔을 때 요청 관련 정보를 제공하는 객체

  (요청처리)	get/post로 요청했는지 등의 정보. 뷰 함수가 호출될 때 아규먼트로 전달된다.(장고 서버가 객체를 생성)

- HttpResponse : HTTP 프로토콜 기반으로 온 요청에 대한 응답시 사용하는 객체

  (응답처리)	응답내용을 답는다.(HTML태그문자열, 템플릿을 사용한 렌더객체)

- 템플릿 변수 : {{변수명}}
  - 뷰에서 템플릿으로 객체를 전달
  - 딕셔너리로 전달해야 한다.
- 템플릿 태그(로직) : {% 로직 %}
  - if문, for문과 같이 흐름을 제어할 수 있다. 
  - POST 방식일 경우 url 끝에 `/`를 반드시 붙여야 하고 보안을 위한 토큰이 필요하다.

```html
<form method="POST" action="/secondapp/exam2/">
    {% csrf_token %}    
    <input type="hidden" name="info1" value="djangp">
    <input type="hidden" name="info2" value="css">
    <input type="hidden" name="info3" value="javascript">
    <input type="submit" value="<form>태그로 POST방식 요청">
</form>
```

-  `{% csrf_token %}` : 화면에 영향을 주지 않는다. 
  - `<input type="hidden" name="csrfmiddlewaretoken" value="Tvym4SAc1eU0gNvdZ3uljBxbwYGF7WXYLd2xE62iIvG6Vd5EsJezy05EvSeya48R">`
  - 페이지소스에서 확인
  - 보안을 위해 사용되는 토큰이다.

```html
<ul>
{% for student in student_list %}
    <li>{{ student.name }}</li>
{% endfor %}
</ul>
```

- 반복문, 조건문 등을 사용할 때는 종료태그가 필요하다.
  -  유닉스같은 느낌



URL 뒤에 /를 붙이지 않고 요청하면 301 응답과 함께 /를 붙여 다시 요청하게 된다. == 총 2회 통신하게 됨

path를 설정할 때는 /를 꼭 붙여야 한다.

효율적인 통신을 위해 /를 붙이는 것이 좋다.

POST 방식에서는 /를 안붙이면 에러 발생



#### Query 문자열

HTTP Client가 HTTP Server 요청시 서버에서 요청하려는 대상의 URI가 전달되는데 이 때 함께 전달될 수 있는 문자열이다

- name = value 형식으로 구성되어야 한다.
- 여러 개의 name-value가 사용될 때는 & 기호로 구분되게 구성해야 한다.
- 영문과 숫자는 그대로 전달되지만 한글과 특수문자들은 %기호와 16진수 코드값으로 전달된다.(UTF-8)
- 공백문자는 +기호 또는 %2C로 전달된다.
- Query 문자열을 가지고 HTTP Server에게 정보를 요청할 때는 두 가지 요청 방식 중 한 개를 선택할 수 있다.
  - GET : Query 문자열이 외부에 보여진다. 요청 URL 뒤에 ? 기호와 함께 전달
  - POST : Query 문자열이 외부에 보여지지 않는다. Query 문자열의 길이에 제한이 없다.

https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=ABCabc+123%EA%B0%80%EB%82%98%EB%8B%A4



```html
<a href="http://localhost:8000/secondapp/exam2_1/?info1=aa&info2=BB&info3=CC"></a>
```

- 검색할 내용을 붙여서 응답할 수 있다.
