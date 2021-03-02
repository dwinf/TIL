l <- list(1,2,3)
v <- c(1,2,3)

sum(v)
sum(l)




#read file data
nums <- scan("data/sample_num.txt") # 숫자 읽는 것에 특화. 문자는 에러
# encoding=코드셋을 생략하면 OS 고유 코드셋 정보를 반영한다.(WINDOW10 - cp949)
word_ansi <- scan("data/sample_ansi.txt",what="")
words_utf8 <- scan("data/sample_utf8.txt", what="",encoding="UTF-8")
words_utf8_new <- scan("data/sample_utf8.txt", what="") # 한글 깨짐
lines_ansi <- readLines("data/sample_ansi.txt")
lines_utf8 <- readLines("data/sample_utf8.txt",encoding="UTF-8")

df2 <- read.table("data/product_click.log", stringsAsFactors = T) # read.csv, 문자열은 팩터로 인식하도록
str(df2)
head(df2)
summary(df2$V2) # 상품별 클릭횟수



# 함수 정의와 활용

func1 <- function() {
  xx <- 10   # 지역변수
  yy <- 20   # 함수 밖에서는 사용 불가가
  return(xx*yy)
}
func1()
#yy
result <- func1()
result
xx  # 오류발생
#func1(10) # 에러


func2 <- function(x,y) {
  xx <- x
  yy <- y
  return(sum(xx, yy))
}

func2() # 에러. 매개변수를 줘야 함
func2(5,6) # 식(아규먼트) : 연산식, 호출식, 변수, 리터럴

func3 <- function(x,y) { # 매개변수도 지역변수
  #x3 <- x+1
  #y3 <- y+1
  x4 <- func2(x+1, y+1)  # 값(식) : 변수, 리터럴, 연산식, 호출식
  return(x4)
}

func3(9, 19)  # 30

func4 <- function(x=100, y=200, z) {
  return(x+y+z)
}
func4() # z가 없기 때문에 에러
func4(10,20,30)
func4(x=1,y=2,z=3)
func4(y=11,z=22,x=33)
func4(z=1000)  



# 쉬트에 있는 함수 코드
f1 <- function() print("TEST")
f1()
r <- f1()
r
f2 <- function(num) {print("TEST"); print(num) }
f2(100)
f2()
f3<- function (p="R") print(p)
f3()
f3(p="PYTHON")
f3("java")
f4<- function (p1="ㅋㅋㅋ",p2) for(i in 1:p2) print(p1)
f4(p1="abc", p2=3)
f4("abc", 3) 
f4(5) 
f4(p2=5) 
f5<- function(...) { print("TEST"); data <- c(...); print(length(data))}
f5(10, 20, 30)
f5("abc", T, 10, 20)
f6<- function(...) {
  print("수행시작")
  data <- c(...)
  for(item in data) {
    print(item)
  }
  return(length(data))
}
f6()
f6(10)
f6(10,20)
f6(10,20,30)
f6(10,'abc', T, F)

f7<- function(...) {
  data <- c(...) # 데이터 타입이 통일됨
  sum <- 0;
  for(item in data) {
    if(is.numeric(item))
      sum <- sum + item
    else
      print(item)
  }
  return(sum)
}
f7(10,20,30) # 문자열이 있으면 모두 문자열로 취급
f7(10,20,'test', 30,40) # 벡터는 단일 타입만 허용되는 데이터셋

f8<- function(...) {
  data <- list(...) # 각각의 데이터타입 유지
  sum <- 0;
  for(item in data) {
    if(is.numeric(item))
      sum <- sum + item
    else
      print(item)
  }
  return(sum)
}

f8(10,20,30)
f8(10,20,"test", 30,40)
