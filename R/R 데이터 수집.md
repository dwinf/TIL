# R 데이터 수집

## 1. API

- Application Programming Interface
- 자주 사용될 수 있는 기능들을 미리 만들어 둔 프로그램
- 어떠한 언어의 API인가에 따라서 함수, 클래스
  - R의 경우에는 대부분 함수
- 여러 함수들을 묶어 놓은 것을 패키지아고 한다.
  - 패키지 단위로 관리
  - 특정 함수를 사용하기 위해선 함수가 포함된 패키지를 설치
  - R 패키지들은 CRAN 사이트에서 다운로드하여 설치 가능

### OPEN API

> 무료이고 공개된 데이터들을 정해진 규격의 URL 문자열을 사용해서 요청하고 수집할 수 있는 스펙



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



## 3. R 정적 데이터 수집 

### [ 스크래핑(web scraping) ]

- 웹 사이트 상에서 원하는 부분에 위치한 정보(**태그**)를 컴퓨터로 하여금 자동으로 추출하여 수집하는 기술

- **CSS Selector** 를 통해 원하는 태그 탐색
- **XPath**(XML Path Language)를 통해서 태그 탐색



### [ 웹 크롤링(web crawling) ]

자동화 봇(bot)인 웹 크롤러가 정해진 규칙에 따라 복수 개의 웹 페이지를 브라우징 하는 행위



### 정적 웹 페이지란?

- 웹 서버에 저장된 html 문서를 클라이언트에 전송하는 웹 페이지
- 서버에 저장된 데이터가 변경되지 않는 한 고정된 웹 페이지



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

  \# fun : xmlValue(텍스트를 가져옴),  xmlGetAttr(속성값을 가져옴),  xmlAttrs

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



### 데이터 수집 예시

#### 1. 단일 페이지 읽어오기

```R
# [ 예제3 ]
# 단일 페이지(rvest 패키지 사용)
library(rvest)
# 영화 제목과 평점, 리뷰글 읽기
text<- NULL; title<-NULL; point<-NULL; review<-NULL; page=NULL
url<- "http://movie.naver.com/movie/point/af/list.nhn?"
text <- read_html(url)#,  encoding="CP949") # 네이버 영화페이지의 charset은 euc-kr/ CP949, EUC-KR, ksc5601
text
#save(text, file="imsi.rda")
# 영화제목
nodes <- html_nodes(text, ".movie")
title <- html_text(nodes)
title
# 영화평점
nodes <- html_nodes(text, ".title em")
point <- html_text(nodes)
point
# 영화리뷰
review <- html_nodes(text, xpath="//*[@id='old_content']/table/tbody/tr/td[2]/text()") # 텍스트를 가져옴
review <- html_text(review, trim=TRUE) # 텍스트에 섞인 분리문자, 문자 앞뒤의 공백 등 제거 
review <- review[nchar(review) > 0] # 실제 리뷰글이 아닌 공백 제거
review
page <- data.frame(title, review)
print(page)

# [ 예제4 ]
# 영화 제목, 평점, 리뷰글 읽기
text<- NULL; vtitle<-NULL; vpoint<-NULL; vreview<-NULL; page=NULL
url<- "http://movie.naver.com/movie/point/af/list.nhn?page=4"
text <- read_html(url,  encoding="CP949")
text

for (index in 1:10) {
  # 영화제목
  node <- html_node(text, paste0("#old_content > table > tbody > tr:nth-child(", index, ") > td.title > a.movie.color_b"))
  title <- html_text(node)
  vtitle[index] <- title
  # 영화평점
  node <- html_node(text, paste0("#old_content > table > tbody > tr:nth-child(", index,") > td.title > div > em"))
  point <- html_text(node)
  vpoint <- c(vpoint, point)
  # 영화리뷰 
  node <- html_nodes(text, xpath=paste0('//*[@id="old_content"]/table/tbody/tr[', index,"]/td[2]/text()"))
  node <- html_text(node, trim=TRUE)
  print(node)
  review = node[4] 
  vreview <- append(vreview, review)
}
page <- data.frame(vtitle, vpoint, vreview)
View(page)
write.csv(page, "output/movie_reviews1.csv")
```

#### 2. 여러 페이지 읽어오기

