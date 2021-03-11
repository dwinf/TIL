# 문제 1
library(ggplot2)
# 1-1 mpg의 구조를 확인한다.
str(mpg)
mpg %>% str

# 1-2 mpg 의 행의 개수와 열의 개수를 출력한다.
dim(mpg)
mpg %>% nrow
mpg %>% ncol
mpg %>% dim

# 1-3 mpg의 데이터를 앞에서 10개 출력한다.
mpg %>% head(10)
mpg %>% head(.,10)

# 1-4 mpg의 데이터를 뒤에서 10개 출력한다.
mpg %>% tail(10)
mpg %>% tail(.,10)

# 1-5. mpg의 데이터를 GUI 환경으로 출력한다.
View(mpg)
mpg %>% View

# 1-6 mpg를 열 단위로 요약한다.
summary(mpg)
mpg %>% summary

# 1-7 mpg 데이터셋에서 제조사별 차량의 수를 출력한다.
mpg %>% count(manufacturer)

# 1-8 mpg 데이터셋에서 제조사별 그리고 모델별 차량의 수를 출력한다.
mpg %>% group_by(manufacturer) %>% count(model)
mpg %>% count(manufacturer, model)


# 문제 2
# 2-1
mpg %>% rename(city=cty, highway=hwy) -> mpg2

# 2-2
mpg2 %>% head


# 문제 3
# 3-1
str(as.data.frame(midwest)) # str(midwest)
midwest %>% as.data.frame() %>% str # midwest %>% str


# 3-2
midwest %>% rename(total=poptotal, asian=popasian) -> midwest

# 3-3
midwest %>% mutate(AoT = (asian/total)*100) -> midwest
midwest %>% select(AoT)

# 3-4
pa <- midwest %>% summarise(mean(midwest$AoT))
midwest %>% mutate(asian_ratio = ifelse(AoT > as.numeric(pa), "Large", "small")) -> midwest
midwest %>% select(AoT, asian_ratio)

midwest %>% mutate(size = ifelse(AoT > mean(AoT), "Large", "small"))
  

# 문제 4
# 4-1_1
less4 <- mpg %>% filter(displ <= 4)
over5 <- mpg %>% filter(displ >= 5)
mean(less4$hwy)
mean(over5$hwy)
# 4-1_2
mpg %>% 
  filter(displ <= 4 | displ >= 5) %>%
  group_by(displ <= 4) %>%
  summarise(mean(hwy))

# 4-2
mpg %>% 
  filter(manufacturer == "audi" | manufacturer == "toyota") %>%
  group_by(manufacturer) %>%
  summarise(mean(cty))
  
# 4-3
mpg %>% 
  filter(manufacturer == "chevrolet" | manufacturer == "ford" | manufacturer == "honda") %>%
  group_by(manufacturer) %>%
  summarise(mean(hwy))


# 문제 5
# 5-1
(mpg %>% select(class, cty) -> mpg2)

# 5-2
mpg2 %>% 
  filter(class == "suv" | class == "compact") %>% 
  group_by(class) %>% 
  summarise(mean(cty))


# 문제 6
mpg %>% 
  filter(manufacturer == "audi") %>%
  arrange(desc(hwy)) %>%
  head(5)















