# 문제 1
click <- read.table("data/product_click.log")
click_count <- table(click$V2)
barplot(click_count, xlab="상품ID", ylab="클릭 수", 
        xlim=c(0, 11), ylim=c(0, 100), col=terrain.colors(10)) 
title(main="세로바 그래프 실습", col.main="red", family="maple")

png(filename="output/clicklog1.png", height=600, width=600, bg="white")
barplot(click_count, xlab="상품ID", ylab="클릭 수", 
        xlim=c(0, 11), ylim=c(0, 100), col=terrain.colors(10)) 
title(main="세로바 그래프 실습", col.main="red", family="maple")
dev.off()


# 문제 2
times <- substring(as.vector(click$V1), 9, 10)
(times <- table(times))
names(times) <- c("0-1", "1-2", "2-3", "3-4", "4-5", "5-6", "8-9", 
                  "9-10", "10-11", "11-12", "12-13", "13-14", 
                  "14-15", "15-16", "16-17", "17-18", "18-19")
pie(times, labels=paste(names(times)),col=rainbow(17))
title(main="파이그래프 실습", col.main="blue", family="maple")

png(filename="output/clicklog2.png", height=600, width=600, bg="white")
pie(times, labels=paste(names(times)),col=rainbow(17))
title(main="파이그래프 실습", col.main="blue", family="maple")
dev.off()


# 문제 3
score <- read.table("data/성적.txt", header=T)
score
boxplot(score[, 3:5], col=rainbow(3), ylim=c(0,10), ylab="성적")
title(main="과목별 성적 분포", col.main="orange", font.main=4, family="maple")

png(filename="output/clicklog3.png", height=600, width=600, bg="white")
boxplot(score[, 3:5], col=rainbow(3), ylim=c(0,10), ylab="성적")
title(main="과목별 성적 분포", col.main="orange", font.main=4, family="maple")
dev.off()


# 문제 4
mscore <- NULL
mscore <- rbind(mscore, score[,3])
mscore <- rbind(mscore, score[,4])
mscore <- rbind(mscore, score[,5])
colnames(mscore) <- score[,2]
rownames(mscore) <- names(score[,3:5])

barplot(mscore, xlim=c(0, 10), ylim=c(0, 25), legend.text = T, args.legend = list(x="topright", inset=c(-0.15, -0.15)))
title(main="학생별 점수", col.main="magenta", font.main=4, family="maple")
score <- score[,2:5]

class(mscore)
?barplot


