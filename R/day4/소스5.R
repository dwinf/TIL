# 사분위수란 측정한 양적 데이터 값을 4등분 했을 때 각 등위에 해당하는 것을 말하며 
# 1/4분위수(25% quantile), 2/4분위수(50% quantile), 
# 3/4분위수(75% quantile), 4/4분위수(100% quantile) 4가지로 나뉜다.
# R에서는 quantile() 함수를 사용한다. 
# 홀수 갯수의 숫자들에 대한 사분위수 계산은 간단하다.
# 전체에서 중간값 : 2/4 분위수
# 2/4 분위수를 기준(포함)으로 양쪽에서 중간값을 구하면 1/4, 3/4 분위수 값이 된다.
o1 <- c(1,2,3,4,5) # 1 2 3 4 5
quantile(o1)

o2 <- c(1,2,3,4,5,6,7) # 1.0 2.5 4.0 5.5 7.0
quantile(o2)

o3 <- c(1,2,3,4,5,6,7,8,9) # 1 3 5 7 9
quantile(o3)

o4 <- c(1,2,3,4,5,6,7,8,9,10,11) # 1.0 3.5 6.0 8.5 11.0
quantile(o4)

o5 <- c(2,4,6,8,10) # 2 4 6 8 10
quantile(o5)

o6 <- c(2,10,16,28,30) # 2 10 16 28 30
quantile(o6)

o7 <- c(2,10,15,28,30,40,45) # 2.0 12.5 28.0 35.0 45.0 
quantile(o7)

o8 <- c(10,12,18,20,25,26,30,32,33,40,50) # 10.0 19.0 26.0 32.5 50.0 
quantile(o8)
summary(o8)

# 짝수 갯수의 숫자들에 대한 사분위수 계산은 다음과 같다.
# 2/4 분위수(중간값) : 중앙의 2개 값의 평균
# 1/4 분위수 : 중간값의 왼쪽 데이터들
#              홀수 갯수 : 중간값 + (중간값의 다음값 - 중간값) * 0.25 
#              짝수 갯수 : 중간값 + (큰값 - 작은값) * 0.25
# 3/4 분위수 : 중간값의 왼쪽 데이터들
#              홀수 갯수 : 중간값 - (중간값의 다음값 - 중간값) * 0.25 
#              짝수 갯수 : 중간값 - (큰값 - 작은값) * 0.25


e1 <- c(1,2,3,4) # 1.0 1.75 2.5 3.25 4.0
quantile(e1)

e2 <- c(1,2,3,4,5,6) # 1.0 2.25  3.5 4.75 6.0
quantile(e2)

e3 <- c(1,2,3,4,5,6,7,8) # 1.0 2.25 4.5 6.25 8.0
quantile(e3)

e4 <- c(1,2,3,4,5,6,7,8,9,10) # 1.0 3.25 5.5 7.75 10.0
quantile(e4)

e5 <- c(2,4,6,8,10,12) # 2 4.5 7 9.5 12
quantile(e5)

e6 <- c(2,5,10,15,18,20) # 2.00 6.25 12.50 17.25 20.00
quantile(e6)

e7 <- c(2,3,10,15,50,100) # 2.00 4.75 12.50 41.25 100.00
quantile(e7)

e8 <- c(1,2,10,14,15,16,27,38)  # 1.00 8.00 14.50 18.75 38.00
quantile(e8)


ls()
length(ls())
save(list=ls(),file="all.rda") # varience will save in "all.rda" of rexam
rm(list=ls())
ls()
load("all.rda")
ls()

#read file data
nums <- scan("data/sample_num.txt")
word_ansi <- scan("data/sample_ansi.txt",what="")
words_utf8 <- scan("data/sample_utf8.txt", what="",encoding="UTF-8")
words_utf8_new <- scan("data/sample_utf8.txt", what="")
lines_ansi <- readLines("data/sample_ansi.txt")
lines_utf8 <- readLines("data/sample_utf8.txt",encoding="UTF-8")

df2 <- read.table("data/product_click.log", stringsAsFactors = T)
str(df2)
head(df2)
summary(df2$V2)

# 함수 정의와 활용

func1 <- function() {
  xx <- 10   # 지역변수
  yy <- 20
  return(xx*yy)
}
func1()
#yy
result <- func1()
result
xx  # 오류발생


func2 <- function(x,y) {
  xx <- x
  yy <- y
  return(sum(xx, yy))
}

func2()
func2(5,6) # 식 : 연산식, 호출식, 변수, 리터럴

func3 <- function(x,y) {
  #x3 <- x+1
  #y3 <- y+1
  x4 <- func2(x+1, y+1)  # 값(식) : 변수, 리터럴, 연산식, 호출식
  return(x4)
}

func3(9, 19)  # 30

func4 <- function(x=100, y=200, z) {
  return(x+y+z)
}
func4()
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
  data <- c(...)
  sum <- 0;
  for(item in data) {
    if(is.numeric(item))
      sum <- sum + item
    else
      print(item)
  }
  return(sum)
}
f7(10,20,30)
f7(10,20,'test', 30,40)

f8<- function(...) {
  data <- list(...)
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
