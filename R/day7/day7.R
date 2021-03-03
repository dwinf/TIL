library() # 설치된 패키지 리스트
installed.packages()
search()

install.packages("rvest") 
install.packages("XML")
install.packages("httr")

library(rvest)
library(XML)
library(httr)

# [ 예제1 ]
library(rvest)

url <- "http://unico2013.dothome.co.kr/crawling/tagstyle.html"
text <- read_html(url) # 웹 페이지 소스를 읽어옴
text

nodes <- html_nodes(text, "div") # 태그 선택자, div 태그를 읽어옴
#nodes <- html_nodes(text, css="div")
nodes # xml_nodeset 객체
title <- html_text(nodes) # 노드에서 콘텐트 추출
title

node1 <- html_nodes(text, "div:nth-of-type(1)") # div 태그 중 1번째
node1
html_text(node1)
html_attr(node1, "style") # 노드의 속성값 추출

node2 <- html_nodes(text, "div:nth-of-type(2)") # div 태그 중 2번째
node2
html_text(node2)
html_attr(node2, "style") # style 속성이 없기 때문에 NA

node3 <- html_nodes(text, "div:nth-of-type(3)") # div 태그 중 3번째
node3
html_text(node3)

# [ 예제2 ]
# 웹문서 읽기
url <- "https://www.data.go.kr/tcs/dss/selectDataSetList.do"
html <- read_html(url)
html

# 목록 아이템 추출 trim=T == 앞이나 뒤의 제어문자(\t,\n 등) 제거
title <- html_text(html_nodes(html, "#apiDataList .title"), trim=T)
title

# 목록 아이템 설명 추출
desc <- html_text(html_nodes(html, "#apiDataList .ellipsis"))
desc

# 데이터 정제: 제어문자를 공백으로 대체
title <- gsub("[[:cntrl:]]", "", title) # 47행 trim=T 로 대체
title

desc <- gsub("[[:cntrl:](</br>)∙]", "", desc) # </br> 을 ()로 묶지 않으면 개별 문자를 제거
desc

# 데이터 출력
api <- data.frame(title, desc)
api


# [ 예제3 ]
# 단일 페이지(rvest 패키지 사용)
library(rvest)
# 영화 제목과 평점 읽기
text<- NULL; title<-NULL; point<-NULL; review<-NULL; page=NULL
url<- "http://movie.naver.com/movie/point/af/list.nhn?"
text <- read_html(url)#,  encoding="CP949") # 네이버 영화페이지의 charset은 euc-kr
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
page <- data.frame(title, point)
print(page)

# 영화 제목과 평점, 리뷰글 읽기
text<- NULL; title<-NULL; point<-NULL; review<-NULL; page=NULL
url<- "http://movie.naver.com/movie/point/af/list.nhn?"
text <- read_html(url)#,  encoding="CP949") # 네이버 영화페이지의 charset은 euc-kr
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
review <- html_nodes(text, xpath="//*[@id='old_content']/table/tbody/tr/td[2]/text()")
review <- html_text(review, trim=TRUE)
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

# [ 예제8 ]
# W3C의 HTTP 프로토콜 스팩에서 Table of Contents 읽기
title2 = html_nodes(read_html('http://www.w3.org/Protocols/rfc2616/rfc2616.html'), 'div.toc h2')
title2 = html_text(title2)
title2

# [ 예제8 ]
# 뉴스, 게시판 등 글 목록에서 글의 URL만 뽑아내기 
htxt = read_html("https://news.naver.com/main/list.nhn?mode=LSD&mid=sec&sid1=001")
link = html_nodes(htxt, 'div.list_body a'); length(link)
article.href = unique(html_attr(link, 'href'))
article.href

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
for(i in 1:length(img.src)){
  res = GET(paste('http://unico2013.dothome.co.kr/',img.src[i], sep=""))
  writeBin(content(res, 'raw'), paste('c:/Temp/', img.src[i], sep=""))
} 


# [ 예제11 ]
# SNS의 Open API 활용
library(httr)
library(rvest)
library(XML)
searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode(iconv("봄","euc-kr","UTF-8"))
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
key <- enc2utf8(key)
result <- search_tweets(key, n=100, token = twitter_token)
str(result)
result$retweet_text
content <- result$retweet_text
content
content <- gsub("[[:lower:][:upper:][:digit:][:punct:][:cntrl:]]", "", content)   
content

# [ 예제14 ]
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "146"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc)
top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df
str(df)
View(df)

busRouteId <- df[df$busRouteNm == 146, "busRouteId"]
busRouteId


url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc)
top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df
View(df)
str(df)

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
response <- GET(url)
json_data <- content(response, type = 'text', encoding = "UTF-8")
json_obj <- fromJSON(json_data)
df <- data.frame(json_obj)
df <- df[-1]
names(df) <- c("className", "unitName", "cycle", "keystatName", "dataValue")
View(df)
options(scipen=100)
View(df)

