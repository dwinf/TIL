# 1월 15일 HTML

## HTML

- HTML의 태그는 대소문자를 구분하지 않는다.
- HTML에서는 개행문자(엔터)가 공백으로 처리된다.
  - 개행을 위한 다른 방법이 필요
  - `<hr>`은 수평선을 긋기 위해 자동으로 개행처리
- `<>`는 태그를 구분하기 때문에 화면에 출력할 수 없다.
  - `&lt;`, `&gt;` 으로 감싸면 웹에서는 <>로 출력된다.
- `<!-- content -->` : 주석처리
- `<br>` : 개행처리를 위한 태그. 단일사이드 태그이다.
- `<p></p>`로 감싸면 문자열을 출력하고 개행처리
  - `<br>`과 다른 점은 `<p>`는 개행처리가 2번 일어난다.

```html
CSS 작성 방법<br>
자바스크립트 프로그래밍<JQuery도 조금 학습 해요><br>

<p>장고 프로그래밍(DB 연동, AJAX)</p>
```

### input type

>  text, password, summit, reset, checkbox, radion number, datetime-local, date 등

```html
    계정 <input type="text" name="account" required>
    패스워드 <input type="password" name="pwd" required>
    <input type="submit" value="로그인">
    <input type="reset" value="재작성">
    <input type="checkbox" name="food" value="f1">불고기<br>
    <input type="checkbox" name="food" value="f3" checked>햄버거<br>
    <input type="radio" name="fcolor" value="파란색"checked>파란색<br>
    <input type="radio" name="fcolor" value="노란색">노란색<br>
    <input type="number" name="age" min="1900" max="2021"><br><br>
    <input type="datetime-local" name="birth"><br><br>
    <input type="date" name="birth"><br><br>
```

- text: 문자열을 입력한다.
- password : 입력한 문자열이 공개되지 않는다.
- required : 반드시 입력해야하는 곳에 설정
- submit : 입력한 것을 전송
- reset : 입력한 것을 모두 지움
- checkbox : 복수의 문항을 선택할 수 있다.
- radio : 문항 중 한가지만 선택
  - checked : 선택지를 미리 선택해둘 수 있다.
  - 같은 이름(name)으로 묶어야 같은 그룹으로 묶임
  - `check` : 체크가 된 상태로 웹에 표기
- number : 숫자를 선택할 수 있다
  - `min`,`max`로 최소 최대값 지정

- datetime-local : 년-월-일-오전/오후-시-분
- date : 년-월-일



```html
<select name="year">
        <option value="2001">2001</option>
        <option value="2002">2002</option>
        <option value="2003">2003</option>
        <option value="2004">2004</option>
        <option value="2005">2005</option>
</select><br><br>

<textarea name="memo" rows="5" cols="50"></textarea><br><br>

```

- select : option으로 설정한 것을 드롭다운 리스트를 통해 선택
- textarea : 5행 50열 크기의 문자열 입력 영역
