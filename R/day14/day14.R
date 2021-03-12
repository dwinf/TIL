# 여러 데이터프레임 합치기
library(dplyr)

# 학생 1~5번 시험 데이터 생성
(group_a <- data.frame(id = c(1, 2, 3, 4, 5),  test = c(60, 80, 70, 90, 85)))
# 학생 6~10번 시험 데이터 생성
(group_b <- data.frame(id = c(6, 7, 8, 9, 10),  test = c(70, 83, 65, 95, 80)))

bind_rows(group_a, group_b)  # 변수명이 다르면 다른 열로 생성되지만 인덱스는 group_a 다음부터
bind_cols(group_a, group_b)  # 변수명이 같으면 id에 ...(숫자)를 추가

one <- data.frame(c(x = c(1:1000000), y = c(1:1000000))) 
two <- data.frame(c(x = c(1:1000000), y = c(1:1000000)))
system.time(rbind(one, two)) 
system.time(bind_rows(one, two)) # 수행성능이 rbind보다 좋아 큰단위의 처리에 유리

head(one);head(two)

# 중간고사 데이터 생성
test1 <- data.frame(no = c(1, 2, 3, 4, 5, 6),  
                    midterm = c(60, 80, 70, 90, 85, 100))
# 기말고사 데이터 생성
test2 <- data.frame(no = c(1, 5, 3, 4, 2, 7),  
                    final = c(70, 80, 65, 95, 83, 0))

# no값을 기준으로 붙임
inner_join(test1, test2, by = "no")  # no가 같은 것만
left_join(test1, test2, by = "no")   # 왼쪽 데이터프레임을 기준으로
right_join(test1, test2, by = "no")  # 오른쪽 데이터프레임을 기준으로
full_join(test1, test2, by = "no")   # 전체 데이터프레임

merge(test1, test2)
merge(test1, test2, all.x = T)
merge(test1, test2, all.y = T)
merge(test1, test2, all = T)

# 다른 데이터 활용해 변수 추가하기
# 반별 담임교사 명단 생성
name <- data.frame(class = c(1, 2, 3, 4, 5), teacher = c("kim", "lee", "park", "choi", "jung"))
# class 기준 합치기
exam_new <- left_join(exam, name, by = "class")



# 데이터 정제 : 결측치(NA)와 이상치 처리

df <- data.frame(sex = c("M", "F", NA, "M", "F"), 
                 score = c(5, 4, 3, 4, NA))
df
# 결측치 확인하기
is.na(df)         # 결측치 확인
table(is.na(df))  # 결측치 빈도 출력
# 변수별로 결측치 확인하기
table(is.na(df$sex))    # sex 결측치 빈도 출력
table(is.na(df$score))  # score 결측치 빈도 출력

# 결측치 포함된 상태로 분석
mean(df$score)  # 평균 산출
sum(df$score)   # 합계 산출
# 결측치 있는 행 제거하기

df %>% filter(is.na(score))   # score가 NA인 데이터만 출력
df %>% filter(!is.na(score))  # score 결측치 제거

# 결측치 제외한 데이터로 분석하기
df_nomiss <- df %>% filter(!is.na(score))  # score 결측치 제거
mean(df_nomiss$score)                      # score 평균 산출
sum(df_nomiss$score)                       # score 합계 산출

# 여러 변수 동시에 결측치 없는 데이터 추출하기
# score, sex 결측치 제외
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss  
# 결측치가 하나라도 있으면 제거하기
df_nomiss2 <- na.omit(df)  # 모든 변수에 결측치 없는 데이터 추출
df_nomiss2

#분석에 필요한 데이터까지 손실 될 가능성 유의
# 함수의 결측치 제외 기능 이용하기 - na.rm = T
mean(df$score, na.rm = T)  # 결측치 제외하고 평균 산출
sum(df$score, na.rm = T)   # 결측치 제외하고 합계 산출


