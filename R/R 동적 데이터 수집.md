# R 동적 데이터 수집

> 크롤링
>
> 웹 페이지의 내용이 동적으로 생성되는 경우에는 스크랩핑 방식으로는 수집할 수 없다.



## 1. 동적 페이지란

>  사용자의 선택과 같은 이벤트에 의해서 자바스크립트의 수행 결과로 컨텐츠를 생성 
>
> 페이지의 렌더링을 끝낸 후에 **Ajax** 기술을 이용하여 서버로 부터 컨텐트의 일부를 전송받아 동적으로 구성

### (1) 동적 데이터수집이 필요한 이유

- 동적페이지는 페이지소스보기에서 내용이 나오지 않는다.
- 페이지 소스보기에서는 html내용만 나오고 자바스크립트가 렌더링되기 전 소스를 보여준다.
  - 스크래핑을 할 수 없는 이유
- 크롬 개발자 도구에서의 소스는 자바스크립트 수행이 끝난 상태의 소스를 보여준다

### (2) 동적 데이터 수집이 필요한 경우

- 더보기 버튼같이 컨텐츠를 보기 위한 추가적인 동작이 필요한 경우
- ajax를 통한 페이지 변경이 있는 경우
  - 댓글, 스크롤 이동 등



#### 위 같은 경우 Selenium을 이용하여 동적 데이터 수집(크롤링)을 한다.



## 2. 동적 데이터 수집 준비

### (1) Selenium 서버 기동

1. cmd 창에서 selenium이 위치한 폴더로 이동
2. 명령어를 통해 Selenium 서버를 기동기킨다.

```
java -Dwebdriver.chrome.driver="chromedriver.exe" -jar selenium-server-standalone-4.0.0-alpha-1.jar -port 4445
```

### (2) RStudio

1. Selenium을 사용하기 위한 패키지를 설치하고 장착시킨다.

```R
install.packages("RSelenium")
library(RSelenium)
```

2. Selenium 서버에 접속하여 브라우저 오픈

```R
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
```



## 3. R을 이용한 동적 데이터 수집

### (1) API

| 코드                                                         | 기능                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| remDr <- remoteDriver(remoteServerAddr="localhost", port=4445,browserName="chrome") | R 코드로 Selenium 서버에 접속하고 remoteDriver 객체 리턴     |
| remDr$open()                                                 | 브라우저 오픈(크롬)                                          |
| remDr$navigate(url)                                          | url 에 해당하는 웹페이지 랜더링                              |
| one <- remDr$findElement(using='css selector',‘css선택자')   | 태그 **한 개** 찾기(webElement 객체)<br />태그가 없으면 NoSuchElement 오류 발생 |
| one$getElementTagName()                                      | 찾아진 태그의 태그 명 추출<br />(webElement 객체가 제공)     |
| one$getElementText()                                         | 찾아진 태그의 태그 내용 추출(webElement 객체가 제공)         |
| one$getElementAttribute("속성명")                            | 찾아진 태그의 속성 명에 대한 값 추출 <br />(webElement 객체가 제공) |
| one$clickElement()                                           | 찾아진 태그에서 클릭이벤트 발생시키기<br />(webElement 객체가 제공) |
| doms <- remDr$findElements(using ="css selector", "컨텐트를추출하려는태그의 CSS선택자") | (0개 이상)태그들을 찾기 <br />존재하지 않으면 비어있는 리스트 리턴 |
| sapply(doms,function(x){x$getElementText()})                 | 찾아진 태그들의 컨텐트들의 추출하여 리스트로 리턴            |
| **sapply(doms, function(x){x$clickElement()})**              | 찾아진 태그들에 각각 클릭 이벤트 발생                        |
| **remDr$executeScript("arguments[0].click();",nextPageLink)** | 가끔 clickElement() 가 작동하기 않는 경우 사용하면 좋음      |
| webElem <- remDr$findElement("css selector", "body")<br /> **remDr$executeScript**("scrollTo(0, document.body.scrollHeight)", args = list(webElem)) | 페이지를 아래로 내리는(스크롤) 효과                          |



### (2) Selenium 사용

```R
install.packages("RSelenium") # R에서 selenium을 사용하기 위한 패키지 설치
library(RSelenium)

# Selenium 서버에 접속
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
# Selenium 서버에 의해 제어되는 브라우저 기동(크롬)
remDr$open() 

# 지정된 URL 페이지 를 요청하고 랜더링(자바스크립트코드 수행)
remDr$navigate("http://www.google.com/")

# 태그에 대한 DOM 객체 찾기, 클래스, id, 태그명 등을 통해 검색
webElem <- remDr$findElement(using = "css selector", "[name = 'q']") # xpath로도 가능
# <input> 태그에 텍스트 입력하고 엔터키 입력을 자동화 하기
webElem$sendKeysToElement(list("PYTHON", key = "enter")) # 검색

remDr$navigate("http://www.naver.com/")

webElem <- remDr$findElement(using = "css selector", "#query")
webElem$sendKeysToElement(list("PYTHON", key = "enter"))
```

#### 1. findElement

```R
# 이해를 돕기 위해 간단한 웹페이지를 크롤링하고 스크래핑 함
url <- "http://unico2013.dothome.co.kr/crawling/tagstyle.html"
remDr$navigate(url)

#단수형으로 노드 추출 using=css selector 
one<-remDr$findElement(using='css selector','div') # 노드 한 개 리턴(webElement 객체)
one$getElementTagName()
one$getElementText()
one$getElementAttribute("style")

# 단수형으로 없는 노드 추출
one<-NULL
one<-remDr$findElement(using='css selector','p') # 없으면 오류 발생

# 만일 오류 발생을 무시하고 싶어서 사용하지만 소용없음, 외부 라이브러리 사용 때문이라 추정(^^)
# 없을 수도 있으면 복수형(findElements()) 사용할것(0개 이상을 탐색하기 때문)
one<-NULL
try(one<-remDr$findElement(using='css selector','p')) 
```

- 선택된 태그에 해당하는 객체를 1개 리턴
- 여러 개라면 첫 번째로 탐색된 객체 리턴

#### 2. findElements

````R
#복수형으로 노드 추출
more<-remDr$findElements(using='css selector','div')
sapply(more, function(x) x$getElementTagName())
sapply(more, function(x) x$getElementText())

#복수형으로 없는 추출
more<-remDr$findElements(using='css selector','p') # 없으면 오류가 발생하지 않음 비어있는 리스트 리턴
print(more)  
if(length(more) == 0) 
  cat("<p> 태그는 없슈\n")
sapply(more, function(x) x$getElementTagName())
sapply(more, function(x) x$getElementText())
````

- o개 이상을 탐색해 리턴하기 때문에 없어도 오류발생X

#### 3. clickElement()

```R
url <- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
remDr$navigate(url)

one<-remDr$findElement(using='css selector','a:nth-of-type(4)')
one$getElementTagName()
one$getElementText()
one$clickElement()

url <- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
remDr$navigate(url)

one<-remDr$findElement(using='css selector','a:nth-of-type(3)')
one$getElementTagName()
one$getElementText()
remDr$executeScript("arguments[0].click();",list(one)); # 목록을 리스트로 줘야하기 때문에 형변환
# 자바스크립트를 이용해 클릭, clickElement()가 안될 때 사용
```