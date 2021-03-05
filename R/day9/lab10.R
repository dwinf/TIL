remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()

url <- 'https://hotel.naver.com/hotels/item?hotelId=hotel:Shilla_Stay_Yeoksam&destination_kor=%EC%8B%A0%EB%9D%BC%EC%8A%A4%ED%85%8C%EC%9D%B4%20%EC%97%AD%EC%82%BC&rooms=2'
remDr$navigate(url)

reple <- NULL

repeat{
  # 댓글 저장
  content<-remDr$findElements(using ="css selector","div.review_ta.ng-scope div.review_desc > p")
  reple_v <- sapply(content,function(x){x$getElementText()})  
  Sys.sleep(1)
  print(reple_v)
  reple <- append(reple, unlist(reple_v))

  # 마지막 페이지 검사
  if(!btn$getElementAttribute('class') == "direction next")  {
    cat("종료\n")
    break; 
  }
  # 페이지 이동
  btn<-remDr$findElement(using='css selector',"div.review_ta.ng-scope > div.paginate > a.direction.next")
  btn$clickElement()
  Sys.sleep(2)
}
write(reple,"output/naverhotel.txt")