#summarise()에서 na.rm = T사용하기
# 결측치 생성
exam <- read.csv("data/csv_exam.csv")            # 데이터 불러오기
table(is.na(exam))
exam[c(3, 8, 15), "math"] <- NA             # 3, 8, 15행의 math에 NA 할당
#평균 구하기
exam %>% summarise(mean_math = mean(math))             # 평균 산출
exam %>% summarise(mean_math = mean(math, na.rm = T))  # 결측치 제외하고 평균 산출
# 다른 함수들에 적용
exam %>% summarise(mean_math = mean(math, na.rm = T),      # 평균 산출
                   sum_math = sum(math, na.rm = T),        # 합계 산출
                   median_math = median(math, na.rm = T))  # 중앙값 산출


boxplot(exam$math) # boxplot은 NA 값을 제외시키고 처리


mean(exam$math, na.rm = T)  # 결측치 제외하고 math 평균 산출
# 평균으로 대체하기
exam$math <- ifelse(is.na(exam$math), 55, exam$math)  # math가 NA면 55로 대체
table(is.na(exam$math))                               # 결측치 빈도표 생성
mean(exam$math)  # math 평균 산출

# 이상치 포함된 데이터 생성 - gender 3, score 6
outlier <- data.frame(gender = c(1, 2, 1, 3, 2, 1),  score = c(5, 4, 3, 4, 2, 6)) 
# 이상치 확인하기
table(outlier$gender)

table(outlier$score)

# 결측 처리하기 - gender
# sex가 3이면 NA 할당
outlier$gender <- ifelse(outlier$gender == 3, NA, outlier$gender)

#결측 처리하기 - score
# sex가 1~5 아니면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)

outlier

# 결측치 제외하고 분석
outlier %>%
  filter(!is.na(sex) & !is.na(score)) %>%
  group_by(gender) %>%
  summarise(mean_score = mean(score))

View(mpg)
boxplot(mpg$hwy)
boxplot(mpg$hwy, notch=T) # , notch=T
boxplot(mpg$hwy, range=0) # 이상치 체크X
summary(mpg$hwy)
#상자그림 통계치 출력
boxplot(mpg$hwy)$stats  # 상자그림 통계치 출력

# 결측 처리하기
# 12~37 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))
# 결측치 제외하고 분석하기
mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T))




# 난생처음 교재 소스 : 394 페이지
# 11장 : 데이터 전처리 알아보기

z <- c(1,2,3,NA,5,NA,8)      # 결측값이 포함된 벡터 z
sum(z)                       # 정상 계산이 되지 않음
is.na(z)                     # NA 여부 확인
sum(is.na(z))                # NA의 개수 확인
sum(z, na.rm=TRUE)           # NA를 제외하고 합계를 계산

z1 <- c(1,2,3,NA,5,NA,8)      # 결측값이 포함된 벡터 z1
z2 <- c(5,8,1,NA,3,NA,7)      # 결측값이 포함된 벡터 z2
z1[is.na(z1)] <- 0            # NA를 0 로 치환 
z1                            
z3 <- as.vector(na.omit(z2))  # NA를 제거하고 새로운 벡터 생성
z3


# NA를 포함하는 test 데이터 생성
x <- iris
x[1,2]<- NA; x[1,3]<- NA
x[2,3]<- NA; x[3,4]<- NA  
head(x)


# for를 이용한 방법
for (i in 1:ncol(x)) {
  this.na <- is.na(x[,i]) 
  cat(colnames(x)[i], '\t', sum(this.na), '\n')
}

# apply를 이용한 방법
col_na <- function(y) {
  return(sum(is.na(y)))
}

na_count <-apply(x, 2, FUN=col_na)
na_count


rowSums(is.na(x))            # 행별 NA 개수  
sum(rowSums(is.na(x))>0)     # NA가 포함된 행의 개수 
sum(is.na(x))                # 데이터셋 전체에서 NA 개수


head(x)
x[!complete.cases(x),]              # NA가 포함된 행들을 나타냄
y <- x[complete.cases(x),]          # NA가 포함된 행들을 제거
head(y)                             # 새로운 데이터셋 y의 내용 확인





agg <- aggregate(iris[,-5], by=list(iris$Species), # 교안에서는 dplyr대신 aggregate 사용
                 FUN=mean)
agg

