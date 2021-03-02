# 날짜와 시간 관련 기능을 지원하는 함수들

(today <- Sys.Date())
str(today)
class(today)
format(today, "%Y년 %m월 %d일%")
format(today, "%d일 %B %Y년")
format(today, "%y")
format(today, "%Y")
format(today, "%B");format(today, "%b")
format(today, "%a")
format(today, "%A")
weekdays(today) 
months(today) 
quarters(today)
unclass(today)  # 1970-01-01을 기준으로 얼마나 날짜가 지났지는 지의 값을 가지고 있다.
Sys.Date()
Sys.time();str(Sys.time())
Sys.timezone()

as.Date('1/15/2018') # 에러발생
as.Date('2018/1/15') # 년,월,일 순으로 하면 잘 인식
as.Date('1/15/2018',format='%m/%d/%Y') # format 은 생략 가능
as.Date('4월 26, 2018',format='%B %d, %Y')
as.Date('110228',format='%d%b%y') 
as.Date('110228',format='%y%m%d') 
as.Date('11228',format='%d%b%y') 

x1 <- "2019-01-10 13:30:41"
# 문자열을 날짜형으로
as.Date(x1, "%Y-%m-%d %H:%M:%S") 
# 문자열을 날짜+시간형으로
strptime(x1, "%Y-%m-%d %H:%M:%S")
strptime('2019-08-21 14:10:30', "%Y-%m-%d %H:%M:%S")

x2 <- "20200601"
as.Date(x2, "%Y%m%d")
datetime<-strptime(x2, "%Y%m%d")
str(datetime)

as.Date("2020/01/01 08:00:00") - as.Date("2020/01/01 05:00:00") # 날짜만 표현하기 때문에 0
as.POSIXct("2020/01/01 08:00:00") - as.POSIXct("2020/01/01 05:00:00")
as.POSIXlt("2020/01/01 08:00:00") - as.POSIXlt("2020/01/01 05:00:00")

t<-Sys.time()
str(t)
ct<-as.POSIXct(t)
lt<-as.POSIXlt(t)
str(ct) 
str(lt) 
unclass(ct) 
unclass(lt) 
lt$mon+1
lt$hour
lt$year+1900
as.POSIXct(1449894438,origin="1970-01-01")
as.POSIXlt(1449894438,origin="1970-01-01")

as.POSIXlt("2021/03/02")$wday
as.POSIXlt("2021/03/04")$wday
as.POSIXlt("2021/03/05")$wday
as.POSIXlt("2021/03/06")$wday
as.POSIXlt("2021/03/07")$wday

#내가 태어난 요일 출력하기
myday<-as.POSIXlt("1996-08-08")
weekdays(myday)
#내가 태어난지 며칠
as.POSIXlt(Sys.Date()) - myday
#올해의 크리스마스 요일 2가지방법(요일명,숫자)
christmas2<-as.POSIXlt("2021-12-25")
weekdays(christmas2)
christmas2$wday
#2021년 1월 1일 어떤 요일
tmp<-as.POSIXct("2021-01-01")
weekdays(tmp)
#오늘은 xxxx년x월xx일x요일입니다 형식으로 출력
tmp<-Sys.Date()
year<-format(tmp,'%Y')
month<-format(tmp,'%m')
day<-format(tmp,'%d')
weekday<-format(tmp,'%A')
paste("오늘은 ",year,"년 ",month,"월 ",day,"일 ",weekday," 입니다.",sep="")

format(tmp,'오늘은 %Y년 %B %d일 %A입니다')

# 정규표현식

