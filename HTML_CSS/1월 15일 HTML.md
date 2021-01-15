# 1월 15일 HTML

- HTML의 태그는 대소문자를 구분하지 않는다.
- HTML에서는 개행문자(엔터)가 공백으로 처리된다.
  - 개행을 위한 다른 방법이 필요
  - `<hr>`은 수평선을 긋기 위해 자동으로 개행처리
- `<>`는 태그를 구분하기 때문에 화면에 출력할 수 없다.
  - `&lt;`, `&gt;` 으로 감싸면 웹에서는 <>로 출력된다.
- `<br>` : 개행처리를 위한 태그. 단일사이드 태그이다.
- `<p></p>`로 감싸면 문자열을 출력하고 개행처리
  - `<br>`과 다른 점은 `<p>`는 개행처리가 2번 일어난다.

```
CSS 작성 방법<br>
자바스크립트 프로그래밍<JQuery도 조금 학습 해요><br>

<p>장고 프로그래밍(DB 연동, AJAX)</p>
```

라디오버튼

체크박스

- 같은 이름(name)으로 묶어야 같은 그룹으로 묶임
- `check` 체크가 된 상태로 웹에 표기
- `min`,`max`로 최소 최대값 지정

---

exam3.html 정리하기

---

`<!-- content -->` : 주석처리

## CSS

.html에서 css를 사용하기 위해서는 css구문에 맞춰 작성해야 한다.

동일한 html문서에 CSS파일만 변경해도 웹사이트를 꾸밀 수 있다.

```html
    <style>
        h2 {
            color : green
        }
    </style>
    
    <h2 style="color:blue">좋아하는 음식</h2>
```

- 전역적인 방식, 지역(inline)적인 방식
  - 전역방식은 문서 전체를 수정
  - 하지만 inline으로 선언된 것이 있다면 inline을 우선한다.

```html
<h1 style="color:red;background-color:green;text-align:center">태그 학습</h1>
```

- background-color : 문자열의 배경색 설정
- text-align:center : 문자열을 가운데 정렬



#### 전역

```html
    <style>
        h1 {
            color:red;
            background-color:green;
            text-align:center;
            text-shadow:2px 2px 3px white;
        	font-size : 3em;
           	font-size : 50pt;
        }
     </style>
```

- `text-shadow:2px 2px 3px white;` : 텍스트의 번짐효과 설정
  - 범위를 지정하는 경우 단위(px)는 반드시 기재해야 한다!
- `font-size : 3em;` : 폰트 사이즈를 3배
- `font-size : 50pt;` : 폰트 사이즈를 50pt



```html
 	<style>
 		a{
            text-decoration : none;
            margin-right : 30px
        }
    </style>
```

- a 태그의 문자열에서 밑줄을 지움
- `margin-right : 30px` : 오른쪽 문자열과 30px만큼 간격을 조정

```html
 a:hover{
            font-weight : bold;
        }
```

- hover : 커서를 올렸을 때 동장
  - `font-weight : bold;`커서를 위에 올리면 문자열이 굵게 변함

```html
		img{
            opacity:0.3; /* 0.0~1.0 */
        }
        img:hover{
            opacity:1.0;
        }
```

- /* */ : css 주석처리
- opacity : 투명도를 조정(0.0 ~ 1.0)
- hover : 커서를 올렸을 때

---

html - exam3, exam1_css

---

웹클라이언트 31~ 37p



### CSS 선택자

스타일을 적용하기 위해 대상을 선택하는 방법



  전체 선택자

  페이지에 있는 모듞 요소를 대상으로 스타읷을 적용할 때 사용 

 다른 선택자와 함께 모든 하위 요소에 핚꺼번에 스타읷을 적용하려고 할 때 주로 사용 예) * { margin:0; padding:0;} 



 태그 선택자 

 문서 안의 특정 태그에 스타일이 모두 적용됨 예) p { font-size:12px; font-family: "돋음"; } 



 클래스 선택자 : 

 문서 앆에서 여러 번 반복할 스타일이면 클래스 선택자로 정의하며 . 뒤에 클래스 이름 지정 예) .redtext { color:red; } 



 id 선택자 

 문서 안에서 한번만 사용한다면 id 선택자로 정의하며 파운드(#) 다음에 id 이름 지정 예) #pic2 { clear:both; float:left; }



[속성 $= 값] : 자주 쓰임

`img[src$=png]`



exam3.html

width 값의 단위를 %로 주면 화면 크기에 따라 크기가 변하게 된다.



exam4.html

블럭 스타일 태그

`<div>` : 태그를 사용하면 그 행을 전부 사용한다.

인라인 스타일 태그

`<span>` : 문자열만큼 공간을 사용한다.



exam4_1

padding - 컨텐트와 배경에 얼만큼의 간격을 둘지

margin : 다른 컨텐트(웹 테두리나 다른 문자열 등)와의 간격



exam4-2

width, height는 인라인 스타일 태그에서는 의미 없다

- img같은 몇몇을 제외



exam6

margin-top, margin-right, margin-bottom, margin-left

margin:10px 20px 30px 40px(위 오른 왼 아래)

margint:10px 20px 30px(위 아래 좌우)

margin:10px 20px(위아래 좌우)







