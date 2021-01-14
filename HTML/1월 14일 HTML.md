# 1월 14일 HTML

기본적으로 크롬 브라우저를 이용, 크롬 외 브라우저 1개 필요(엣지, 익스플로러 등)

HTML : 네이버, 구글 등 웹페이드를 만드는데 대표적으로 쓰이는 웹프로그래밍 언어

#### 웹 프로그래밍 기술 - 클라이언트 

웹 사이트를 구축하려면 웹 페이지를 먼저 개발해야 한다.

- HTML(Hyper Text Markup Language)
  - 제어문, 함수가 없다.
  - 텍스트, 이미지, 동영상 등을 어떻게 표현할지를 정하는 언어
  - 마크업 방식으로 구현
  - 클릭 시 페이지가 이동되는 텍스트 : 하이퍼링크 텍스트
  - 텍스트에 붙는 태그에 따라 기능이 달라진다.
    - 시작태그와 종료태그가 쌍으로 이루어진다.(더블사이드 태그)
    - 테그에 따라 종료태그는 없을 수 있다.(싱글사이드 태그)
  - `<h1>올라프</h1>`
  - 속성값을 줄 때는 인용부호로 묶는 것이 좋음

- CSS(Cascading Style Sheets)

  - 스타일시트
  - HTML 태그에 의해서 웹 페이지가 출력(랜더링)될 때 스타일을 조정할 수 있는 기술

  - `<h1 style="color : orange;background-color : gree">올라프</h1>`

  ```css
  <style>
  	h1{
  		color : orange;
  		background : green;
  	}
  </style>
  ```

- JavaScript
  - 웹 페이지를 만들 때 프로그래밍적으로 처리해야 하는 기능이 있을 때 사용하는 주로 웹 개발에서 사용되는 프로그래밍 언어
  - 브라우저에서 수행 가능한 프로그래밍 언어
    - 거의 모든 언어는 브라우저에서 수행 불가능함
    - 하지만 대부분의 브라우저에서는 자바스크립트 인터프리터(엔진)를 내장하고 있다.
    - 즉, 동적인 웹 페이지(상황에 따라 웹 페이지가 바뀌는) 개발에 필수 기술이다.



#### URL(Uniform Resource Locator)

- 웹 자원의 위치를 알려주는 단일화된 형식의 문자열

- 일반적으로 웹 사이트의 주소 문자열로 알고 있음

- `프로토콜명://서버도메인명(IP주소):포트번호/패스/...(패스가 다수일 경우)/파일명`

  - http(https)://naver.com/ -> 네이버 웹 사이의 indexhtml(기본파일, 웰컴파일)
  - https는 보안의 차이

  - https://www.google.com/search?q=%EC%9D%BC%EA%B8%B0+%EC%98%88%EB%B3%B4&oq=%EC%9D%BC%EA%B8%B0+%EC%98%88%EB%B3%B4&aqs=chrome..69i57j0l7.10632j1j7&sourceid=chrome&ie=UTF-8
  - search 이후부터는 sql문

- url 작성시 포트번호가 80이면 생략 가능

  - 실습은 8000이어서 명시해야함
  - http://localhost:8000/ 또는 127.0.0.1:8000/



### HTML 태그

- `<hr>` : 수평선을 그려준다.
- `<h1>제목-1</h1>` : 제목 1
- `<h2>제목-2</h2>` : 제목 2
- `<h3>제목-3</h3>` : 제목 3
- `<h4>제목-4</h4>` : 제목 4



#### URL

- `<a href="http://www.python.org"/>PYTHON</a>` : 하이퍼링크
  - http://www.python.org 주소로 이동. 웹 페이지에는 PYTHON으로 표기



#### 이미지

- `<img src="http://localhost:8000/edu/images/olaf.jpg">`
  - 절대주소를 이용해 이미지를 가져옴

```html
<img src="http://localhost:8000/edu/images/olaf.jpg">
<img src="/edu/images/duke.png">
<img src="../images/r4.gif">
```

- 모두 이미지를 정상적으로 출력
  - jpg, png, gif 순으로 해상도가 좋다
- `../images/r4.gif/`는 상대 경로를 이용
  - 같은 서버를 이용하는 경우에만 사용 가능
- 사이즈를 지정하지 않으면 이미지의 원본크기로 출력

```html
<img src="http://localhost:8000/edu/images/olaf.jpg" width="200">
<img src="/edu/images/duke.png" width="200">
<img src="../images/r4.gif" width="200">
```

- `width`를 이용해 너비 조정. 비율도 같이 조정된다.

```html
<img src="http://localhost:8000/edu/images/olaf.jpg" width="200" height="100">
<img src="/edu/images/duke.png" width="100" height="500">
<img src="../images/r4.gif" width="50" height="50">
```

- `height`를 이용해 높이 조정

```html
<figure>
    <figcaption>올라프</figcaption>
<img src="http://localhost:8000/edu/images/olaf.jpg" width="200" height="100">
</figure>
<figure>
    <img src="/edu/images/duke.png" width="100" height="500">
    <figcaption>듀크</figcaption>
</figure>
```

- 이미지를 figure로 감싸고 figcaption으로 제목을 붙임
- figcaption의 위치에 따라 이미지 위나 아래에 제목이 출력됨



#### 테이블 생성

- `<tr>` : 테이블 행
  - 원하는 행의 갯수만큼 추가
- `<td>` : 제목 행
  - 자동으로 가운데 정렬

- `<td>` : 본문 행
  - `<tr></tr>`로 감싸진 곳에 `<td></td>`로 감싸진 영역에 넣고자 하는 내용 입력



#### 비디오

- autoplay 
  - 크롬에서는 지원하지 않음, 사용시 비디오가 보이지 않는다.
- controls

```html
<source src="trailer.mp4">
<source src="trailer.ogg">
```

- 브라우저마다 mp4만 지원할 수 있고, ogg만 지원할 수 있기 때문에 둘 다 지정
  - 크롬은 둘 다 지정
  - ogg -> mp4, mp4 -> ogg로 변환 가능
  - 하나만 지정해도 상관 없다



- `<em></em>` : 특정 문자열을 강조
  - 이탤릭체로 표시됨

