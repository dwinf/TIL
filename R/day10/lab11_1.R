## [ GS 25 2+1 모든 상품 ] - CASE 1

# 0. 동적 크롤링을 위한 라이브러리 셀레늄 기동
library(RSelenium)


# 1. 서버를 기동시킨 후 접속한다.
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")


# 2. selenium 서버에 의해 제어되는 브라우저 기동시킨다.
remDr$open()
site <- 'http://gs25.gsretail.com/gscvs/ko/products/event-goods'
remDr$navigate(site)


# 3. 2 + 1 행사 탭에 들어가기
#(1) clickElement()
twoplusone <- remDr$findElement(using='css selector','#TWO_TO_ONE')
twoplusone$clickElement()

##  마지막 페이지 이동
lastpage <- remDr$findElement(using='css selector','#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > div > a.next2')
lastpage$clickElement()


# 4. 상품명 : goodsname, 가격 : goodsprice 가 되도록 데이터 프레임 생성
# (1) 데이터 추출

## 상품명
#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li:nth-child(1) > div > p.tit
#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li:nth-child(5) > div > p.tit
#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li:nth-child(7) > div > p.tit

#twoonenodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.tit')
#twoonegoodsname <- sapply(eventgoodsnodes, function(x) {x$getElementText()})

# is.list(twoonegoodsname) # 리스트 형식으로 생성


## 가격
#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li:nth-child(1) > div > p.price > span
#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li:nth-child(8) > div > p.price > span

#twononepricenodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.price > span')
#twooneprice <- sapply(twononepricenodes, function(x) {x$getElementText()})


# 상품명과 가격을 데이터 프레임으로 변경
#goods <- data.frame(goodsname = unlist(twoonegoodsname), goodsprice = unlist(twooneprice))

goods <- NULL
goodsname <- NULL
goodsprice <- NULL


## 5. 모든 페이지
repeat{
  # 정보 추출
  Sys.sleep(3)
  
  twoonenodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.tit')
  #Sys.sleep(3)
  
  twoonegoodsname <- sapply(twoonenodes, function(x) {x$getElementText()})
  
  
  #Sys.sleep(3)
  twononepricenodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.price > span')
  
  #Sys.sleep(3)
  twooneprice <- sapply(twononepricenodes, function(x) {x$getElementText()})
  #Sys.sleep(2)
  
  goodsname <- c(goodsname,unlist(twoonegoodsname))
  #Sys.sleep(3)
  goodsname
  
  goodsprice <- c(goodsprice,unlist(twooneprice))
  
  
  #Sys.sleep(3)
  pagenodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > div > span > a.on')
  
  #Sys.sleep(2)
  
  currentpage <- sapply(pagenodes, function(x) {x$getElementText()})
  
  # 이전 버튼 클릭
  #Sys.sleep(2)
  
  nextbutton <- remDr$findElement(using='css selector','#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > div > a.prev')
  #Sys.sleep(2)
  
  nextbutton$clickElement()
  
  Sys.sleep(2)
  
  # 멈춘다.
  if (currentpage=="1"){
    break
  }
  #Sys.sleep(2)
  
  goods <- data.frame(goodsname,goodsprice)
  
}

# 5. 데이터 저장
write.csv(goods,"output/gs25_twotoone.csv")

####################################
## [ GS 25 2+1 모든 상품 ] - CASE 2

library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open() 
url<-'http://gs25.gsretail.com/gscvs/ko/products/event-goods'
remDr$navigate(url) # url에 해당하는 웹페이지 랜더링
Sys.sleep(3)

event21Css <- "#TWO_TO_ONE"                
event21ListLink<-remDr$findElement(using='css selector',event21Css)
remDr$executeScript("arguments[0].click();",'event21ListLink')
event21ListLink$clickElement()
Sys.sleep(1)

pageLink <- NULL
curr_PageOldNum <- 0
event21 <- NULL
repeat{
  eventgoodsnodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li> div > p.tit')
  eventgoodsname <- sapply(eventgoodsnodes, function(x) {x$getElementText()})
  
  eventgoodsnodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.price > span')
  eventgoodsprice <- sapply(eventgoodsnodes, function(x) {x$getElementText()})
  
  event <- data.frame(goodsname = unlist(eventgoodsname), goodsprice = unlist(eventgoodsprice))
  print(event)
  event21 <- rbind(event21, event)
  
  
  pageLink <- remDr$findElements(using='css selector',"div:nth-child(5) > div > a.next")
  remDr$executeScript("arguments[0].click();",pageLink) 
  Sys.sleep(1)
  curr_PageElem <- remDr$findElement(using='css','#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > div > span > a.on')
  curr_PageNewNum <- as.numeric(curr_PageElem$getElementText())
  cat(paste(curr_PageOldNum, ':', curr_PageNewNum,'\n'))
  if(curr_PageNewNum == curr_PageOldNum)  {  # 이전 페이지와 현재 페이지가 같으면, 종료되게끔!
    cat("종료\n")
    break; 
  }
  curr_PageOldNum <- curr_PageNewNum;
}

write.csv(event21,"output/gs25_twotoone.csv")



## [ GS 25 2+1 모든 상품 ] - CASE 3

library(rvest)
library(XML)
library(httr)
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4445, browserName = "chrome")
remDr$open()
remDr$navigate("http://gs25.gsretail.com/gscvs/ko/products/event-goods")

tab <- remDr$findElement(using='css selector','#TWO_TO_ONE')
tab$clickElement()
Sys.sleep(1)

goodsname <- NULL; goodsprice <- NULL
repeat{
  nodes <- remDr$findElements(using='css selector', 'div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.tit')
  names <- sapply(nodes, function(x) {x$getElementText()})
  goodsname <- append(goodsname, unlist(names))
  
  nodes <- remDr$findElements(using='css selector', 'div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.price > span')
  prices <- sapply(nodes, function(x) {x$getElementText()})
  goodsprice <- append(goodsprice, unlist(prices))
  
  nextPage <- remDr$findElement(using='css selector', 'div.cnt_section.mt50 > div > div > div:nth-child(5) > div > a.next')
  if(length(nextPage$getElementAttribute("onclick"))==0){
    cat("종료\n")
    break
  }
  nextPage$clickElement()
  Sys.sleep(3)
}

gs25_df <- data.frame(goodsname, goodsprice)
write.csv(gs25_df, "output/gs25_twotoone.csv")

