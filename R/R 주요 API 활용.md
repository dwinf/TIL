# R 주요 API 활용

- install.packages() 
- library() : 파이썬의 import와 유사
- `::` : 패키지 안의 특정 함수를 사용하고자 할 때
  - `base::sum`
- data(iris) : 특정 데이터셋을 로드할 때



## 1. 날짜와 시간 관련 함수

- 현재 날짜: `Sys.Date()`
- 현재 날짜 및 시간: `Sys.time()`
- 미국식 날짜 및 시간: `date()`
- Date (날짜), POSIXct, POSITIT (날짜와 시간)

```R
today <- Sys.Date() #연월일 정보의 date 타입
# "2021-03-03" 
str(today)	# Date[1:1], format: "2021-03-03"
Sys.Date() # 연월일
Sys.time() # 연월일 시분초 "2021-03-03 12:40:17 KST"
str(Sys.time())	# POSIXct[1:1], format: "2021-03-03 12:40:37"
Sys.timezone()	# "Asia/Seoul"
```

### (1) 문자열을 시간으로 변경

- `as.Date()` : **년월일 시분초** 타입의 문자열을 시간으로 변환

```R
as.Date("년-월-일 시:분:초")` 또는 `as.Date("년/월/일 시:분:초")
as.Date('2018/1/15')
```

- `format`을 통해 출력 형식 지정

```R
as.Date("날짜 및 시간 문자열", format="포맷") # format = 은 생략 가능
as.Date('4월 26, 2018',format='%B %d, %Y')
as.Date('110228',format='%d%b%y') 
as.Date('110228',format='%y%m%d') 
as.Date('11228','%d%b%y') 
```

| Symbol | Mean          | Symbol | Mean             |
| ------ | ------------- | ------ | ---------------- |
| %d     | 일(01-31)     | %b     | 축약 월(3)       |
| %a     | 축약 요일(수) | %B     | 월(3월)          |
| %A     | 요일(수요일)  | %y     | 연도 2자리(21)   |
| %m     | 월(01-12)     | %Y     | 연도 4자리(2021) |

```R
format(today, "%d %B %Y")

as.Date('1/15/2018',format='%m/%d/%Y')

as.Date('4월 26, 2018',format='%B %d, %Y')

as.Date('22118',format='%d%b%y') 
```

### (2) 날짜 데이터의 연산

- 날짜 데이터 끼리 연산이 가능하다.
- 날짜끼리 뺄셈 가능, 날짜와 정수의 덧셈 뺄셈 가능 (하루를 1로 간주, 소숫점 생략)
- 날짜 데이터끼리 연산할 때 소숫점을 표현하고자 하는 경우는 `as.Date` 대신에 `as.POSIXct` 함수를 이용

```R
as.Date("2020/01/01 08:00:00") - as.Date("2020/01/01 05:00:00") # 날짜만 표현하기 때문에 0
# Time difference of 0 hours
as.POSIXct("2020/01/01 08:00:00") - as.POSIXct("2020/01/01 05:00:00")
# Time difference of 3 hours
as.POSIXlt("2020/01/01 08:00:00") - as.POSIXlt("2020/01/01 05:00:00")
# Time difference of 3 hours
```



### (3) weekdays(), months(), quarters()

- 요일/ 월 / 분기

```
weekdays(today); months(today); quarters(today)
```

### (4) unclass()

- 객체 상태를 해제해주는 함수

- 1970-01-01을 기준으로 얼마나 날짜가 지났는지 보여준다.

```R
unclass(today) # 1970-01-01을 기준으로 얼마나 날짜가 지났는지의 값을 가지고 있다.
x1 <- "2019-01-10"
# 문자열을 날자형으로
as.Date(x1, "%Y-%m-%d") 
# 문자열을 날짜+시간형으로
strptime(x1, "%Y-%m-%d") 
x2 <- "20180601"
as.Date(x2, "%Y%m%d")
strptime(x2, "%Y%m%d")

as.Date("2018/01/01 08:00:00") - as.Date("2018/01/01 05:00:00")
as.POSIXct("2018/01/01 08:00:00") - as.POSIXct("2018/01/01 05:00:00")
as.POSIXlt("2018/01/01 08:00:00") - as.POSIXlt("2018/01/01 05:00:00")

t<-Sys.time()
ct<-as.POSIXct(t); 
lt<-as.POSIXlt(t)
unclass(ct); 
unclass(lt); lt$mon; lt$hour; lt$year+1900

as.POSIXct(1449894437,origin="1970-01-01")
as.POSIXlt(1449894437,origin="1970-01-01")
```



