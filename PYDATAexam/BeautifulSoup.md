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

- HTML 문서를 파싱하고 bs4.BeautifulSoup 객체 생성

```
bs = BeautifulSoup(html_doc, 'html.parser')
```

- `<html>`, `<head>`태그와 `<body>` 태그는 제외하고 접근하려는 태그에 **계층 구조**를 적용하여 태그명을 `.` 연산자와 함께 사용

```
bs.태그명
bs.태그명.태그명
bs.태그명.태그명.태그명
```

- HTML 문서의 내용을 파싱하여 BeautifulSoup 객체 생성

```

```


