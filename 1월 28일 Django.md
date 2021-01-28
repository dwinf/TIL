# 1월 28일 Django

새로운 프로젝트를 만들 때는 cmd창을 이용해 생성

새로운 앱은 파이참 터미널을 이용해 생성

setting.py와 urls.py 수정





#### block 및 extends

html 파일 내용을 반복해서 작성해야 하는 번거로움을 줄여줌

```html
{% extends "base_generic.html" %}
{% block title %}{{ section.title }}{% endblock %}
{% block content %}
<h1>{{ section.title }}</h1>

{% for story in story_list %}
<h2>
   <a href="{{ story.get_absolute_url }}">
      {{ story.headline|upper }}
 </a>
</h2>
<p>{{ story.tease|truncatewords:"100" }}</p>
{% endfor %}
{% endblock %}

```

- base_generic.html 파일에 정의된 block 중 이름이 같은 블럭에 내용이 들어가게 된다.
- 블럭이 적용된 base_generic.html 파일이 실행되게 된다.





##### exam10

```python
def exam10(request, name):
    context = {
        'name': name,
    }
    return render(request, 'exam10.html', context)
    
path('exam10/<name>/', views.exam10, name='exam10'), # <name>을 아규먼트로 사용
```

- `<name>`이 아닌 name을 쓸 경우 url입력시 'name'을 정확히 입력해야함

```python
path('exam11/<name>/<int:age>', views.exam11, name='exam11'),
```

- 아규먼트로 받은 데이터 타입 지정 가능
- urls.py의 name 속성은 생략해도 된다.



##### exam13

```python
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
```

```html
{% block mycontent %}
    <h3>1. 반복문</h3>
    {% for food in foods %}
        <p>{{ food }}</p>
    {% endfor %}

    {% for food in foods %}
        <p>{{ forloop.counter }} {{ food }}</p>	장고의 내장변수
    {% endfor %}

    {% for element in empty_list %}
        <p>{{ element }}</p>
    {% empty %}
        <p>지금 아무것도 없네요..</p>
    {% endfor %}

    <h3>2. 조건문</h3>
    {% if '짜장면' in foods %}
        <p>짜장면 역시 또자강!!</p>
    {% endif %}

    {% for food in foods %}
        {% if forloop.first %}	장고의 내장변수
            <p>짜장면엔 고추가루지!!</p>
        {% else %}
            <p>{{ food }}</p>
        {% endif %}
    {% endfor %}

    <h3>3. length filter</h3>
    {% for food in foods %}
        {% if food|length > 2 %}	`|`(파이프)를 이용해 조건식(필터링)
            <p>메뉴 이름이 너무 길어요</p>
        {% else %}
            <p>{{ food }}, {{ food|length }}</p>
        {% endif %}
    {% endfor %}

    <h3>4. lorem ipsum</h3>		시각적 연출을 위한 텍스트
    <p>{% lorem %}</p>
    <hr>
    {% lorem 3 w %}		3단어
    <hr>
    {% lorem 4 w random %}		랜덤 4단어

    <h3>5. 글자수 제한</h3>
    <p>{{ messages|truncatewords:3 }}</p>
    <p>{{ messages|truncatechars:3 }}</p>
    <p>{{ messages|truncatechars:10 }}</p>

    <h3>6. 글자 관련 필터</h3>
    <p>{{ 'ABC'|lower }}</p>
    <p>{{ messages|title }}</p>
    <p>{{ 'abc edf'|capfirst }}</p>
    <p>{{ foods|random }}</p>

    <h3>7. 연산</h3>
    <p>{{ 4|add:6 }}</p>
    <p>{{ 4|divisibleby:2 }}</p>

    <h3>8. 날짜 표현</h3>
    <p>전달받은 데이터 : {{ datetime_now }}</p>
    <p>{% now "DATETIME_FORMAT" %}</p>
    <p>{% now "DATE_FORMAT" %}</p>
    <p>{% now "SHORT_DATETIME_FORMAT" %}</p>
    <p>{% now "SHORT_DATE_FORMAT" %}</p>
    <p>{% now "Y y m n M d j w D l z" %}</p>
    <p>{% now "e T g  G h H i s a A" %}</p>
    <ul>
   {% for data in foods %}
        <li class="{% cycle 'aa' 'bb' %}">{{ data }}</li>
   {% endfor %}
    </ul>
{% endblock %}
```

- 다양한 템플릿 태그 예시
  - 반복문, 조건문은 종료 태그가 필수적