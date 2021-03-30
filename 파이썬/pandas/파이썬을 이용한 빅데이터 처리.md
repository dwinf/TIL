# 파이썬을 이용한 빅데이터 처리

- **스크립트 형태의 범용 프로그래밍 언어**
- 프로그래머가 원하는 모든 작업을 할 수 있도록 설계한 범용 언어
- 명령형 언어이면서 스크립트 방식 지원
  - 프로그래밍적인 구현에 적합
  - **데이터 수집과 처리에 활용할 수 있는 다양한 라이브러리 제공**(데이터 수집에 용이한 이유!)
- 웹 서버 프로그래밍, 데이터 분석, 시스템 자동화,  IOT 프로그래밍까지 활용 분야도 다양

### Anaconda

- Anaconda는 세계에서 가장 유명한 파이썬(Python) 데이터 과학 플랫폼이다. 모든 데이터 과학 패키지를 쉽게
  설치하고 패키지, 종속성 및 환경을 관리할 수 있다. 
- Anaconda는 conda, Python 및 150 개가 넘는 과학 패키지와 그 종속성과 함께 제공되는 파이썬 배포판이며 응용 프로그램 conda는 패키지 및 환경 관리자이다. 
- 파이썬과 수학·과학·데이터 분석 분야에서 필요한 거의 모든 패키지(NumPy, SciPy, Pandas, Matplotlib 등) 포함



## 1. urllib 패키지를 활용한 웹 페이지 요청

- URL 관련 라이브러리라는 의미의 패키지
- **파이썬의 표준 라이브러리**

### URL 문자열과 웹 요청에 관련된 모듈 5개 제공

- `urllib.request` — URL 문자열을 가지고 **요청 기능** 제공
- `urllib.response` — urllib 모듈에 의해 사용되는 **응답** 기능 관련 클래스들 제공
- `urllib.parse` — URL 문자열을 **파싱하여 해석**하는 기능 제공
- `urllib.error` — urllib.request에 의해 발생하는 예외 클래스들 제공
- `urllib.robotparser` — robots.txt 파일을 구문 분석하는 기능 제공



### urllib.reauest 모듈

- URL 문자열을 가지고 HTTP 요청을 수행
- urlopen() 함수를 사용하여 웹 서버에 페이지를 요청하고, 서버로부터 받은 응답을 저장하여 응답 객체(**http.client.HTTPResponse**)를 반환

```python
res = urllib.request.urlopen("요청하려는 페이지의 URL 문자열")
```

#### http.client.HTTPResponse

- 웹 서버로부터 받은 응답을 래핑하는 객체
- 응답 헤더나 응답 바디의 내용을 추출하는 메서드 제공
- **HTTPResponse.read([amt])**
  - 16진수로 이루어진 바이트 열로 읽어들이기 때문에 `.decode('utf-8')`을 통해 변환
- **HTTPResponse.getheaders()**
- **HTTPResponse.msg**
- **HTTPResponse.version**
- **HTTPResponse.status**



```python
import urllib.request
res = urllib.request.urlopen("http://unico2013.dothome.co.kr/crawling/tagstyle.html")
print(res)
print("[ header 정보 ]----------")
res_header = res.getheaders()
for s in res_header :
    print(s)
print("[ body 내용 ]-----------")
#print(res.read()) # 문자 코드가 출력되기 때문에 decode를 통해 정상출력
print(res.read().decode('utf-8'))
```



```python
import urllib.request
print("===========================================================")
url = 'https://www.python.org/'
f = urllib.request.urlopen(url)
print(type(f))
print(type(f.info()))
encoding = f.info().get_content_charset()
print(url, ' 페이지의 인코딩 정보 :', encoding)
text = f.read(500).decode(encoding)
print(text)
```

- 페이지 코드를 500자를 읽어 출력



### urllib.parse 모듈

- 웹 서버에 페이지 또는 정보를 요청할 때 함께 전달하는 데이터
  - GET 방식 요청 : Query 문자열
  - POST 방식 요청 : 요청 파라미터

```python
name=value&name=value&name=value&.....
```

- 영문과 숫자는 그대로 전달되지만 한글은 %기호와 함께 16진수 코드 값으로 전달되어야 함
- 웹 크롤링을 할 때 요구되는 Query 문자열을 함께 전달해야 하는 경우, 직접 Query 문자열을 구성해서 전달해야 함

#### urllib.parse 모듈 사용

