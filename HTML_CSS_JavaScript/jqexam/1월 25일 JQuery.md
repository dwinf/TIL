# 1월 25일 JQuery

> 스크립트 코드를 단순화하도록 설계된 자바스크립트 라이브러리
>
> jQuery가 적용된 소스는 크롬의 elements탭에서 확인 가능
>
> API 사용법이 일관성이 있어 API를 익히기 쉽다.

### 주요 기능

- DOM 요소 선택 기능, DOM 탐색 및 수정
- CSS 셀렉터에 기반한 DOM 조작
- 크로스 브라우징 이벤트 처리
- 특수효과 및 애니메이션
- AJAX
- JSON 파싱
- 플러그인을 통한 확장성

---

### domaccess

----

#### jQuery 라이브러리 선언

```javascript
<script src="http://code.jquery.com/jquery-xxx.js"></script>
```

- jQuery가 사용되는 script태그보다 먼저 선언



#### jQuery 메서드 호출

```javascript
jQuery(자바스크립트객체).xxx()
jQuery.xxx()
```

- jQuery() 대신 $() 사용 가능

```javascript
$(document).xxxx()
$('CSS선택자').xxxx() // 돔로 포장해 객체를 처리
$(함수)	//문서를 로드한 후 처리 == onload == $(document).ready(함수)
$.xxxx()	//jQuery 객체가 제공하는 클래스메서드
$('HTML태그문자열')
$('CSS선택자', context).xxxx()	//context = dom객체
```



##### example

```javascript
$(document).ready(function () {
    alert('First READY');
});        
$(function () {		//로드 이벤트 발생 시 처리할 함수
	alert('Final READY');
});  
```

- $().ready : 페이지 로드가 끝나면 실행
- $('button').click(함수) : onclick 구현

```javascript
$(document).ready(function () {	//페이지 로드가 완료되면
	$('*').css('color', 'Red');
	$('h1, p').css('color', 'Orange');
    $('#target').css('color', 'Orange');
    $('h1#target').css('color', 'Orange');
});
```

- `$('*')` : 모든 태그를 찾아 처리
- `$('#target')` : id = "target"인 객체를 찾음
- `$('h1#target')` : h1 태그 중 id = "target"



```javascript
<script>
    $(document).ready(function () {
       	$('.item').css('color', 'Orange');
       	$('h1.item').css('background', 'Red');
       	$('.item.select').css('border', '2px solid black');
		$('.item:not(.select)').css('border', '2px solid green');
       });
</script>
<body>
    <h1 class="item">Header-0</h1>
    <h1 class="item select">Header-1</h1> //class는 공백을 구분자로 사용
    <h1 class="item">Header-2</h1>
    <h2 class="item">Header-0</h2>
    <h2 class="item select">Header-1</h2>
    <h2 class="item">Header-2</h2>
    <h2 class="select">Header-3</h2>
</body>
```

- `$('.item:not(.select)')` : item 이지만 select는 아닌 클래스



```javascript
$('ul *').css('color', 'red');
$('body > div > div').css('font-weight', 'bold');
```

- `$('ul *')` : ul 태그의 모든 자손 태그
- `$('body > div > div')` : `>` 는 자손 태그를 의미. body 태그 밑에 div 태그 밑에 div 태그



```javascript
$(document).ready(function () {
	setTimeout(function () {
		var value = $('select > option:selected').val(); //getter
		alert(value);
		$('#valtest').val(function(p1, p2) {	//setter
			return p1+":"+p2+":hahaha";
		}); 
	}, 5000);	// 5초 후에 코드를 실행
});
```

- `$('select > option:selected')` : 선택지 중 선택한 항목



---

### domedit

---



#### jQuery의 API

아규먼트 양식이 비슷함(공백, 문자열, 함수)

- html() - innerHTML
- text() - textContent
- val() - value

아규먼트가 공백일 경우 getter(값을 읽음)로 사용

​	html(), val() - 첫번째 태그만 읽음

​	text() - 모두 읽음

아규먼트가 문자열, 함수일 경우 setter(값을 설정)로 사용



- css()

- attr()

css("css속성명")

attr("html태그속성명")

----------------getter로 사용(값을 읽음)

css("css속성명", "css속성값")

attr("html태그속성명", "html태그속성값")

css("css속성명", 함수)

attr("html태그속성명", 함수)

css(자바스크립트 객체)

attr(자바스크립트 객체)

----------------setter로 사용(값을 설정)



```javascript
<script>
	$(document).ready(function () {
	$('h1').addClass('item');
	});
</script>
<style>
	.item {
		background-color : yellow;
	}
</style>
<h1>Header-0</h1>
<h1 class="test">Header-1</h1>
<h1>Header-2</h1>
```

- `$('h1').addClass('item');` : h1태크를 모두 찾아 item이라는 클래스를 추가



```javascript
$(document).ready(function () {
	$('h1').addClass(function (index) {
	return 'class' + index;
	});
});
$(document).ready(function () {
	$('h1').removeClass('select');
});
```

- `$('h1').addClass(function (index)` : 찾아진 태그에 인덱스를 추가
- `$('h1').removeClass('select');` : h1태그 안에서 select라는 클래스명 삭제



#### attr()

