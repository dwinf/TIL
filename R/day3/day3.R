num <- 1:10
num
num = 10:1
num
100:200 -> num
num

num1 <- 11 # c(11)
num2 <- 3  # c(3)
num1 / num2    # 나눗셈
num1 %% num2   # 나머지 값
num1 %/% num2  # 몫


#LIST
v<-c(1,2,3)
l<-list(1,2,3) 
v * 10
#l * 10 # 벡터 연산 불가. 이항연산자에 수치가 아닌 인수입니다
v
l
v[1] 
l[1] # * 10 # 리스트이기 때문에 연산 불가
l[[1]] # 연산 가능

lds <- list(1,2,3) 
lds
lds+100
unlist(lds) # 리스트 해제. 벡터화
unlist(lds)+100
lds[1]
lds[1]+10
lds[[1]]+10

names(lds) <- LETTERS[1:3]
lds
lds[[2]]
lds[["B"]]
lds$B # named list일 경우에만 가능


a<-list(
  a = 1:3,
  b = "a string",
  c = pi,
  d = list(-1,-5)
)
a
a[1]
a[[1]] # a[["a"]]
a$a
a[[1]][1]
a$a[1]
a[1]+1 # 에러
a[[1]]+1
a[[1]][2] <- 100
new_a <- unlist(a[1]) # 리스트 내부 리스트도 벡터로 만듦
a[1]; new_a # named list 였기 때문에 named 벡터가 된다.
names(a) <- NULL
names(new_a) <- NULL

print(100)
print(pi)
data <- "가나다"
print(data)
print(data, quote=FALSE) # 인용부호 생략
v1 <- c("사과", "바나나", "포도")
print(v1)
print(v1, print.gap=10) # 출력할 때 문자 앞에 공백 10칸
cat(100)
cat(100,200)
cat(100,200,"\n") # 반복문을 쓸 때 유용. 콘솔창에선 차이x
cat("aaa", "bbb", "ccc", "ddd", "\n") # 인용부호 출력x
cat(v1, "\n")
cat(v1, sep="-", "\n") # sep=" "이 기본

print(paste("R", "은 통계분석", "전용 언어입니다.")) # 인용부호o
cat("R", "은 통계분석", "전용 언어입니다.", "\n") # 인용부호x

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




#제어문
#if else
randomNum <-sample(1:10,1)
if(randomNum>5){
  cat(randomNum,":5보다 크군요","\n")
}else{
  cat(randomNum,":5보다 작거나 같군요","\n")
}

if(randomNum%%2 == 1){
  cat(randomNum,";홀수","\n")
  cat("종료")
}else{
  cat(randomNum,";짝수","\n")
  cat("종료")
}


if(randomNum%%2 == 1){
  cat(randomNum,";홀수") # 개행문자를 지정하지 않으면 따로 처리x
  cat("종료")
}else{
  cat(randomNum,";짝수")
  cat("종료")
}

score <- sample(0:100, 1)  # 0~100 숫자 한 개를 무작위로 뽑아서
if (score >=90){
  cat(score,"는 A등급입니다","\n")
}else if (score >=80){
  cat(score,"는 B등급입니다","\n")
}else if (score >=70){
  cat(score,"는 C등급입니다","\n")
}else if (score >=60){
  cat(score,"는 D등급입니다","\n")
}else {
  cat(score,"는 F등급입니다","\n")
}

#for문
#for 실습
for(data in month.name) 
  print(data)
for(data in month.name)print(data);print("hello") # 한글는 유니코드로 출력
for(data in month.name){print(data);print("hello")} # 블럭을 해야 반복문에서 실행

for(n in 1:5)
  cat("hello?","\n")

for(i in 1:5){
  for(j in 1:5){
    cat("i=",i,"j=",j,"\n")
  }
}
# 구구단
for(dan in 1:9){
  for(num in 1:9){
    cat(dan,"x",num,"=",dan*num,"\t") # \n : 개행문자, \t : 탭문자
  }
  cat("\n")
}


bb <- F
for(i in 1:9){
  for(j in 1:9){
    if(i*j>30){
      bb<-T
      break # 가장 가까운 반복문 탈출
    } 
    cat(i,"*",j,"=",i*j,"\t")
  }
  cat("\n")
  if(bb) #bb가 TRUE이면
    break
}


for(i in 1:9){
  for(j in 1:9){
    if(i*j>30){
      bb<-T
      break
    } 
  cat("\n")
}
    
#while문
i<-1
while(i <= 10){
  cat(i,"\n")
  i <- i+1
}
cat("종료 후 :",i,"\n")

i<-1
while (i<=10) {
  cat(i,"\n") # 무한루프를 돌게 됨
}

i<-1
while (i<=10) {
  cat(i,"\n")
  i<-i+2
}

i<-1
while (i<=10) {
  cat(i,"\n")
  i<-i+1
}

#switch 문을 대신하는 함수
month <- sample(1:12,1)
month <- paste(month,"월",sep="") # "3월"  "3 월"
result <- switch(EXPR=month,
                 "12월"=,"1월"=,"2월"="겨울",
                 "3월"=,"4월"=,"5월"="봄",
                 "6월"=,"7월"=,"8월"="여름",
                 "가을")
cat(month,"은 ",result,"입니다\n",sep="")

num <- sample(1:10,1)
num
switch(EXPR = num,"A","B","C","D")

for(num in 1:10){
  cat(num,":",switch(EXPR = num,"A","B","C","D"),"\n")
}

for(num in 1:10){
  num <- as.character(num) 
  cat(num,":",switch(EXPR = num, # 문자열만 식 사용 가능
                     "7"="A","8"="B","9"="C","10"="D","ㅋ"),"\n")
}


for(data in month.name) 
  print(data) # 인용부호o 개행o

for(data in month.name) 
  cat(data) # 인용부호x 개행x

sum <- 0
for(i in 5:15){
  if(i%%10==0){
    break
  }
  sum <- sum + i
  print(paste(i,":",sum))
}

sum <- 0
for(i in 5:15){
  if(i%%10==0){
    break
  }
  sum <- sum + i
  cat(i,":",sum,"\n")
}

sum <-0
for(i in 5:15){
  if(i%%10==0){
    next;  #continue. i=10일 경우 실행x
  }
  sum <- sum + i
  print(paste(i,":",sum))
}

sumNumber <- 0
while(sumNumber <= 20) { 
  i <- sample(1:5, 1) 
  sumNumber <-sumNumber+i; 
  cat(sumNumber,"\n")
} 

repeat {
  cat("ㅋㅋㅋ\n")
}

sumNumber <- 0
repeat { 
  i <- sample(1:5, 1) 
  sumNumber <-sumNumber+i; 
  cat(sumNumber,"\n")
  if(sumNumber > 20)
    break;
}