word <- "JAVA javascript 가나다 123 %^&*"
gsub("A", "", word) 
gsub("a", "", word) 
gsub("[Aa]", "", word) 
gsub("[가-힣]", "", word) 
gsub("[^가-힣]", "", word) # ^은 부정을 의미
gsub("[&^%*]", "", word) 
gsub("[[:punct:]]", "", word) # 특수문자 제거
gsub("[[:alnum:]]", "", word) # 특수문자, 공백 제외 제거
gsub("[1234567890]", "", word) 
gsub("[[:digit:]]", "", word) 
gsub("[^[:alnum:]]", "", word) 
gsub("[[:space:]]", "", word) # 공백 제거 
gsub("[[:space:][:punct:]]", "", word)


# 정규표현식 사용
word <- "JAVA javascript Aa 가나다 AAaAaA123 %^&*"
gsub(" ", "@", word); sub(" ", "@", word)
gsub("A", "", word) 
gsub("a", "", word) 
gsub("Aa", "", word) 
gsub("(Aa)", "", word) 
gsub("(Aa){2}", "", word);gsub("Aa{2}", "", word) 
# "JAVA javascript Aa 가나다 AAaAaA123 %^&*"
gsub("[Aa]", "", word) 
gsub("[가-힣]", "", word) 
gsub("[^가-힣]", "", word) 
gsub("[&^%*]", "", word) 
gsub("[[:punct:]]", "", word) 
gsub("[[:alnum:]]", "", word) 
gsub("[1234567890]", "", word) 
gsub("[0-9]", "", word) 
gsub("\\d", "", word); gsub("\\D", "", word)
gsub("[[:digit:]]", "", word) 
gsub("[^[:alnum:]]", "", word) 
gsub("[[:space:]]", "", word) 
gsub("[[:punct:][:digit:]]", "", word) 
gsub("[[:punct:][:digit:][:space:]]", "", word) 

#문자열 처리 관련 주요 함수들 

x <- "We have a dream"
nchar(x)
length(x)

y <- c("We", "have", "a", "dream", "ㅋㅋㅋ")
length(y)
nchar(y)

letters
sort(letters, decreasing=TRUE)

fox.says <- "It is only with the HEART that one can See Rightly"
tolower(fox.says)
toupper(fox.says)

substr("Data Analytics", start=1, stop=4)
substr("Data Analytics", 6, 14)
substring("Data Analytics", 6)

classname <- c("Data Analytics", "Data Mining", 
               "Data Visualization")
substr(classname, 1, 4)

countries <- c("Korea, KR", "United States, US", 
               "China, CN")
substr(countries, nchar(countries)-1, nchar(countries))

head(islands)
landmesses <- names(islands)
landmesses
grep(pattern="New", x=landmesses)

index <- grep("New", landmesses)
landmesses[index]
# 동일
grep("New", landmesses, value=T)


txt <- "Data Analytics is useful. Data Analytics is also interesting."
sub(pattern="Data", replacement="Business", x=txt)
gsub(pattern="Data", replacement="Business", x=txt)

x <- c("test1.csv", "test2.csv", "test3.csv", "test4.csv")
gsub(".csv", "", x)


gsub("[ABC]", "@", "123AunicoBC98ABC")
gsub("ABC", "@", "123AunicoBC98ABC")
gsub("(AB)|C", "@", "123AunicoBC98ABC")
gsub("A|(BC)", "@", "123AunicoBC98ABC")
gsub("A|B|C", "@", "123AunicoBC98ABC")

words <- c("ct", "at", "bat", "chick", "chae", "cat", 
           "cheanomeles", "chase", "chasse", "mychasse", 
           "cheap", "check", "cheese", "hat", "mycat")

grep("che", words, value=T)
grep("at", words, value=T)
grep("[ch]", words, value=T) # c or h
grep("[at]", words, value=T) # a or t
grep("ch|at", words, value=T) # ch or at
grep("ch(e|i)ck", words, value=T) # check or chick
grep("chase", words, value=T) # chase 만
grep("chas?e", words, value=T) # cha + s가 0개 or 1개 + e
grep("chas*e", words, value=T) # cha + s가 0개 이상 + e
grep("chas+e", words, value=T) # cha + s가 1개 이상 + e
grep("ch(a*|e*)se", words, value=T)
grep("^c", words, value=T) # c로 시작
grep("t$", words, value=T) # t로 끝
grep("^c.*t$", words, value=T) # c로 시작해 t로 끝