``` R
# [ 예제5 ]
# 여러 페이지1
site<- "http://movie.naver.com/movie/point/af/list.nhn?page="
text <- NULL
movie.review <- NULL
for(i in 1: 100) {
  url <- paste(site, i, sep="")
  text <- read_html(url,  encoding="CP949")
  nodes <- html_nodes(text, ".movie")
  title <- html_text(nodes)
  nodes <- html_nodes(text, ".title em")
  point <- html_text(nodes)
  nodes <- html_nodes(text, xpath="//*[@id='old_content']/table/tbody/tr/td[2]/text()")
  imsi <- html_text(nodes, trim=TRUE)
  review <- imsi[nchar(imsi) > 0] 
  if(length(review) == 10) {
    page <- data.frame(title, point, review)
    movie.review <- rbind(movie.review, page)
  } else {
    cat(paste(i," 페이지에는 리뷰글이 생략된 데이터가 있어서 수집하지 않습니다.ㅜㅜ\n"))
  }
}
write.csv(movie.review, "output/movie_reviews2.csv")

# [ 예제6 ]
# 여러 페이지2
site<- "http://movie.naver.com/movie/point/af/list.nhn?page="
text <- NULL
movie.allreview <- NULL
for(i in 1: 100) {
  url <- paste(site, i, sep="")
  text <- read_html(url,  encoding="CP949")
  for (index in 1:10) {
    # 영화제목
    node <- html_node(text, paste0("#old_content > table > tbody > tr:nth-child(", index, ") > td.title > a.movie.color_b"))
    title <- html_text(node)
    vtitle[index] <- title
    # 영화평점
    node <- html_node(text, paste0("#old_content > table > tbody > tr:nth-child(", index,") > td.title > div > em"))
    point <- html_text(node)
    vpoint <- c(vpoint, point)
    # 영화리뷰 
    node <- html_nodes(text, xpath=paste0('//*[@id="old_content"]/table/tbody/tr[', index,"]/td[2]/text()"))
    node <- html_text(node, trim=TRUE)
    print(node)
    review = node[4] # 질문!!
    vreview <- append(vreview, review)
  }
  page <- data.frame(vtitle, vpoint, vreview)
  movie.review <- rbind(movie.allreview, page)
  
}
write.csv(movie.review, "output/movie_reviews3.csv")
```

#### 3. XML 패키지 이용

```R
# [ 예제7 ]
# 한겨레 페이지(XML 패키지 사용)
library(XML)
library(rvest)
imsi <- read_html("http://www.hani.co.kr/")
t <- htmlParse(imsi)
content<- xpathSApply(t,'//*[@id="main-top01-scroll-in"]/div/div/h4/a', xmlValue); 
# //은 조상이 어디든 id를 찾으라는 뜻, 앞의 경로를 작성할 필요x
# 크롬 개발자모드에서 href에 우클리-copy를 통해 알 수 있음(직접 작성안해도 됨)
content
```

#### 4. 글 목록에서 URL 뽑아내기

```R
# [ 예제8 ]
# 뉴스, 게시판 등 글 목록에서 글의 URL만 뽑아내기 
htxt = read_html("https://news.naver.com/main/list.nhn?mode=LSD&mid=sec&sid1=001")
link = html_nodes(htxt, 'div.list_body a')
length(link)
article.href = unique(html_attr(link, 'href')) # unique 를 통해 중복값 제거
article.href
```

#### 5. 이미지, 첨부파일 받기

```R
# [ 예제9 ]
# 이미지, 첨부파일 다운 받기 
# pdf
library(httr)
res = GET('http://cran.r-project.org/web/packages/httr/httr.pdf')
writeBin(content(res, 'raw'), 'c:/Temp/httr.pdf')

# [ 예제10 ]
# jpg
h = read_html('http://unico2013.dothome.co.kr/productlog.html')
imgs = html_nodes(h, 'img')
img.src = html_attr(imgs, 'src')
for(i in 1:length(img.src)){ # GET은 텍스트를 제외한 이미지같은 파일도 잘 받아옴
  res = GET(paste('http://unico2013.dothome.co.kr/',img.src[i], sep=""))
  writeBin(content(res, 'raw'), paste('c:/Temp/', img.src[i], sep=""))
} # http://unico2013.dothome.co.kr/ + 이미지명으로 이미지를 불러올 수 있다.

```



### Open API 활용

#### 1. 네이버 블로그