```javascript
//attr("html태그속성명", "html태그속성값")
$(document).ready(function () {
	$('img').attr('width', 200);
});
//attr("html태그속성명", 함수)
$(document).ready(function () {
	$('img').attr('width', function (index) {
		return (index + 1) * 100;
	});
});
//attr(자바스크립트 객체)
$(document).ready(function () {
	$('img').attr({
        width: function (index) {
			return (index + 1) * 100;
		}, height: 100
	});
});
$(document).ready(function () {
	$('h1').removeAttr('data-index'); //태그의 속성 삭제
});
<h1 data-index="0">Header-0</h1>
```

- `$('h1').removeAttr('data-index');` : h1태그의 data-index를 제거



#### css()

```javascript
//css("css속성명")
$(document).ready(function () {
	$('h1').each(function(index,data) {
		var color = $(data).css('color');
		alert(color); 
	});
	/*var color = $('h1').css('color');	//h1태그 중 첫번째만 읽음
	alert(color);*/
});
//css("css속성명", 함수)
$(document).ready(function () {
	var color = ['Red', 'White', 'Purple'];	// 변수를 선언
	$('h1').css('color', function (index) {	// 문서 객체의 스타일을 변경
		return color[index];
	});
});
//css(자바스크립트 객체)
$(document).ready(function () {
	var color = ['Red', 'White', 'Purple'];	// 변수를 선언
	$('h1').css({	// 문서 객체의 스타일을 변경
		color: function (index) {
			return color[index];
		}, backgroundColor: 'Black'
	});
});
```

- `.each(함수)` : 찾아진 모든 태그에 대해 함수 호출



#### html(), text(), val()

```javascript
$(document).ready(function () {           
	/*  var html = $('h1').html();	//html(),val()은 첫번째 h1태그만 읽어옴
	alert(html);   */
	$('h1').each(function(index, data){
		var html = $(data).html();
		alert(html);
	});
});

$(document).ready(function () {
	var text = $('h1').text();	// text()는 해당하는 태그를 모두 읽어옴
	alert(text);	// 출력
});


$(document).ready(function () {
	$('.g1').html('<h1>$().html() Method</h1>');	//h1태그를 적용하여 출력
	$('.g2').text('<h1>$().html() Method</h1>');	//태그를 문자열로 출력
});


$(document).ready(function () {
	$('div').html(function (index) {
		return '<h1>Header-' + index + '</h1>';
	});
});

/*$(document).ready(function () {	//페이지가 로드되면 실행
	$('h1').html(function (index, html) {   //첫번째는 무조건 인덱스를 받기 때문에 사용하지 않더라도 매개변수를 줘야 한다.
	return '★' + html + '★';   // 결합연산자
	});
}); */
$(document).ready(function () {
	$('h1').click(function () {
		$(this).text(function (a, b) {
			//alert(a + ":" +b);
			return '★' + b + '★';   // 결합연산자
		});
	});
});

$(document).ready(function () {	//태그를 삭제
	$('h1').first().remove();	//첫번째 태그를 삭제
	//$('div').remove();	//div태그를 삭제
    $('div').empty();	//div태그를 비움
});

$(document).ready(function () {
	$('<h1></h1>').html('Hello World .. !').appendTo('body');
	$('<h1>안녕하세요.... !</h1>').appendTo('body');
});

//$('HTML태그문자열')
$(document).ready(function() {
	$('<img/>', {
		src : 'Jellyfish.jpg',
		width : 350,
		height : 250
	}).appendTo('body');
	$('<img />').attr('src', 'Chrysanthemum.jpg').appendTo('body'); //원본크기
});


$(document).ready(function () {
	// 변수를 선언합니다.
	var h1 = '<h1>Header1</h1>';
	var h2 = '<h2>Header2</h2>';
	// 문서 객체를 추가합니다.
	$('body').append(h1, h2, h1, h2);
});
```



---

### domevent

jQuery의 이벤트 핸들러 구현

1. $('...').on('이벤트이름', 함수)

   $('...').on(자바스크립트객체)

   

   $('...'),off() : 등록된 이벤트 핸들러를 해제

   

2. $('...').이벤트이름(함수)



```javascript
<style>
    .reverse {
        background: Black;
        color: White;
    }
</style>
```

```javascript
$(document).ready(function () {
	$('h1').on('click', function () {
		$(this).html(function (index, html) {
			return html + '+';
		});
	});

	$('h1').on({
		mouseenter: function () { $(this).addClass('reverse'); },
		mouseleave: function () { $(this).removeClass('reverse'); }
	});              
});

$(document).ready(function () {
	$('h1').hover(function () {
		$(this).addClass('reverse');
	}, function () {
		$(this).removeClass('reverse');
	});
});

$(document).ready(function () {
	$('h1:first').on("click", function () {
		$(this).html('ONE CLICK');	// 출력합니다.
		alert('이벤트가 발생했습니다.');
		$(this).off();  //이벤트핸들러 해제 == 이벤트 제거
	});
	$('h1:last').one('click', function () {
		$(this).html('ONE CLICK');	// 출력합니다.
		alert('이벤트가 발생했습니다.');           
	});
});

$(document).ready(function () {
	$('div').click(function () {
		var header = $('h1', this).text();//this를 안주면 모든 h1태그의 내용을 읽음
		var paragraph = $('p', this).text();//this 없으면 모든 p태그의 내용을 읽음
		alert(header + '\n' + paragraph);
	});
});
```

