# 문제 1
# CASE1
(productlog <- read.table("data/product_click.log", header=FALSE))
(productlog2 <- table(productlog))
(logdata <- colSums(productlog2))

library(showtext)
showtext_auto() 
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")

barplot(logdata, col=terrain.colors(10),main="세로바 그래프 실습",
        xlab="상품ID", ylab="클릭수", col.main="red", font.main=4, family="dog", cex.main=3)

dev.copy(png,"output/clicklog1.png")
dev.off()

# CASE2
성적 <- read.table("data/product_click.log", header=F)
head(성적)
pdata <- 성적[,2]
pdata2 <- table(pdata) # table 함수 정리하기

# barplot 출력
barplot(pdata2,
        col=terrain.colors(10),
        xlab='상품ID',
        ylab='클릭수')
title(main='세로바 그래프 실습', col.main="red", font.main=4, family="maple")

# barplot 저장
png(filename="clicklog1.png", height=400, width=600, bg="white")
barplot(pdata2, col=terrain.colors(10))
title(main='세로바 그래프 실습', col.main="red", font.main=4, family="maple")
title(xlab="상품ID")
title(ylab="클릭수")
dev.off()

# CASE3
pdata <- read.table("data/product_click.log");head(pdata)
names(pdata) <- c("clicktime", "pid")
str(pdata)
# 문제 1
png(filename="clicklog1.png", height=400, width=700, bg="white")
par(mar=c(5,5,5,5), mfrow=c(1,1))
barplot(table(pdata$pid), col=terrain.colors(10), main="세로바 그래프 실습", ylab="클릭수",
        xlab="상품ID", ylim=c(0,100), family="dog", cex.main=2.0, col.main="red")
dev.off()



# 문제 2


# CASE1

성적 <- read.table("data/product_click.log", header=F)
head(성적)
date <- 성적[,1]
time <- substr(date, 9, 10)
time2 <- table(time)

time3 <- data.frame(time2)
time3$time[1:17]
time3$time[2:18] # 19는 NA로 표시..어떻게 해결해야할까?

# pie 출력
pie(time2, 
    main='파이그래프 실습',
    labels=paste(time3$time[1:17],"-",time3$time[2:18]),
    col=heat.colors(10),
    radius=1)

pie(time2, 
    main='파이그래프 실습',
    labels=paste(time3$time[1:17],"-",ifelse(!is.na(time3$time[2:18]),time3$time[2:18], "19")),
    col=heat.colors(10),
    radius=1)

# CASE2
# 문제 2
data3 <- pdata$clicktime
data3_hour <- substr(data3, 9, 10)
table_data3 <- table(data3_hour)
length(table_data3)


names(table_data3)

piename <- paste(as.integer(names(table_data3)), "~",as.integer(names(table_data3)) +1, sep='')
names(table_data3) <- piename
pie(table_data3, main="파이그래프 실습", col=rainbow(17), family="maple", cex.main=2.0, 
    col.main="blue")


# 문제 3

# CASE1
(grade <- read.table("data/성적.txt", header=TRUE))
grade2 <- grade[,3:5]
boxplot(grade2, col=rainbow(3),axes=F)
axis(1, at=1:3, lab=names(grade2), family="maple") # x축 추가
axis(2, at=seq(2, 10, 2), family="maple") # y축 추가
title("과목별 성적 분포", family="maple", cex.main=2,col.main="orange")
box()
dev.copy(png,"output/clicklog3.png")
dev.off()

# CASE2
(성적 <- read.table("data/성적.txt", header=TRUE))
성적2 <- 성적[,3:5]

# boxplot 출력
boxplot(성적2, col=rainbow(3), family="maple", ylim=c(2,10)) # 왜 family font가 적용이 안될까?
title(main="과목별 성적 분포", col.main="orange", font.main=4, family="maple", cex.main=3)







# 문제 4
# CASE1
grade3 <- grade[,3:5]
rownames(grade3) <- grade[,2]
grade3 <- as.matrix(grade3)

barplot(t(grade3),main = "학생별 점수", 
        col=c('orange','skyblue','pink'),
        beside=FALSE,
        family="dog",
        col.main="violet",
        cex.main = 2,
        legend.text = c("국어", "수학", "영어") )


dev.copy(png,"output/clicklog4.png")
dev.off()


# CASE2

score <- rbind(성적$국어, 성적$수학, 성적$영어)
colnames(score) <- 성적$성명
score
str(score)
class(score)

# barplot 출력
barplot(score, 
        main='학생별 점수', 
        col=rainbow(10),
        legend.text=c('국어','수학','영어'))
# barplot 저장
png(filename="clicklog4.png", height=600, width=800, bg="white")
par(mfrow=c(1, 1), mar=c(5, 5, 5, 7))
barplot(score, col=rainbow(10))
title(main='학생별 점수')
legend(11,28,c('국어','수학','영어'), fill=rainbow(10))
dev.off()



# CASE3
s <- t(성적[, 3:5])
colname <- c("길동","둘리","또치","도우너","희동","듀크","턱시","토토로","올라프","우디")         
colnames(s) <- colname
barplot(s, col=c("orange","skyblue","pink"),family="dog")
title("학생별 점수", family="dog", cex.main=3, col.main="magenta")
legend(x="topright", c("국어","수학","영어"), cex=1.2, fill=c("orange","skyblue","pink"))  