```R
# [ 예제11 ]
# SNS의 Open API 활용
library(httr)
library(rvest)
library(XML)
searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode(iconv("봄","euc-kr","UTF-8")); 
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
               "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

# 블로그 내용에 대한 리스트 만들기		
doc2 <- htmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue)
text
text <- gsub("</?b>", "", text) # </?b> --> <b> 또는 </b>
text <- gsub("&.+t;", "", text) # &.+t; --> &at;, &abct;, &1t;, &111t; ...
text[81]
text
```

#### 2. 네이버 뉴스

```R
# [ 예제12 ]
# 네이버 뉴스 연동  
searchUrl<- "https://openapi.naver.com/v1/search/news.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"
query <- URLencode(iconv("코로나","euc-kr","UTF-8"))
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

# 네이버 뉴스 내용에 대한 리스트 만들기		
doc2 <- htmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue); 
text
text <- gsub("</?b>", "", text)
text <- gsub("&.+t;", "", text)
text

```

#### 3. 트위터

```R
# [ 예제13 ]
# 트위터 글 읽어오기
install.packages("rtweet")
library(rtweet) 
appname <- "edu_data_collection"
api_key <- "RvnZeIl8ra88reu8fm23m0bST"
api_secret <- "wTRylK94GK2KmhZUnqXonDaIszwAsS6VPvpSsIo6EX5GQLtzQo"
access_token <- "959614462004117506-dkWyZaO8Bz3ZXh73rspWfc1sQz0EnDU"
access_token_secret <- "rxDWfg7uz1yXMTDwijz0x90yWhDAnmOM15R6IgC8kmtTe"
twitter_token <- create_token(
  app = appname,
  consumer_key = api_key,
  consumer_secret = api_secret,
  access_token = access_token,
  access_secret = access_token_secret)

key <- "취업"
key <- enc2utf8(key) # 단어를 utf8로 변환
result <- search_tweets(key, n=100, token = twitter_token)
str(result)
class(result)
result$retweet_text
content <- result$retweet_text
content
content <
```

#### 4. 실시간 버스 노선정보

```R
# [ 예제14 ] # 오픈 API를 사용하기 때문에 버스의 실시간 노선정보를 받아올 수 있다.
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "146"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc); top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList")); df
View(df)

busRouteId <- df[df$busRouteNm == 146, "busRouteId"]
busRouteId

url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc); top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList")); df
View(df)
```

#### 5. 서울시 빅데이터(XML)

```R
# [ 예제15 ]
# 서울시 빅데이터- XML 응답 처리
# http://openapi.seoul.go.kr:8088/796143536a756e69313134667752417a/xml/LampScpgmtb/1/100/

library(XML)
key = '796143536a756e69313134667752417a'
contentType = 'xml'
startIndex = '1'
endIndex = '200'
url = paste0('http://openapi.seoul.go.kr:8088/',key,'/',contentType,'/LampScpgmtb/',startIndex,'/',endIndex,'/')

con <- url(url, "rb") 
imsi <- read_html(con)
t <- htmlParse(imsi, encoding="UTF-8")
upNm<- xpathSApply(t,"//row/up_nm", xmlValue) 
pgmNm<- xpathSApply(t,"//row/pgm_nm", xmlValue)
targetNm<- xpathSApply(t,"//row/target_nm", xmlValue)
price<- xpathSApply(t,"//row/u_price", xmlValue)

df <- data.frame(upNm, pgmNm, targetNm, price)
View(df)
write.csv(df, "output/edu.csv")
```

#### 6. 한국은행 결제 통계시스템(JSON)

```R
# [ 예제16 ]
# 한국은행 결제 통계시스템 Open API - JSON 응답 처리
install.packages("jsonlite")
library(jsonlite)
library(httr)
key = '/4WQ7X833TXC370SUTDX4/'
contentType = 'json/'
startIndex = '1'
endIndex = '/100/'

url <- paste0('http://ecos.bok.or.kr/api/KeyStatisticList',key,contentType,'kr/',startIndex,endIndex)
url
response <- GET(url)
json_data <- content(response, type = 'text', encoding = "UTF-8")
json_obj <- fromJSON(json_data) # R은 클래스는 (아직) 없지만 리스트로 객체를 만든다.
class(json_obj)
df <- data.frame(json_obj)
df <- df[-1]
names(df) <- c("className", "unitName", "cycle", "keystatName", "dataValue")
View(df)
options(scipen=100) # 지수형태를 숫자로 바꿀 수 있음
View(df)
```