- **urllib.parse.urlparse(URL)**

  - ```python
    url = urlparse("https://movie.daum.net/moviedb/main?movieId=93252")
    ```

  - 아규먼트에 지정된 URL 문자열의 정보를 다음과 같이 구성하여 저장하는 `urllib.parse.ParseResult` 객체를 리턴함

    - ```python
      ParseResult(scheme="https", netloc="movie.daum.net",
      			path="/moviedb/main", params="",
      			query="movieId=93252", fragment="")
      ```

  - 각 속성들을 이용하여 필요한 정보만 추출할 수 있음

    - `url.netloc`
    - `url.path`
    - `url.query`
    - `url.scheme`
    - `url.port`
    - `url.fragment`
    - `url.geturl()`

- **urllib.parse.urlencode()**

  - 메서드의 아규먼트로 지정된 name과 value로 구성된 딕셔너리 정보를 정해진 규격의 Query 문자열 또는 요청 파라미터 문자열로 리턴 함

  - ```python
    urlencode({'number':12524, 'type':'issue', 'action':'show'})
    ```

    - ```
      number=12524&type=issue&action=show
      ```

  - ```python
    urlencode({'addr': '서울시 강남구 역삼동'})
    ```

    - ```
      addr=%EC%84%9C%EC%9A%B8%EC%8B%9C+%EA%B0%95%EB%82%A8%EA%B5%AC+%EC%97%AD%EC%82%BC%EB%8F%99
      ```

#### GET 방식 요청

- Query 문자열을 포함하여 요청하는 것

  1. `urllib.parse.urlencode` 함수로 **name**과 **value**로 구성되는 Query 문자열을 만듦
  2. URL 문자열 뒤에 `?` 기호 추가하여 요청 URL로 사용

- ```python
  params = urllib.parse.urlencode({'name': '유니코', 'age': '10'})
  url = http://unico2013.dothome.co.kr/crawling/get.php?%s" % params
  urllib.request.urlopen(url)
  ```

#### POST 방식 요청

- 요청 바디 안에 요청 파라미터를 포함하여 요청하는 것

  1. GET 방식과 같이 `urllib.parse.urlencode` 함수로 `name`과 `value`로 구성되는 Query 문자열을 만듦
  2. POST 방식 요청에서는 바이트 형식의 문자열로 전달해야 하므로 `encode('ascii')` 메서드를 호출하여 바이트 형식의 문자열로 변경
  3. `urllib.request.urlopen()` 호출 시 바이트 형식의 문자열로 변경된 데이터를 두 번째 아규먼트로 지정!

  - ```python
    data = urllib.parse.urlencode({'name': '유니코', 'age’: 10})
    data = data.encode(‘ascii’)
    url = “http://unico2013.dothome.co.kr/crawling/post.php”
    urllib.request.urlopen(url, data) 
    ```

- **urllib.request.Request** 

  - URL 문자열과 요청 파라미터 문자열을 지정한 urllib.request.Request 객체 생성

  - urllib.request.urlopen() 함수 호출 시 URL 문자열 대신 urllib.request.Request 객체 지정

  - ```python
    data = urllib.parse.urlencode({'name': '유니코', 'age': 10})
    postdata = data.encode('ascii')
    req=urllib.request.Request(url='http://unico2013.dothome.co.kr/crawling/post.php',data=postdata)
    urllib.request.urlopen(req)
    ```

    

## 2. requests 패키지를 활용한 웹 페이지 요청

### requests 패키지란?

- Kenneth Reitz에 의해 개발된 파이썬 라이브러리
- HTTP프로토콜과 관련된 기능 지원
- 아나콘다에 기본적으로 설치되어 있지만 가상환경을 만들었기 때문에 별도로 설치함
  - `conda install requests` 또는 `pip install requests`

### requests.request() 함수

- requests 패키지의 대표 함수
- HTTP 요청을 서버에 보내고 응답을 받아오는 기능 지원

| urllib 패키지                                    | requests 패키지                                              |
| ------------------------------------------------ | ------------------------------------------------------------ |
| 인코딩하여 바이너리 형태로 데이터 전송           | 딕셔너리 형태로 데이터 전송                                  |
| 요청 방식(GET, POST)에 따라서 구현 방법이 달라짐 | requests() 함수 호출시 요청 메소드(GET, POST)를 명시하여 요청 |

#### `requests.request(method, url, **kwargs)`

- **method** : 요청 방식 지정(GET, POST, HEAD, PUT, DELETE, OPTIONS)
  - 대부분 GET, POST 방식을 사용
