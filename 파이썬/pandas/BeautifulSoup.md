# BeautifulSoup

- HTML 및 XML 파일에서 데이터를 추출하기 위한 파이썬 라이브러리
- 파이썬에서 기본적으로 제공하는 라이브러리가 아니므로 별도의 설치가 필요하지만 Anaconda에는 BeautifulSoup 패키지가 Site-packages로 설치되어 있음
- HTML 및 XML 파일의 내용을 읽을 때 다음 파서(Parser) 이용
  - html.parser
  - lxml
  - lxml-xml
  - html5lib
- 파이썬이 내장하고 있는 파서를 사용해도 되고, 좀 더 성능이 좋은 파서를 추가로 설치해서 사용해도 됨



### HTML 파싱

1. BeautifulSoup의 메인 API인 bs4 모듈에서 `BeautifulSoup()` 함수 임포트
2. 파싱할 HTML 문서와 파싱에 사용할 파서(구문 분석기)를 지정하여 호출하면, **bs4.BeautifulSoup** 객체 리턴
3. HTML 문서에 대한 파싱이 끝나면 트리 구조 형식으로 DOM 객체들이 생성되며, bs4.BeautifulSoup 객체를 통해 접근 가능

```
from bs4 import BeautifulSoup
bs = BeautifulSoup(html_doc, 'html.parser')
bs = BeautifulSoup(html_doc, 'lxml')
bs = BeautifulSoup(html_doc, 'lxml-xml')
bs = BeautifulSoup(html_doc, 'html5lib')
```

- 패키지 설치

```
conda install lxml
conda install html5lib
```



### bs4.BeautifulSoup 객체의 태그 접근 방법

#### HTML 문서를 파싱하고 bs4.BeautifulSoup 객체 생성

```
bs = BeautifulSoup(html_doc, 'html.parser')
```

- `<html>`, `<head>`태그와 `<body>` 태그는 제외하고 접근하려는 태그에 **계층 구조**를 적용하여 태그명을 `.` 연산자와 함께 사용

```
bs.태그명
bs.태그명.태그명
bs.태그명.태그명.태그명
```

- 태그명 추출
  - `bs.태그명.name`
- 속성 추출
  - `bs.태그명['속성명']`
  - `bs.태그명. attr`
- 콘텐츠 추출
  - `bs.태그명.string`
  - `bs.태그명.text`
  - `bs.태그명.contents`
  - `bs.태그명.string.strip()` : 공백 제거
  - `bs.태그명.text.strip()`

- 부모 태그 추출
  - bs.태그명.parent
- 자식 태그들 추출
  - bs.태그명.children
- 형제 태그 추출
  - bs.태그명.next_sibling
  - bs.태그명.previous_sibling
  - bs.태그명.next_siblings
  - bs.태그명.previous_siblings
- 자손 태그들 추출
  - bs.태그명.descendants



#### bs.find_all()

- 주어진 기준에 맞는 모든 태그들을 찾아와 bs4.element.ResultSet 객체로 리턴

```
find_all(name=None, attrs={}, recursive=True, text=None, limit=None, **kwargs)
```

- `find_all('div')`
- `find_all(['p','img'])`
- `find_all(True)`
- `find_all(re.compile('^b'))`
  - 정규표현식 : b로 시작하는 태그들
- `find_all(id='link2')`
- `find_all(id=re.compile("para$")`
  - 정규표현식 : para로 끝나는 태그들
- `find_all(id=True)`
- `find_all('a', class_="sister")`
  - class 예약어를 피하기 위해 `_` 추가
- `find_all(src=re.compile("png$"), id='link1')`

- `find_all(attrs={'src':re.compile('png$'), 'id':'link1'})`
- `find_all(text='example')`
- `find_all(text=re.compile('^test'))`
- `find_all(text=['example', 'test'])`
- `find_all('a', text='python')`
- `find_all('a', limit=2)`
  - 2개까지 찾음
- `find_all('p', recursive=False)`

#### bs.find()

- 주어진 기준에 맞는 태그 한 개를 찾아와 bs4.element.ResultSet 객체로 리턴
  - 가장 위에 있는 태그 리턴
  - 없으면 None 리턴

```
find(name=None, attrs={}, recursive=True, text=None, **kwargs)
```

- `find('div') == find_all('div', limit=1)` 
- `find(re.compile('^b')) == find_all(re.compile('^b'), limit=1)`

#### bs.select()

- 주어진 CSS 선택자에 맞는 모든 태그들을 찾아오며 결과는 list 객체로 리턴

```
select(selector, namespaces=None, limit=None, **kwargs)
```

- `select('태그명')`
- `select('.클래스명')`
- `select('#아이디명')` 
- `select('태그명.클래스명))`

##### HTML 문서의 트리 구조를 적용하여 태그를 찾을 수 있음

- `select('상위태그명 > 자식태그명 > 손자태그명')`
- `select('상위태그명.클래스명 > 자식태그명.클래스명')`   
- `select('상위태그명.클래스명   자손태그명')`              
- `select('상위태그명 > 자식태그명  자손태그명')`     
- `select('#아이디명 > 태그명.클래스명)`
- `select('태그명[속성]')`
- `select('태그명[속성=값]')`
- `select('태그명[속성$=값]')`
- `select('태그명[속성^=값]')`
- `select('태그명:nth-of-type(3)')`

