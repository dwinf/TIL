# 문제1
str(iris)

# 문제2
df1 <- data.frame(x=c(1,2,3,4,5), y=c(2,4,6,8,10))
df1


# 문제3
col1 <- 1:5
col2 <- letters[1:5]
col3 <- 6:10
(df2 <- data.frame(col1, col2, col3))


# 문제4
product <- c('사과', '딸기', '수박')
price <- c(1800, 1500, 3000)
sell <- c(24, 38, 13)
df3 <- data.frame(제품명=product, 가격=price, 판매량=sell)
class('제품명') # 새로운 벡터를 만드는 것과 동일
class(df3$제품명)

# 문제5
mean(df3$가격)
mean(df3$판매량)


# 문제6
name <- c("Potter","Elsa", "Gates", "Wendy", "Ben")
gender <- factor(c("M", "F", "M", "F", "M"))
math <- c(85, 76, 99, 88, 40)
df4 <- data.frame(name, gender, math)
#(a)
stat <- c(76, 73, 95, 82, 35)
df4 <- cbind(df4, stat)
#df4$stat <- stat
#(b)
df4$score <- df4$math + df4$stat
#(c)
df4$grade <- ifelse(df4$score >= 150, 'A', 
                    ifelse(df4$score >=100, 'B', 
                           ifelse(df4$score >= 70, 'C', 'D')))


myemp <- read.csv('data/emp.csv') # /부터 시작하면 최상위 폴더부터 탐색
# 문제7
str(myemp)

# 문제8
myemp[c(3,4,5),] #myemp[3:5,]

# 문제9
myemp[,-1]

# 문제10
myemp$ename
myemp[,2]
myemp[, 'ename']
myemp[2]
myemp['ename']

# 문제11
myemp[c('ename', 'sal')]
subset(myemp, select = c('ename','sal'))

# 문제12
myemp[myemp$job=='SALESMAN', c('ename', "sal", "job")]
subset(myemp, c('ename', "sal", "job"), subset=myemp$job=='SALESMAN')
subset(myemp, myemp$job=='SALESMAN', c('ename', "sal", "job"))

# 문제13
subset(myemp, c('ename', 'sal', 'deptno'), subset=myemp$sal>=1000 &myemp$sal<=3000)
subset(myemp, sal>=1000 &sal<=3000, c('ename', 'sal', 'deptno'))
myemp[myemp$sal>=1000 & myemp$sal<=3000, c('ename', 'sal', 'deptno')]

# 문제14
subset(myemp, job!='ANALYST',c('ename', 'sal', 'job'))
myemp[!myemp$job=='ANALYST', c('ename', 'sal', 'job')]

# 문제15
subset(myemp, job=='ANALYST'|job=='SALESMAN',c('ename', 'job'))
myemp[myemp$job=='ANALYST'|myemp$job=='SALESMAN', c('ename', 'job')]

# 문제16
myemp[is.na(myemp$comm), c('ename', 'job')]
subset(myemp, is.na(myemp$comm), c("ename", "job"))

# 문제17
myemp[order(myemp$sal),]

# 문제18
dim(myemp)

# 문제19
myemp$deptno <- as.factor(myemp$deptno)
summary(myemp$deptno)
str(myemp)
# 문제20
myemp$job <- as.factor(myemp$job)
summary(myemp$job)