agg <- aggregate(iris[,-5], by=list(품종=iris$Species), 
                 FUN=sd)
agg

head(mtcars)
agg <- aggregate(mtcars, by=list(cyl=mtcars$cyl,
                                 vs=mtcars$vs),FUN=max)
agg

agg <- aggregate(mtcars, by=list(vs=mtcars$vs,cyl=mtcars$cyl),FUN=max)
agg





library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")

# ggplot2 패키지를 활용한 고급시각화

install.packages("ggplot2") # ggplot2 패키지 설치
library(ggplot2)
library(dplyr)

str(mpg)
ggplot() 
ggplot(mpg) 
ggplot(mpg,aes(displ, hwy))
ggplot(mpg,aes(displ, hwy)) + geom_point()
ggplot(mpg) + geom_point(aes(displ, hwy))

# x축 displ, y축 hwy로 지정해 배경 생성
sketch <- ggplot(data = mpg, aes(x = displ, y = hwy))
str(sketch)

sketch + geom_point()
sketch + geom_line()
sketch + geom_point() + coord_cartesian(xlim=c(3, 6)) # x축 값의 범위 지정
sketch + geom_point() + coord_cartesian(xlim=c(3, 6), ylim=c(10, 30))
sketch + geom_point(aes(color=drv))
ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()

data(airquality)
str(airquality)
View(airquality)
?airquality

ggplot(airquality, aes(x=Day, y=Temp))
ggplot(airquality, aes(x=Day, y=Temp)) + geom_point()
ggplot(airquality, aes(x=Day, y=Temp)) + geom_point(size=3, color="red")
ggplot(airquality, aes(x=Day, y=Temp)) + geom_line()
ggplot(airquality, aes(x=Day, y=Temp)) + geom_line() + geom_point() # + 를 통해 여러 그래프를 겹칠 수 있다.
ggplot(airquality, aes(x=Day, y=Temp)) + geom_line(color="green") + geom_point(size=3)


df_mpg <- mpg %>% group_by(drv) %>% summarise(mean_hwy = mean(hwy))

# 집계 막대 그래프 - 미리 집계해서 줘야함
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

# 빈도 막대 그래프
ggplot(data = mpg, aes(x = drv)) + geom_bar()

# 상자 그림
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

# 선 그래프
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

ggplot(airquality, aes(x=Day, y=Temp, group=Day)) + geom_boxplot()
ggplot(airquality, aes(Temp)) + geom_histogram()


str(mtcars)
?mtcars   
View(mtcars)
table(mtcars$cyl)
summary(mtcars$cyl)
summary(factor(mtcars$cyl))
ggplot(mtcars, aes(x=cyl)) + geom_bar()
ggplot(mtcars, aes(x=cyl)) + geom_bar(width=0.5)
ggplot(mtcars, aes(x=cyl)) + geom_bar(aes(fill=factor(gear)), alpha=0.5)
ggplot(mtcars, aes(x=cyl)) + geom_bar(aes(fill=factor(gear)), alpha=1.0)


ggplot(mtcars, aes(x=gear))+geom_bar() + labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") + theme_gray()
ggplot(mtcars, aes(x=gear))+geom_bar() + labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") + theme_bw()
ggplot(mtcars, aes(x=gear))+geom_bar() + labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") + theme_linedraw()
ggplot(mtcars, aes(x=gear))+geom_bar() + labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") + theme_light()
ggplot(mtcars, aes(x=gear))+geom_bar() + labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") + theme_dark()
ggplot(mtcars, aes(x=gear))+geom_bar() + labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") + theme_minimal()
ggplot(mtcars, aes(x=gear))+geom_bar() + labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") + theme_classic()
ggplot(mtcars, aes(x=gear))+geom_bar() + labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") + theme_void()


imsi <- ggplot(mtcars, aes(x=gear))+geom_bar() + labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수")
str(imsi)
imsi + theme_gray()
imsi + theme_bw()
imsi + theme_linedraw()
imsi + theme_light()
imsi + theme_dark()
imsi + theme_minimal()
imsi + theme_classic()
imsi + theme_void()




