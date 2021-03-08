# [ gs25 2+1 상품 정보 ]
remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4445, browserName = "chrome")
remDr$open()

url <- "http://gs25.gsretail.com/gscvs/ko/products/event-goods"
remDr$navigate(url)
Sys.sleep(3)

# 2+1 페이지
movepg <- remDr$findElements(using='css selector',"div.cnt > div.cnt_section.mt50 > div li:nth-child(2)")
sapply(movepg,function(x){x$clickElement()})
Sys.sleep(3)


index <- 1
names <- NULL
prices <- NULL

repeat{
  # 상품명
  eventgoodsnodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.tit')
  eventgoodsname <- sapply(eventgoodsnodes, function(x) {x$getElementText()})
  # 상품가격
  eventgoodsnodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.price > span')
  eventgoodsprice <- sapply(eventgoodsnodes, function(x) {x$getElementText()})
  
  # 상품 저장
  names <- append(names, unlist(eventgoodsname))
  prices <- append(prices, unlist(eventgoodsprice))
  
  # 진행 체크
  cat(index, 'page finish\n')
  index <- index +1
  
  # 마지막 페이지 검사
  nextbtn <-remDr$findElement(using='css selector', "#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > div > a.next")
  if(length(nextbtn$getElementAttribute('onclick'))==0){
    cat("끝!")
    break;
  }
  
  # 페이지 이동
  nextbtn <-remDr$findElement(using='css selector', "#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > div > a.next")
  nextbtn$clickElement()
  Sys.sleep(2)
  
}
# 데이터프레임 생성 후 저장
gs25_twotoone <- data.frame(goodsname = names, goodsprice = prices)
write.csv(gs25_twotoone, "output/gs25_twotoone.csv")
View(gs25_twotoone)