words2 <- c("12 Dec", "OK", "http//", 
            "<TITLE>Time?</TITLE>", 
            "12345", "Hi there")

grep("[[:alnum:]]", words2, value=TRUE)
grep("[[:alpha:]]", words2, value=TRUE)
grep("[[:digit:]]", words2, value=TRUE)
grep("[[:punct:]]", words2, value=TRUE)
grep("[[:space:]]", words2, value=TRUE)
grep("\\w", words2, value=TRUE)
grep("\\d", words2, value=TRUE);grep("\\D", words2, value=TRUE)
grep("\\s", words2, value=TRUE)



fox.said <- "What is essential is invisible to the eye"
fox.said
strsplit(x= fox.said, split= " ")
strsplit(x= fox.said, split="")

fox.said.words <- unlist(strsplit(fox.said, " "))
fox.said.words
fox.said.words <- strsplit(fox.said, " ")[[1]]
fox.said.words
fox.said.words[3]
p1 <- "You come at four in the afternoon, than at there I shall begin to the  happy"
p2 <- "One runs the risk of weeping a little, if one lets himself be tamed"
p3 <- "What makes the desert beautiful is that somewhere it hides a well"
littleprince <- c(p1, p2, p3)
strsplit(littleprince, " ")
strsplit(littleprince, " ")[[3]] 
strsplit(littleprince, " ")[[3]][5]


# 데이터 전처리(1) - apply 계열의 함수를 알아보자
weight <- c(65.4, 55, 380, 72.2, 51, NA)
height <- c(170, 155, NA, 173, 161, 166)
gender <- c("M", "F","M","M","F","F")

df <- data.frame(w=weight, h=height)
df
?apply
?lapply
apply(df, 1, sum, na.rm=TRUE)
apply(df, 2, sum, na.rm=TRUE)
lapply(df, sum, na.rm=TRUE)
sapply(df, sum, na.rm=TRUE)
tapply(1:6, gender, sum) # rm(sum)
tapply(df$w, gender, mean, na.rm=TRUE)
mapply(paste, 1:5, LETTERS[1:5], month.abb[1:5])



v<-c("abc", "DEF", "TwT")
sapply(v, function(d) paste("-",d,"-", sep=""))

l<-list("abc", "DEF", "TwT")
sapply(l, function(d) paste("-",d,"-", sep=""))
lapply(l, function(d) paste("-",d,"-", sep=""))

flower <- c("rose", "iris", "sunflower", "anemone", "tulip")
length(flower)
nchar(flower)
sapply(flower, function(d) if(nchar(d) > 5) return(d))
sapply(flower, function(d) if(nchar(d) > 5) d)
sapply(flower, function(d) if(nchar(d) > 5) return(d) else return(NA))
sapply(flower, function(d) paste("-",d,"-", sep=""))

sapply(flower, function(d, n=5) if(nchar(d) > n) return(d))
sapply(flower, function(d, n=5) if(nchar(d) > n) return(d), 3)
sapply(flower, function(d, n=5) if(nchar(d) > n) return(d), n=4)

count <- 1
myf <- function(x, wt=T){
  print(paste(x,"(",count,")"))
  Sys.sleep(1)
  if(wt) 
    r <- paste("*", x, "*")
  else
    r <- paste("#", x, "#")
  count <<- count + 1;
  return(r)
}
result <- sapply(df$w, myf)
length(result)
result
sapply(df$w, myf, F)
sapply(df$w, myf, wt=F)
rr1 <- sapply(df$w, myf, wt=F)
str(rr1)

count <- 1
sapply(df, myf)
rr2 <- sapply(df, myf)
str(rr2)
rr2[1,1]
rr2[1,"w"]