## 2. 정규표현식 (Regular Expression)

- 특정한 규칙을 가진 문자열의 집합을 표현하는데 사용하는 형식언어
- ABCDEFG.......Z → [A-Z]
- abc....zABC....Z → [a-zA-Z]
- 가각갂간.........힣 → [가-힣]
- 0123456789 → [0-9]
- 010-1234-5678 → [0-9]{3}-[0-9]{4}-[0-9]{4}
- `grep`,`gsub`은 **첫번째 아규먼트**로 `정규표현식`을 쓸 수 있다.

```R
 word <- "JAVA javascript Aa 가나다 AAaAaA123 %^&*"
gsub(" ", "@", word); sub(" ", "@", word)
gsub("A", "", word) 
gsub("a", "", word) 
gsub("Aa", "", word) 
gsub("(Aa)", "", word) 
gsub("(Aa){2}", "", word);gsub("Aa{2}", "", word) 
gsub("[Aa]", "", word) 
gsub("[가-힣]", "", word) 
gsub("[^가-힣]", "", word) # ^은 부정을 의미
gsub("[&^%*]", "", word) 
gsub("[[:punct:]]", "", word) # 특수문자 제거
gsub("[[:alnum:]]", "", word) # 특수문자, 공백 제외 제거
gsub("[1234567890]", "", word) 
gsub("[0-9]", "", word) 
gsub("\\d", "", word); gsub("\\D", "", word)
gsub("[[:digit:]]", "", word) 
gsub("[^[:alnum:]]", "", word) 
gsub("[[:space:]]", "", word)  # 공백 제거
gsub("[[:punct:][:digit:]]", "", word) 
gsub("[[:punct:][:digit:][:space:]]", "", word) 
```

```R
grep("che", words, value=T)
grep("at", words, value=T)
grep("[ch]", words, value=T) # c or h
grep("[at]", words, value=T) # a or t
grep("ch|at", words, value=T) # ch or at
grep("ch(e|i)ck", words, value=T) # check or chick
grep("chase", words, value=T) # chase 만
grep("chas?e", words, value=T) # cha + s가 0개 or 1개 + e
grep("chas*e", words, value=T) # cha + s가 0개 이상 + e
grep("chas+e", words, value=T) # cha + s가 1개 이상 + e
grep("ch(a*|e*)se", words, value=T)
grep("^c", words, value=T) # c로 시작
grep("t$", words, value=T) # t로 끝
grep("^c.*t$", words, value=T) # c로 시작해 t로 끝
```



## 3. 문자열 처리 함수

- `nchar()` : 문자의 개수 카운트

  - ```R
    x <- "We have a dream"
    nchar(x) # 15
    length(x) # 1
    
    y <- c("We", "have", "a", "dream", "ㅋㅋㅋ")
    length(y) # 5
    nchar(y) # 2 4 1 5 3
    ```

- `sort()` : abc(가나다) 순 정렬

  - ```R
    sort(letters, decreasing=TRUE)
    "z" "y" "x" ... "c" "b" "a"
    ```

- `tolower()` : 영대문자를 영소문자로

- `toupper()` : 영소문자를 영대문자로

  - ```R
    fox.says <- "It is HEART"
    tolower(fox.says) # "it is heart"
    toupper(fox.says) # "IT IS HEART"
    ```

- `substr()` : 문자열 추출(벡터 내의 문자열도 동일하게 적용)

- `substring(x, n)` : 문자열 x를 n번째 부터 추출

  - ```R
    substr("Data Analytics", start=1, stop=4) # "Data"
    substr("Data Analytics", 6, 14) # "Analytics"
    substring("Data Analytics", 10) # "ytics"
    countries <- c("Korea, KR", "United States, US", "China, CN")
    substr(countries, nchar(countries)-1, nchar(countries)) # "KR" "US" "CN"
    ```

- `grep()`

- `gsub()`