- **url** : 요청할 대상 URL 문자열 지정
- params : [선택적] 요청 시 전달할 Query 문자열 지정
  (딕셔너리, 튜플리스트, 바이트열 가능)
- data : [선택적] 요청 시 바디에 담아서 전달할 요청 파라미터 지정
  (딕셔너리, 튜플리스트, 바이트열 가능)
- json : [선택적] 요청 시 바디에 담아서 전달할 JSON 타입의 객체 지정
- auth : [선택적] 인증처리(로그인)에 사용할 튜플 지정



#### requests.request() 함수에 요청 방식을 지정하여 호출하는 것과 동일

- requests.get(url, **params**=None, **kwargs)
- requests.post(url, **data**=None, **json**=None, **kwargs)
- requests.head(url, **kwargs)
- requests.put(url, data=None, **kwargs)
- requests.patch(url, data=None, **kwargs)
- requests.delete(url, **kwargs)



#### GET 방식 요청은 다음 두 가지 함수 중 하나를 호출하여 처리 가능

```
requests.request('GET', url, **kwargs)
[ kwargs ] 
params – (선택적) 요청 시 전달할 Query 문자열을 지정합니다. 
requests.get(url, params=None, **kwargs)
```

- Query 문자열을 포함하여 요청 : params 매개변수에 딕셔너리, 튜플리스트, 바이트열(bytes) 형식으로 전달
- Query 문자열을 포함하지 않는 요청: params 매개변수의 설정 생략

#### POST 방식 요청은 다음 두 가지 함수 중 하나를 호출하여 처리 가능

```
requests.request(‘POST', url, **kwargs)
[ kwargs ]
data – (선택적) 요청 시 바디에 담아서 전달할 요청 파라미터를 지정합니다.
json – (선택적) 요청 시 바디에 담아서 전달할 JSON 타입의 객체를 지정합니다.
requests.post(url, params=None, **kwargs)
```

#### data 매개변수나 json 매개변수로 요청 파라미터를 지정하여 요청하는 것이 일반적

- data 매개변수 : 딕셔너리, 튜플리스트 형식, 바이트열(bytes) 형식으로 지정
- json 매개변수 : JSON 객체 형식 지정



#### requests.request(), requests.get(), requests.head(), requests.post() 함수 모두 리턴 값은 `requests.models.Response`객체

1. Text
   - **문자열** 형식으로 응답 콘텐츠 추출
   - 추출 시 사용되는 문자 셋은 'ISO-8859-1'이므로 'utf-8' 이나 'euc-kr' 문자 셋으로 작성된 콘텐츠 추출 시 한글이 깨지는 현상 발생
   - 추출 전 응답되는 콘텐츠의 문자 셋 정보를 읽고 `r.encoding = 'utf-8'`와 같이 설정한 후 추출
2. Content
   - **바이트열** 형식으로 응답 콘텐츠 추출
   - 응답 콘텐츠가 이미지와 같은 바이너리 형식인 경우 사용
   - 한글이 들어간 문자열 형식인 경우 `r.content.decode('utf-8')`를 사용해서 디코드 해야 함

```python
import requests

r = requests.request('get', 'http://unico2013.dothome.co.kr/crawling/exam.html')
r.encoding = 'utf-8'
print(type(r))
if r.text :
    print(r.text)
else :
    print('응답된 콘텐츠가 없어요')
print('----------------------------------------------------------')
r = requests.request('post', 'http://unico2013.dothome.co.kr/crawling/post.php', data= {'name':'백도', 'age' : 12})
r.encoding = 'utf-8' # 한글이 있을 경우 필수
print(type(r))
if r.text :
    print(r.text)
else :
    print('응답된 콘텐츠가 없어요')
print('----------------------------------------------------------')
r = requests.get('http://unico2013.dothome.co.kr/crawling/exam.html')
r.encoding = 'utf-8'
print(type(r))
print(r.headers)
if r.text :
    print(r.text)
else :
    print('응답된 콘텐츠가 없어요')
```

```python
urlstr = 'http://unico2013.dothome.co.kr/crawling/get.php'
r = requests.get(urlstr)
print(r.text)
print('------------------------------------')
r.encoding = 'utf-8'
print(r.text)
print('------------------------------------')
print(r.content) # 바이트열 형식으로 가져옴(한글은 형식지정 필요)
print('------------------------------------')
print(r.content.decode('utf-8'))
```

