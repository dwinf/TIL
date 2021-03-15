library(XML)
library(rvest)
url = "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"
read1 <- read_html(url)
read2 <- htmlParse(read1)
first_table <- getNodeSet(read2,"//table")[[1]]
xt <- readHTMLTable(first_table)
str(xt)
head(xt)


# http://www.airkorea.or.kr/ : 한국환경공단 실시간 자료 조회
# 테이블을 한방에 읽어오자 : 동적페이지
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
url <- "http://www.airkorea.or.kr/web/pmRelay?itemCode=11008&pMENU_NO=109"
remDr$navigate(url)

webElem <- remDr$findElement(using = "css", "#dateDiv_1 > img")
webElem$clickElement()
Sys.sleep(1)
webElem <- remDr$findElement(using = "css", "#ui-datepicker-div > table > tbody > tr:nth-child(2) > td:nth-child(6) > a")
webElem$clickElement()
Sys.sleep(1)
webElem <- remDr$findElement(using = "css", "#cont_body > form > div > div > a:nth-child(1)")
webElem$clickElement()
Sys.sleep(3)

library(XML)
elem <- remDr$findElement(using="css", value=".st_1")
elemtxt <- elem$getElementAttribute("outerHTML")
elem_html <- htmlTreeParse(elemtxt, asText = TRUE, useInternalNodes = T, encoding="UTF-8")
Sys.setlocale("LC_ALL", "English")
games_table <- readHTMLTable(elem_html, header = T, stringsAsFactors = FALSE)[[1]]
Sys.setlocale()
Encoding(names(games_table)) <- "UTF-8"
head(games_table)
str(games_table)
View(games_table)
tail(games_table)
Sys.getlocale()


# 10장

install.packages("carData")
library(carData)

# (1) 자료 준비
room.class <- TitanicSurvival$passengerClass  # 선실 정보
room.class                

# (2) 도수분포 계산
tbl <- table(room.class)   
tbl
sum(tbl)                                      # 전체 탑승객수 

# (3) 막대그래프 작성
barplot(tbl, main='선실별 탑승객',       
        xlab='선실 등급',
        ylab='탐승객수',
        col=c('blue', 'green', 'yellow'))                    

#(4) 원그래프 작성
tbl/sum(tbl)                                 # 선실별 탑승객 비율
par(mar=c(1,1,4,1))                     
pie(tbl, main='선실별 탑승객',       
    col=c('blue', 'green', 'yellow'))                    
par(mar=c(5.1,4.1,4.1,2.1))


# (1) 자료 준비
grad <- state.x77[,'HS Grad']   # 1970년대 주별 고등학교 졸업율
grad                

# (2) 사분위수
summary(grad)
var(grad)                # 분산
sd(grad)                 # 표준 편차

# (3) 히스토그램
hist(grad, main='주별 졸업율',
     xlab='졸업율',
     ylab='주의 개수',
     col='orange')

# (4) 상자그림
boxplot(grad, main='주별 졸업율',
        col='orange')

# (5) 졸업율이 가장 낮은 주
idx <- which(grad==min(grad))
grad[idx] # grad[which(grad==min(grad))]

# (6) 졸업율이 가장 높은 주
idx <- which(grad==max(grad))
grad[idx]

# (7) 졸업율이 평균 이하인 주
idx <- which(grad<mean(grad))
grad[idx] 


# (1) 자료 준비
ds <- read.csv('data/fdeaths.csv', row.names='year')
ds
str(ds)
head(ds)
#(2) 선그래프 작성
my.col <- c('black', 'blue','red', 'green','purple','dark gray')
my.lty <- 1:6

plot(1:12,                       # x data
     ds[1,],                     # y data(1974년 자료)
     main='월별 사망자 추이',    # 그래프 제목
     type='b',                   # 그래프 종류
     lty=my.lty[1],              # 선의 종류
     xlab='Month',               # x축 레이블
     ylab='사망자수',            # y축 레이블
     ylim=c(300,1200),           # y축 값의 범위   
     col=my.col[1]               # 선의 색
)

for( i in 2:6) {
  lines(1:12,                      # x data
        ds[i,],                    # y data(1975~1979)
        type='b',                  # 그래프 종류
        lty=my.lty[i],             # 선의 종류
        col=my.col[i]              # 선의 색
  )
}