- `strsplit(x, 구분문자)` : 구분문자를 기준으로 문자열을 분할하여 리스트로 반환

  - ```R
    p1 <- "You come at four in the afternoon"
    p2 <- "One runs the risk of weeping a little, if one lets himself be tamed"
    p3 <- "What makes the desert beautiful is that somewhere it hides a well"
    littleprince <- c(p1, p2, p3)
    strsplit(littleprince, " ")
    strsplit(littleprince, " ")[[3]][5]
    [[1]]
    [1] "You" "come" "at" "four" "in" "the" "afternoon"
    [[2]]
     [1] "One" "runs" "the"  "risk" "of" "weeping" "a" "little," "if"  "one"  "lets" "himself" "be" "tamed"  
    [[3]]
     [1] "What" "makes" "the"  "desert" "beautiful" "is" "that" "somewhere" "it" "hides" "a" "well"
    ```



## 4. apply 계열 함수

- 벡터, 행렬 또는 데이터 프레임에 임의의 함수를 적용한 결과 리턴
- 이 함수들은 데이터 전체에 함수를 한 번에 적용하는 벡터 연산을 수행하므로 속도도 빠르고 구현도 간단하다.

| **함수**  | **설명**                                                     | **다른 함수와 비교했을 때의 특징**                 |
| --------- | ------------------------------------------------------------ | -------------------------------------------------- |
| apply( )  | 배열 또는 행렬에 주어진 함수를 적용한 뒤 그 결과를 벡터, 배열 또는 리스트로 반환 | 배열 또는 행렬에 적용                              |
| lapply( ) | 벡터, 리스트 또는 표현식에 함수를 적용하여 그 결과를 리스트로 반환 | 결과가 리스트                                      |
| sapply()  | lapply와 유사하나 결과를 가능한 심플한 데이터셋으로 반환     | 결과가 심플데이터셋                                |
| tapply( ) | 벡터에 있는 데이터를 특정 기준에 따라 그룹으로 묶은 뒤 각 그룹마다 주어진 함수를 적용하고 그 결과를 반환 | 데이터를 그룹으로 묶은 뒤 함수를 적용              |
| mapply()  | sapply의 확장된 버전으로, 여러 개의 벡터 또는 리스트를 인자로 받아< 함수에 각 데이터의 첫째 요소들을 적용한 결과, 둘째 요소들을 적용한 결과, 셋째 요소들을 적용한 결과 등을 반환 | 여러 데이터셋의 데이터를 함수의 인자로 적용한 결과 |

- apply( )는 행렬의 행 또는 열 방향으로 특정 함수를 적용하는 데 사용한다.

- apply : 배열 또는 행렬에 함수 FUNC을 MARGIN 방향으로 적용해 결과를 벡터, 배열 또는 리스트로 반환

- `apply(X, MARGIN, FUNC)`

- 반환 값은 FUNC이 길이 1인 벡터들을 반환한 경우 벡터, 1보다 큰 벡터들을 반환한 경우 행렬, 서로 다른 길이의 벡터를 반환한 경우 리스트다. 
- apply( )가 적용된 결과가 벡터, 배열, 리스트 중 어떤 형태로 반환될 것인지는 X의 데이터 타입과 FUN의 반환 값에 따라 대부분 자연스럽게 예상할 수 있다. 

```R
weight <- c(65.4, 55, 380, 72.2, 51, NA)
height <- c(170, 155, NA, 173, 161, 166)
gender <- c("M", "F","M","M","F","F")

df <- data.frame(w=weight, h=height)
apply(df, 1, sum, na.rm=TRUE) 
# [1] 235.4 210.0 380.0 245.2 212.0 166.0
apply(df, 2, sum, na.rm=TRUE)
#     w     h 
# 623.6 825.0 
lapply(df, sum, na.rm=TRUE)
# $w
# [1] 623.6
# $h
# [1] 825
sapply(df, sum, na.rm=TRUE)
# $w
# [1] 623.6
# $h
# [1] 825
tapply(1:6, gender, sum) # rm(sum)
#  F  M 
# 13  8 
tapply(df$w, gender, mean, na.rm=TRUE)
#        F        M 
#  53.0000 172.5333 
mapply(paste, 1:5, LETTERS[1:5], month.abb[1:5])
# [1] "1 A Jan" "2 B Feb" "3 C Mar" "4 D Apr" "5 E May"
```



---

---



## 1. API

- Application Programming Interface
- 자주 사용될 수 있는 기능들을 미리 만들어 둔 프로그램
- 어떠한 언어의 API인가에 따라서 함수, 클래스
  - R의 경우에는 대부분 함수
