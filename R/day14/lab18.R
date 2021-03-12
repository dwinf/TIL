# 문제 1
data(mpg)

ggplot(mpg,aes(cty, hwy)) + geom_point(colour = "blue")
ggsave("output/result1.png") 


# 문제 2
ggplot(data = mpg, aes(x = class, fill = drv)) + geom_bar()
ggsave("output/result2.png") 


# 문제 3
product_click <- read.table("data/product_click.log")
click_count <- table(product_click$V2)

ggplot(data = product_click, aes(x = V2)) + geom_bar(aes(fill=V2))
ggsave("output/result3.png") 


# 문제 4
library(dplyr)
product_click <- product_click %>% 
  mutate(day = format(as.Date(as.character(product_click$V1),format='%Y%m%d'), '%A'))

ggplot(data = product_click, aes(x = day)) + geom_bar(aes(fill=day)) + 
  labs(x = "요일", y = "클릭수") + theme_bw()
ggsave("output/result4.png") 


# 문제 5
library(treemap)
?treemap

data(GNI2014)
png(filename="output/result5.png", height=600, width=600, bg="white")
treemap(GNI2014, vSize="population", index=c("continent", "iso3"), title="전세계 인구 정보", 
        fontfamily.title="maple", fontfamily.labels="maple", fontsize.title = 20, border.col = "green")
dev.off()
