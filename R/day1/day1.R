v1 <- 1:10
v2 = 10:1
print(v1)
v2
v3 <- 100
v3
v1 <- c(4, 1, 8, 6, 10) #c()함수에는 아규먼트를 원하는 만큼 전달 가능
v2 <- c(100, 200, TRUE, FALSE); print(v2)
v3 <- c('100', 200, T, F); print(v3)
v1[5];v1[3];v1[1];v1[0];v1[6]
length(v3)

rep(1, 100)
rep(1:3, 5)
rep(1:3, times=5) # 키워드 파라미터
rep(1:3, each=5)
?rep  #help()

LETTERS
letters
month.name
month.abb
pi

LETTERS;letters;month.name;month.abb;pi

LETTERS[1]; LETTERS[c(3,4,5)]
LETTERS[3:5]; LETTERS[5:3]
LETTERS[-1]; LETTERS[c(-2,-4)] # 음의 값 인덱스 제외하고

length(LETTERS)
length(month.name)
length(pi)


x <- c(10,2,7,4,15)
x
print(x)
class(x)
rev(x) # 역 출력
range(x) # 수의 범위(최소값, 최대값)
sort(x) # 오름차순 정렬
sort(x, decreasing = TRUE) # 내림차순 정렬
sort(x, decreasing = T) # 내림차순 정렬
#x <- sort(x)
order(x) # 오름차순으로 정렬시켜 인덱스값 리턴



x[3] <- 20
x
x + 1 # 각 엘리먼트에 1을 더한 값 리턴
x <- x + 1
max(x);min(x);mean(x);sum(x)
summary(x)

x[c(2,4)] # x[2], x[4], 벡터를 인덱스처럼 사용 가능
x[c(F,T,F,T,F)] # x[c(T,F)] --> x[c(T,F,T,F,T)]
x > 5 
x[x > 5] # 원소값이 5보다 큰 값 추출
x[x > 5 & x < 15] # x[x > 5 && x < 15]
#x[x > 5 | x < 15]

names(x)
names(x) <- LETTERS[1:5]
names(x) <- NULL
x[2];x["B"]; #x[B()]


# &, &&
c(T, T, F, F) & c(T, F, T, F) #모든 원소 비교
c(T, T, F, F) | c(T, F, T, F) 
c(T, T, F, F) && c(T, F, T, F) #첫 번째 원소만
c(T, T, F, F) || c(T, F, T, F) # 무조건 TRUE


ls()
rm(x)
x
class(x)

rainfall <- c(21.6, 23.6, 45.8, 77.0, 
              102.2, 133.3,327.9, 348.0, 
              137.6, 49.3, 53.0, 24.9)
rainfall > 100
rainfall[rainfall > 100]
which(rainfall > 100)
month.name[which(rainfall > 100)]
month.abb[which(rainfall > 100)]
month.korname <- c("1월","2월","3월",
                   "4월","5월","6월",
                   "7월","8월","9월",
                   "10월","11월","12월")
month.korname[which(rainfall > 100)]
which.max(rainfall)
which.min(rainfall)
month.korname[which.max(rainfall)]
month.korname[which.min(rainfall)]


sample(1:20, 3)
sample(1:45, 6)
sample(1:10, 7)
sample(1:10, 7, replace=T) # 중복 허용

paste("I'm","Duli","!!") # 기본적으로 구분자 = ' '(공백)
paste("I'm","Duli","!!", sep="")
paste0("I'm","Duli","!!") # 공백 제거

fruit <- c("Apple", "Banana", "Strawberry")
food <- c("Pie","Juice", "Cake")
paste(fruit, food)

paste(fruit, food, sep="")
paste(fruit, food, sep=":::")
paste(fruit, food, sep="", collapse="-")
paste(fruit, food, sep="", collapse="")
paste(fruit, food, collapse=",")