- 여러 함수들을 묶어 놓은 것을 패키지아고 한다.
  - 패키지 단위로 관리
  - 특정 함수를 사용하기 위해선 함수가 포함된 패키지를 설치
  - R 패키지들은 CRAN 사이트에서 다운로드하여 설치 가능



## 2. 패키지 관련 함수

- 새로운 R 패키지의 설치

  **install.packages("패키지명")**

- 이미 설치된 R 패키지 확인

  **installed.packages()**

- 설치된 패키지 삭제

  **remove.packages("패키지명")**

- 설치된 패키지의 버전 확인

  packageVersion("패키지명")

- 설치된 패키지 업데이트

  update.packages("패키지명")

- 설치된 패키지 로드

  library(패키지명)

  require(패키지명)

- 로드된 패키지 언로드(로드상태 해제)

  detach("package:패키지명")

- 로드된 패키지 점검

  search()

- 설치된 패키지의 버전 점검

  packageVersion(패키지명)





### [ 스크래핑(web scraping) ]

- 웹 사이트 상에서 원하는 부분에 위치한 정보(**태그**)를 컴퓨터로 하여금 자동으로 추출하여 수집하는 기술

- **CSS Selector** 를 통해 원하는 태그 탐색
- **XPath**(XML Path Language)를 통해서 태그 탐색



### [ 웹 크롤링(web crawling) ]

자동화 봇(bot)인 웹 크롤러가 정해진 규칙에 따라 복수 개의 웹 페이지를 브라우징 하는 행위



#### 정적 웹 페이지 스크래핑

#### 정적 웹 페이지란?

...

### 스크래핑

- 먼저 원하는 태그를 알아야 함

- **rvest 패키지**

  **html_nodes(x, css, xpath), html_node(x, css, xpath)** : 원하는 노드(태그) 추출하기

  **html_text(x, trim=FALSE)** : **노드에서 컨텐트 추출하기**

  `html_attrs(x)` : 노드에서 속성들 추출하기 

  **html_attr(x, name, default = "")** : **노드에서 주어진 명칭의 속성값 추출하기**

- **XML 패키지**

   htmlParse (file, encoding="…") : xpathSApply() 사용 가능한 객체로 변환

   xpathSApply(doc, path, **func**) : 원하는 노드(태그) 추출하고 전달된 함수 수행하기

   \# fun : xmlValue,  xmlGetAttr,  xmlAttrs

```R
url <- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
text <- read_html(url)

# <h1> 태그의 컨텐츠
nodes <- html_nodes(text, 'h1')
html_text(nodes);

# <a> 태그의 href 속성값
anodes <- html_nodes(text, 'a')
html_attr(anodes, 'href')

# <img> 태그의 src 속성값
imgnodes <- html_nodes(text, 'img')
html_attr(imgnodes, 'src')

# 첫 번째 <h2> 태그의 컨텐츠
firsth2 <- html_nodes(text, "h2:nth-of-type(1)")
html_text(firsth2)

# <ul> 태그의 자식 태그들 중 style 속성 의 값이 green으로 끝나는 태그의 컨텐츠
ulist <- html_nodes(text, 'ul')
html_text(html_nodes(ulist, '[style$=green]'))

ulist <- html_nodes(text, 'ul > [style$=green]')
ulist <- html_nodes(text, 'ul > li[style$=green]')
html_text(ulist)

# 두 번째 <h2> 태그의 컨텐츠
secondh2 <- html_nodes(text, "h2:nth-of-type(2)")
html_text(secondh2)

# <ol> 태그의 모든 자식 태그들의 컨텐츠
olist <- html_nodes(text, 'ol *')
html_text(olist)

# <table> 태그의 모든 자손 태그들의 컨텐츠
tables <- html_nodes(text, 'table *')
html_text(tables)

# name이라는 클래스 속성을 갖는 <tr> 태그의 컨텐츠
tables <- html_nodes(text, 'table .name')
html_text(tables)

# target이라는 아이디 속성을 갖는 <td> 태그의 컨텐츠
td <- html_nodes(text, 'td#target')
html_text(td)
```



### 크롤링

- **xml2** **패키지**

  `read_html(url)` : HTML 웹 페이지를 요청해서 받아오기

- **httr** **패키지**

  `GET(url)` : HTML 웹 페이지를 요청해서 받아오기

​        요청헤더에 계정 또는 패스워드 등의 정보 전달 가능

​        응답 내용이 바이너리인 경우에도 사용 가능