install.packages("xlsx")
library(xlsx)
classDF <- read.xlsx("data/data.xlsx", 1, encoding="UTF-8")
str(classDF)
View(classDF)

bar_data <- classDF[3]
bar_data
str(bar_data)
table(bar_data$bloodType)
ggplot(bar_data, aes(x=bloodType)) + geom_bar()
ggplot(classDF, aes(x=bloodType)) + geom_bar(aes(fill=gender))


# A, B회사의 매출 실적 데이터프레임 만들기
company <- c('A', 'A', 'A', 'A', 'B', 'B', 'B', 'B')
year <- c('1980', '1990', '2000', '2010', '1980', '1990', '2000', '2010')
sales <- c(2750, 2800, 2830, 2840, 2760, 2765, 2775, 2790)

coSalesDF <- data.frame(company, year, sales)

# 생성된 coSalesDF 확인
coSalesDF
str(coSalesDF)
# 라인차트 생성 - x축은 연도(year), y축은 매출(sales) 매칭
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line()
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(aes(group=company))
# 선 색상 및 두께 설정
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(size=2, aes(group=company,colour=company))
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(size=2, aes(group=company,colour=company))+scale_colour_grey()
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(size=2, aes(group=company,colour=company))+scale_colour_hue()
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(size=2, aes(group=company,colour=company))+scale_colour_manual(values = c("orange", "green"))
# 선의 종류 :  0 = blank, 1 = solid, 2 = dashed, 3 = dotted, 4 = dotdash, 5 = longdash, 6 = twodash
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(size=2, aes(group=company,colour=company), linetype = 3)
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(size=2, aes(group=company,colour=company), linetype = "dotdash")
# 점의 종류와 색상
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(size=2, aes(group=company, colour=company)) + geom_point(size=2, shape = 5)
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(size=2, aes(group=company, colour=company)) + geom_point(size=2, shape = '가')
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(size=2, aes(group=company, colour=company)) + geom_point(size=2, shape = '가', colour = "Red")

library(MASS)
str(Cars93)
ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + geom_point(shape=21, size=6)
ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + geom_point(shape=21, size=6, colour="blue")
ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + geom_point(shape=21, size=6, fill="blue")  
ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + geom_point(shape=21, size=6, fill="blue", colour="pink") 
ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + geom_point(colour="grey", shape=21, size=6) 
ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Price)) + geom_point(colour="grey", shape=21, size=6) 
ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + geom_point(colour="grey", shape=21, size=6, aes(fill=Price)) 
ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +  geom_point(colour="grey", shape=21, size=6)

Cars93$Cylinders
Cars93$Price

class(Cars93$Cylinders)
class(Cars93$Price)


ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +
  geom_point(colour="grey", shape=21, size=6) +
  scale_fill_brewer(palette="Oranges") # Oranges  

ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +
  geom_point(colour="grey", shape=21, size=6) +
  scale_fill_brewer(palette="Reds") # Reds

ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +
  geom_point(colour="grey", shape=21, size=6) +
  scale_fill_brewer(palette="Blues") # Blues


w <- data.frame(year=c("2014", "2015", "2016", "2017", "2018"), 
                weight=c(65,66,64,68,72))