legend(x='topright',               # 범례의 위치
       lty=my.lty,                 # 선의 종류
       col=my.col,                 # 선의 색
       legend=1974:1979            # 범례의 내용
)


plot(pressure$temperature,     # x축 자료
     pressure$pressure,        # y축 자료
     main='온도와 기압',       # 그래프 제목
     xlab='온도(화씨)',        # x축 레이블
     ylab='기압',              # y축 레이블
)

#(1) 자료의 확인
head(cars)

#(2) 산점도의 작성
plot(cars$speed,                        # x축 자료
     cars$dist,                         # y축 자료
     main='자동차 속도와 제동거리',     # 그래프 제목
     xlab='속도',                       # x축 레이블
     ylab='제동거리',                   # y축 레이블
)

#(3) 상관계수 
cor(cars$speed, cars$dist)

# (1) 자료 확인
st <- data.frame(state.x77)     # 매트릭스를 데이터프레임으로 변환 
head(st)

# (2) 다중 산점도 작성
plot(st)

# (3) 다중 상관계수
cor(st)

# 추가
cor(iris$Sepal.Length, iris$Sepal.Width)
cor(iris$Petal.Length, iris$Petal.Width)

cor(iris[,1:4])
plot(iris[,1:4])

# 12장

install.packages("treemap")

library(treemap)                     # treemap 패키지 불러오기
data(GNI2014)                        # 데이터 불러오기 
head(GNI2014)                        # 데이터 내용 보기 
treemap(GNI2014,
        index=c('continent','iso3'), # 계층 구조 설정(대륙-국가)
        vSize='population',          # 타일의 크기
        vColor='GNI',                # 타일의 컬러
        type='value',                # 타일 컬러링 방법
        bg.labels='yellow',          # 레이블의 배경색
        title="World's GNI")         # 나무지도 제목  


library(treemap)                            # treemap 패키지 불러오기
st <- data.frame(state.x77)                 # 매트릭스를 데이터프레임으로 변환
st <- data.frame(st, stname=rownames(st))   # 주의 이름 열 stname을 추가 

treemap(st,
        index=c('stname'),                   # 타일에 주 이름 표기
        vSize='Area',                        # 타일의 크기
        vColor='Income',                     # 타일의 컬러
        type='value',                        # 타일 컬러링 방법
        title='USA states area and income' ) # 나무그림의 제목

# (1) 자료 확인
ds <- read.csv('data/seoul_temp_2017.csv')
dim(ds)
head(ds)

# (2) 서울의 1년 기온 분포 
summary(ds$avg_temp)
boxplot(ds$avg_temp, 
        col='green', 
        ylim=c(-20,40), 
        xlab='서울 1년 기온',
        ylab='기온')

# (3) 월별 기온 분포 
# 월별 평균기온 계산 
month.avg <- aggregate(ds$avg_temp, 
                       by=list(ds$month),median)[2]
month.avg

# 평균기온 순위 계산 (내림차순) 
odr <- rank(-month.avg)
odr

# 월별 기온 분포 
boxplot(avg_temp~month, data=ds,  
        col=heat.colors(12)[odr],   # 상자의 색을 지정 
        ylim=c(-20,40), 
        ylab='기온',
        xlab='월',
        main='서울시 월별 기온 분포(2017)')


# (1) 자료 확인
head(airquality)
ds <- airquality[complete.cases(airquality),]   # 결측값 제거
unique(ds$Month)                                # 월 확인

# (2) 월별 오존농도 분포 
# 월별 평균 오존농도 계산
month.avg <- aggregate(ds$Ozone, 
                       by=list(ds$Month),median)[2]
month.avg

# 평균기온 순위 계산(내림차순) 
odr <- rank(-month.avg)
odr

# 월별 오존농도 분포 
boxplot(Ozone~Month, data=ds,  
        col=heat.colors(5)[odr],   # 상자의 색 지정 
        ylim=c(0,170), 
        ylab='오존농도',
        xlab='월',
        main='여름철 오존농도')

install.packages('fmsb')
library(fmsb) 

# (1) 자료 준비 
score <- c(80,60,95,85,40)
max.score <- rep(100,5)          # 100을 5회 반복
min.score <- rep(0,5)            # 0을 5회 반복
ds <- rbind(max.score,min.score, score)
ds <- data.frame(ds)             # 매트릭스를 데이터프레임으로 변환  
colnames(ds) <- c('국어','영어','수학','물리','음악')
ds

