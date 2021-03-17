purifier <- read.csv("data/Purifier.csv")
str(purifier)

library(dplyr)

purifier %>% mutate(new = purifier-old_purifier) -> purifier

cor(purifier)
pur.lm <- lm (as_time ~ new + old_purifier, data = purifier) ;pur.lm
summary(pur.lm)

time_predicted <- predict(pur.lm, newdata=data.frame(new=300000-70000, old_purifier=70000))
time_predicted

round(time_predicted/160)

# CASE1
data <- read.csv("data/purifier.csv")
#View(data)

# 새로운 변수 new_purifier (10년 미만 정수기 대여수) 추가하기
data <- data %>% mutate(new_purifier = purifier - old_purifier)

# 상관계수, 회귀계수
cor(data)
pur.lm <- lm (as_time ~ new_purifier + old_purifier, data = data) ;pur.lm
summary(pur.lm)
# 수정된 결정계수가 0.9996으로 매우 높다.
# 두 독립변수 모두 유의확률이 0.05보다 매우 낮다.
# 10년 이상 노후된 정수기 대여수가 10년 미만 정수기 대여수보다 AS시간에 더 큰 영향을 미친다.

# 수식으로 계산
193.73664+0.08881*(300000-70000)+0.23977*70000

# 함수로 계산
time_predicted <- predict(pur.lm, newdata=data.frame(new=300000-70000, old_purifier=70000))
time_predicted

# 고용할 기사 수 구하기
ceiling(time_predicted/160)

# 결론:
# 총 대여수가 300,000대, 10년 이상 노후 정수기 대여수가 70,000대인 경우 약 37403시간의 AS시간이 예상되며 약 234명의 기사를 고용해야 한다.


# CASE2
# 데이터 불러오기
purifier = read.csv("data/purifier.csv")
purifier

# 데이터 전처리
purifier <- purifier %>%
  mutate(전월기준10년미만정수기대여수 = purifier - old_purifier) %>%
  rename(전월기준10년이상노후정수기대여수 = old_purifier, 당월기분AS소요시간 = as_time) %>% 
  select (당월기분AS소요시간, 전월기준10년미만정수기대여수, 전월기준10년이상노후정수기대여수)

# 확인
purifier

# 회귀식 도출
purifier.lm <- lm(당월기분AS소요시간~., data=purifier)

# 회귀식 확인
summary(purifier.lm )

purifier.lm

#예측
추후소요AS시간 <- predict(purifier.lm, newdata=data.frame(전월기준10년미만정수기대여수=230000, 전월기준10년이상노후정수기대여수=70000))
추후소요AS시간 

#결론
AS기사고용수 <- 추후소요AS시간 / (8*20) 
AS기사고용수


# CASE3
df <- read.csv('data/purifier.csv')

df <- df %>%
  mutate(new_purifier = purifier-old_purifier) 

model <-lm (as_time ~ new_purifier + old_purifier, data = df)
summary(model)
time.predict <- predict.lm(model, newdata = data.frame(old_purifier=70000, new_purifier=230000))

man.month <- 8*20
time.predict / man.month

print("234명 고용 필요")
