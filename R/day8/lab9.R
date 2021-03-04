library(httr)
library(rvest)
library(XML)



# [ OPEN API 실습 1 ] 
searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode(iconv("코로나","euc-kr","UTF-8"))
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))
doc2 <- htmlParse(doc, encoding = 'UTF-8')
text <- xpathSApply(doc2, "//item/description", xmlValue)
text <- gsub("</?b>", "", text)
text <- gsub("&.+t;", "", text)
text <- gsub("amp;", "", text)
text
write.table(text, 'output/naverblog.txt')



# [ OPEN API 실습 2 ] 
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

key <- "코로나"
key <- enc2utf8(key) # 단어를 utf8로 변환
result <- search_tweets(key, n=100, token = twitter_token)
str(result)
class(result)
result$retweet_text
content <- result$retweet_text[!is.na(result$retweet_text)]
content <- gsub("[[:lower:][:upper:][:digit:][:punct:][:cntrl:]]", "", content)  
content
write.table(content, 'output/twitter.txt')



# [ OPEN API 실습 3 ]
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "360"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc)
top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df

busRouteId <- df[df$busRouteNm == 360, "busRouteId"]
df[df$busRouteId ==busRouteId, ]
cat('[ 360번 버스정보 ]\n노선ID :', df[df$busRouteId ==busRouteId, "busRouteId"], 
    '\n노선길이 :', df[df$busRouteId ==busRouteId, "length"],
    '\n기점 :', df[df$busRouteId ==busRouteId, "stStationNm"],
    '\n종점 :', df[df$busRouteId ==busRouteId, "edStationNm"],
    '\n배차간격 :', df[df$busRouteId ==busRouteId, "term"])




# [ OPEN API 실습 4 ]

library(jsonlite)

searchUrl<- "https://openapi.naver.com/v1/search/news.json"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"
query <- URLencode(iconv("빅데이터","euc-kr","UTF-8"))
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/json",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

doc2 <- content(doc, type = 'text', encoding = "UTF-8")
text<- fromJSON(doc2) 
class(text)
text <- data.frame(text)
View(text)
titles <- text["items.title"]
titles[1,]
for (i in 1:100) {
  titles[i,] <- gsub("</?b>", "", titles[i,])
  titles[i,] <- gsub("&.+t;", "", titles[i,])
}
titles
write.table(titles, 'output/navernews.txt')