# (2) 방사형 차트 
radarchart(ds)

# [코드 12-5]에 이어 실행 
radarchart(ds,                           # 데이터프레임
           pcol='dark green',            # 다각형 선의 색 
           pfcol=rgb(0.2,0.5,0.5,0.5),   # 다각형 내부 색
           plwd=3,                       # 다각형 선의 두께
           cglcol='grey',                # 거미줄의 색
           cglty=1,                      # 거미줄의 타입
           cglwd=0.8,                    # 거미줄의 두께
           axistype=1,                   # 축의 레이블 타입
           seg=4,                        # 축의 눈금 분할                         
           axislabcol='grey',            # 축의 레이블 색
           caxislabels=seq(0,100,25)     # 축의 레이블 값
)


library(ggplot2)

month <- c(1,2,3,4,5,6)
rain  <- c(55,50,45,50,60,70)
df <- data.frame(month,rain)           # 그래프를 작성할 대상 데이터
df

ggplot(df, aes(x=month,y=rain)) +      # 그래프를 작성할 데이터 지정
  geom_bar(stat='identity',            # 막대그래프의 형태 지정  
           width=0.7,                  # 막대의 폭 지정
           fill='steelblue')           # 막대의 색 지정

# [코드 12-7]에 이어서
ggplot(df, aes(x=month,y=rain)) +      # 그래프를 그릴 데이터 지정
  geom_bar(stat='identity',            # 막대 높이는 y축에 해당하는 열의 값  
           width=0.7,                  # 막대의 폭 지정
           fill='steelblue') +         # 막대의 색 지정
  ggtitle('월별 강수량') +              # 그래프의 제목 지정
  theme(plot.title = element_text(size=25, face='bold', colour='steelblue')) +
  labs(x='월',y='강수량') +            # 그래프의 x, y축 레이블 지정
  coord_flip()                         # 그래프를 가로 방향으로 출력


library(ggplot2)

ggplot(iris, aes(x=Petal.Length)) +    # 그래프를 그릴 데이터 지정
  geom_histogram(binwidth =0.5)        # 히스토그램 작성 

library(ggplot2)

ggplot(iris, aes(x=Sepal.Width, fill=Species, color=Species)) +
  geom_histogram(binwidth = 0.5, position='dodge') +
  theme(legend.position='top')

library(ggplot2)

ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width)) + 
  geom_point()

library(ggplot2)

ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width,
                      color=Species)) + 
  geom_point(size=3) +
  ggtitle('꽃잎의 길이와 폭') +              # 그래프의 제목 지정
  theme(plot.title = element_text(size=25, face='bold', colour='steelblue')) 

library(ggplot2)

ggplot(data=iris, aes(y=Petal.Length)) + 
  geom_boxplot(fill='yellow') 

library(ggplot2)

ggplot(data=iris, aes(x=Species, y=Petal.Length, fill=Species)) + 
  geom_boxplot() 


library(ggplot2)

year <- 1937:1960
cnt <- as.vector(airmiles)
df <- data.frame(year,cnt)              # 데이터 준비
head(df)

ggplot(data=df, aes(x=year,y=cnt)) +    # 선그래프 작성
  geom_line(col='red') 

# 13장
install.packages("HSAUR")

library(HSAUR)
data("Forbes2000")
ds <- Forbes2000 
ds[!complete.cases(ds),]          # 결측값 확인

str(ds)
head(ds)

table(ds$country)
tmp <- sort(table(ds$country), decreasing=T)
top.10.contry <- tmp[1:10]
top.10.contry                     # 상위 10개국

par(mar=c(8,4,4,2))               # 그래프 여백 조정
barplot(top.10.contry,
        main='기업수 상위 10개국',
        col=rainbow(10),          # 레인보우 팔레트
        las=2
)
par(mar=c(5,4,4,2))

# 업종별 기업 분포
table(ds$category)
tmp <- sort(table(ds$category), decreasing=T)
top.10.category <- tmp[1:10]
top.10.category                    # 상위 10개 업종

par(mar=c(10,4,4,2))               # 그래프 여백 조정
barplot(top.10.category,
        main='기업수 상위 10개 업종',
        col='pink',
        las=2)
par(mar=c(5,4,4,2))

