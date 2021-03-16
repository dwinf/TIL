library(psych)
library(MASS)
library(corrgram)
library(corrplot)

data("airquality")
str(airquality)
head(airquality)

air <- cor(airquality[,1:4], use="complete.obs")


pairs(airquality[,1:4])
dev.copy(png,"output/lab20_1.png")
dev.off()

pairs.panels(airquality[,1:4], bg="red", pch=21, hist.col="gold", 
             main="Correlation Plot of airquality Data")
dev.copy(png,"output/lab20_2.png")
dev.off()


corrplot(air, method="pie", type="lower", addCoef.col="black", order="hclust", tl.srt=45, diag=F)
dev.copy(png,"output/lab20_3.png")
dev.off()

#################################################################
# CASE1
data("airquality")

str(airquality)
airquality_test <- airquality[,1:4]
airquality_test <- na.omit(airquality_test) # na 제거

# 상관 계수, p-value
corr.test(airquality_test)

# p-value 0.05 이상
cor.test(airquality_test$Wind, airquality_test$Solar.R)


# 시각화 1
pairs(airquality_test)


# 시각화 2
pairs.panels(airquality_test, bg="red", pch=21, hist.col="gold", 
             main="Correlation Plot of US States Data")

# 시각화 3
corrplot(cor(airquality_test), method="pie", type="lower", order="hclust", tl.srt=45, diag=F, addCoef.col="black")

#################################################################
# CASE2

#결측치 행 제거
airquality <- airquality[complete.cases(airquality),]

#상관행렬 
air <- airquality[1:4]
air_cor <- cor(air)
air_cor 

#통계적 유의성 만족 X : Solar.R 과 Wind (p-value = 0.1835)
cor.test(air$Ozone, air$Solar.R)
cor.test(air$Ozone, air$Wind)
cor.test(air$Ozone, air$Temp)
cor.test(air$Solar.R, air$Wind)
cor.test(air$Solar.R, air$Temp)
cor.test(air$Wind, air$Temp)


#그림 1
pairs(air)

#그림 2
pairs.panels(air, bg='red', pch=21, hist.col='gold',
             main='Correlation Plot of airquality Data')

#그림 3
corrplot(air_cor, method='pie', type='lower', order='hclust', addCoef.col = 'black', tl.srt=45, diag=F)

#################################################################
# CASE3
library(dplyr)

head(airquality)
airquality[complete.cases(airquality),]  -> airquality2
airquality2[1:4] -> airquality2
airquality2 %>% mutate_all(as.numeric) -> airquality2
pairs(airquality2)

cor(airquality2, use="complete.obs")-> airquality3
print(corr.test(airquality2[]), short=FALSE)
cor.test(airquality2$Wind, airquality2$Solar.R)

pairs.panels(airquality2, bg="red", pch=21, hist.col="gold", 
             main="Correlation Plot airquality Data")

corrplot(airquality3, method="pie",addCoef.col="black", type="lower", order="hclust", tl.srt=45, diag=F)