ggplot(data=w, aes(x=year)) + geom_bar()
ggplot(data=w, aes(x=year, y=weight)) + geom_bar() # 갯수를 세서 막대를 그리는게 기본이라.. 에러난다!!
ggplot(data=w, aes(x=year, y=weight)) + geom_col() 
ggplot(data=w, aes(x=year, y=weight)) + geom_bar(stat="identity") # geom_col보다 많이 쓰임
ggplot(data=w, aes(x=year, y=weight)) + geom_bar(stat="identity") + coord_cartesian(ylim=c(60, 75))
ggplot(data=w, aes(x=year, y=weight)) + geom_bar(aes(fill=year), stat="identity") + coord_cartesian(ylim=c(60, 75))
ggplot(data=w, aes(x=year, y=weight)) + geom_bar(aes(fill=year), colour="blue", stat="identity") + coord_cartesian(ylim=c(60, 75))
ggplot(data=w, aes(x=year, y=weight)) + geom_bar(aes(fill=year), stat="identity") + geom_label(aes(label=weight))+coord_cartesian(ylim=c(60, 75))
ggplot(data=w, aes(x=year, y=weight)) + geom_bar(aes(fill=year), stat="identity") + geom_label(aes(label=weight), nudge_y=1)+coord_cartesian(ylim=c(60, 75))
ggplot(data=w, aes(x=year, y=weight)) + geom_bar(aes(fill=year), stat="identity") + geom_label(aes(label=weight), nudge_y=2)+coord_cartesian(ylim=c(60, 75))
ggplot(data=w, aes(x=year, y=weight)) + geom_bar(aes(fill=year), stat="identity") + geom_label(aes(label=weight), nudge_y=-1)+coord_cartesian(ylim=c(60, 75)) + labs(title = "테스트", subtitle="ggplot2 패키지를 이용한 시각화", x="년도", y="무게")
ggsave("ggplot_test.png") 



ggplot(mpg, aes(x=displ, y=hwy,  color= manufacturer))+geom_point()
ggplot(mpg, aes(x=displ, y=hwy,  color= manufacturer))+geom_point() + scale_color_manual(values = rainbow(15))
ggplot(mpg, aes(x=displ, y=hwy,  color= manufacturer))+geom_point() + scale_color_manual(values = topo.colors(15))
ggplot(mpg, aes(x=displ, y=hwy,  color= manufacturer))+geom_point() + scale_color_brewer(palette = 'Set3')
# 범례 행 갯수 설정
ggplot(mpg, aes(x=displ, y=hwy,  color= manufacturer))+
  geom_point()+guides(color = guide_legend(nrow = 6))

# 범례 열 갯수 설정
ggplot(mpg, aes(x=displ, y=hwy,  color= manufacturer))+
  geom_point()+ scale_fill_brewer(palette="Reds")+ guides(color = guide_legend(ncol = 2)) 

# 범례 항목들 역순으로
ggplot(mpg, aes(x=displ, y=hwy,  color= manufacturer))+
  geom_point()+guides(color = guide_legend(reverse = TRUE))

# 범례 없애기
ggplot(mpg, aes(x=displ, y=hwy,  color= manufacturer))+
  geom_point()+guides(color=F)


p1 <- ggplot(data = iris, aes(x = Petal.Width, y= Petal.Length, col=Species)) + geom_point()
p2 <- ggplot(data = iris, aes(x = Sepal.Width, y= Sepal.Length, col=Species)) + geom_point() 
install.packages("gridExtra")
library(gridExtra)
grid.arrange(p1, p2, p1, p2, nrow = 2)


# 인터랙티브 그래프 만들기
# 패키지 준비하기
install.packages("plotly")
library(plotly)
# ggplot으로 그래프 만들기
p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()
p

# 인터랙티브 그래프 만들기
ggplotly(p) # 뷰어에서 보임 == html로 작성된다는 뜻

# 인터랙티브 막대 그래프 만들기
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) + geom_bar()
ggplotly(p)

# 인터랙티브 막대 그래프 만들기
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) + geom_bar(position = "dodge")
ggplotly(p)

p <- ggplot(mpg, aes(x=displ, y=hwy,  color= manufacturer))+geom_point()
ggplotly(p)



# 트리맵 라이브러리 설치
install.packages("treemap")
# 트리맵 메모리 로드
library(treemap)

sales_df <- read.xlsx("data/data.xlsx", 2, encoding="UTF-8")
# 트리맵 그리기
# index에 표현하고 싶은 계층 순서대로 벡터로 생성. product, region 순으로 벡터를 지정함으로써 
# product가 region보다 더 상위로 구분이 됨
treemap(sales_df, vSize="saleAmt", index=c("product", "region"), title="A기업 판매현황", fontfamily.title="maple", fontfamily.labels="maple")

# 트리맵 그리기
treemap(sales_df, vSize="saleAmt", index=c("region", "product"), title="A기업 판매현황", fontfamily.title="dog", fontfamily.labels="dog")

dev.copy(png, "test.png")
dev.off()