# 업종별 기업자산 분포
tmp <- ds[ds$category %in% names(top.10.category),]
levels(tmp$category)
tmp$category <- factor(tmp$category)
levels(tmp$category)

par(mar=c(10,4,4,2))               # 그래프 여백 조정
boxplot(assets~category, data=tmp,
        ylim=c(0,100),
        xlab='',
        las=2)
par(mar=c(5,4,4,2))


tmp <- ds[order(ds$marketvalue, decreasing=T),]
tmp[1:10,c('name', 'country','category','marketvalue')]


korea <- subset(ds, country=='South Korea')
korea[,c('rank','name','category','marketvalue')]


tmp <- ds[,5:8]
tmp <- tmp[complete.cases(tmp),]  # 결측값 제거
plot(tmp, lower.panel=NULL)       # 산점도
cor(tmp)                          # 상관계수


files <- c('data/ds.2015.csv', 'data/ds.2016.csv','data/ds.2017.csv',
           'data/ds.2018.csv','data/ds.2019.csv')

ds <- NULL
for (f in files) {
  tmp <- read.csv(f, header=T)
  ds <- rbind(ds, tmp) 
  print(f)
}

str(ds)
head(ds)
unique(ds$loc)                             # 관측 장소
range(ds$mdate)                            # 측정 기간

# 열별 결측값 확인
for (i in 3:8) {
  cat(names(ds)[i], sum(is.na(ds[,i])), sum(is.na(ds[,i]))/nrow(ds), '\n')   
}
ds <- ds[,-8]                              # PM25 열 제거
ds <- ds[complete.cases(ds),]              # 결측값 포함 행 제거

mdate <- as.character(ds$mdate)
head(mdate)
ds$year  <- as.numeric(substr(mdate, 1,4))  # 연도
ds$month <- as.numeric(substr(mdate, 5,6))  # 월
ds$hour  <- as.numeric(substr(mdate, 9,10)) # 시간
ds$locname <- NA                            # locname 열을 추가
ds$locname[ds$loc==111123] <- '서울'        # 도시
ds$locname[ds$loc==336111] <- '목포'        # 도시  
ds$locname[ds$loc==632132] <- '강릉'        # 도시

head(ds)


boxplot(PM10~locname, data=ds,
        main='미세먼지 농도 분포')

boxplot(PM10~locname, data=ds,
        main='미세먼지 농도 분포',
        ylim=c(1,100))

library(ggplot2)

tmp.year <- aggregate(ds[,7], by=list(year=ds$year,loc=ds$locname), FUN='mean')
tmp.year$loc = as.factor(tmp.year$loc)
head(tmp.year)

ggplot(tmp.year, aes(x=year,y=x, colour=loc, group=loc))+
  geom_line()+
  geom_point(size=6, shape=19, alpha=0.5)+
  ggtitle('연도별 PM10 농도 변화')+
  ylab('농도')

tmp.month <- aggregate(ds[,7], by=list(month=ds$month,loc=ds$locname), 
                       FUN='mean')
tmp.month$loc = as.factor(tmp.month$loc)
head(tmp.month)

ggplot(tmp.month, aes(x=month,y=x, colour=loc, group=loc))+
  geom_line()+
  geom_point(size=3, shape=19, alpha=0.5)+
  ggtitle('월별 PM10 농도 변화')+
  ylab('농도')


tmp.hour <- aggregate(ds[,7], by=list(hour=ds$hour,loc=ds$locname), FUN='mean')
tmp.hour$loc = as.factor(tmp.hour$loc)
head(tmp.hour)

ggplot(tmp.hour, aes(x=hour,y=x, colour=loc, group=loc))+
  geom_line()+
  geom_point(size=3, shape=19, alpha=0.5)+
  ggtitle('시간별 PM10 농도 변화')+
  ylab('농도')


set.seed(1234)
plot(ds[sample(nrow(ds),5000),3:7], lower.panel=NULL)
cor(ds[,3:7])


tmp.yml <- aggregate(ds[,7], by=list(year=ds$year,month=ds$month,
                                     loc=ds$locname), FUN='mean')

# 가장 미세먼지가 많았던 달
idx <- which(tmp.yml$x==max(tmp.yml$x))
tmp.yml[idx,]

# 가장 미세먼지가 적었던 달
idx <- which(tmp.yml$x==min(tmp.yml$x))
tmp.yml[idx,]

