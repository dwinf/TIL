####################
## 다중 회귀 분석 ##
####################
install.packages("car")
library(car)



# 엄마와 아빠 키로 아들의 키를 예측하는 다중선형회귀모델 생성 
height_father <- c(180, 172, 150, 180, 177, 160, 170, 165, 179, 159) # 아버지 키 
height_mohter <- c(160, 164, 166, 188, 160, 160, 171, 158, 169, 159) # 어머니 키
height_son <- c(180, 173, 163, 184, 165, 165, 175, 168, 179, 160) # 아들 키 
height <- data.frame(height_father, height_mohter, height_son)
head(height) 

model <-lm (height_son ~ height_father + height_mohter, data = height)
model 


# 결정계수와 수정된 결정계수
summary(model)

(coef_r <- coef(model))
coef_r[1]
coef_r[2]
coef_r[3]

# 잔차 
r <- residuals(model)
r[1:4]

# 예측 
predict.lm(model, newdata = data.frame(height_father = 170, height_mohter = 160))
predict.lm(model, newdata = data.frame(height_father = 170, height_mohter = 160), interval = "confidence")



fdata2 <- read.csv("data/factory2.csv")
fdata2.lm <- lm(robber~temp+pressure, data=fdata2)
summary(fdata2.lm)
-554.5267-0.1743 * 200 + 11.8449 * 59
predict(fdata2.lm, newdata=data.frame(temp=200, pressure=59) )
cor(fdata2)


fdata3 <- read.csv("data/factory3.csv")
fdata3.lm <- lm(Y~X1+X2+X3, data=fdata3)
summary(fdata3.lm)


2.409213+0.069788*20-0.024767*27+0.005864*60

predict(fdata3.lm, newdata=data.frame(X1=20, X2=27, X3=60))

cor(fdata3)



data(mtcars)
str(mtcars)
mtcars <- mtcars[c("mpg", "hp", "wt", "disp", "drat")]
summary(mtcars)
cor(mtcars)

scatterplotMatrix(mtcars, pch=19, col="royalblue", cex=1.2,
                  regLine=list(method=lm, lty=1, lwd=3, col="salmon"),
                  smooth=list(smoother=loessLine, spread=FALSE, 
                              lty.smooth=1, lwd.smooth=3, col.smooth="forestgreen"),
                  main="Car Performance")

mtcars.lm <- lm(mpg ~ hp + wt + disp + drat, data=mtcars)
summary(mtcars.lm)

mtcars.lm <- lm(mpg ~ ., data=mtcars)
summary(mtcars.lm)

#################################
# 종속변수에 유의미한 변수 찾기 #
#################################
# 다중 회귀분석에 사용할 변수 선택하기(backward, forward, both)

step(mtcars.lm, direction="backward")
step(mtcars.lm, direction="both")
start.lm <- lm(mpg~1, data=mtcars)
step(start.lm, scope=list(lower=start.lm, upper=mtcars.lm), direction="forward")


# 교안에 있는 변수 선택 소스
tadata <- read.csv("data/TAccident.csv")
View(tadata)
start.lm <- lm(Y~1, data=tadata)
full.lm <- lm(Y~., data=tadata)
step(start.lm, scope=list(lower=start.lm, upper=full.lm), direction="forward")
step(full.lm, data=tadata, direction="backward")
step(start.lm, scope=list(upper=full.lm), data=tadata, direction="both")


# 다중 회귀분석에서 조정된 결정계수가 향상되는 변수들의 조합을 시각화 해서 알려준다.
install.packages("leaps")
library(leaps)
library(RColorBrewer)
mtcars.regsubsets <- regsubsets(x=mpg ~ hp + wt + disp + drat, data=mtcars, nbest=4)


plot(mtcars.regsubsets, scale="adjr2", col=brewer.pal(9, "Pastel1"),
     main="All Subsets Regression")

summary(mtcars.regsubsets)
names(summary(mtcars.regsubsets))
summary(mtcars.regsubsets)$adjr2
which.max(summary(mtcars.regsubsets)$adjr2)
coef(mtcars.regsubsets, 9)

# 선택된 변수들을 사용한 회귀분석 비교
mtcars.lm1 <- lm(mpg ~ hp + wt, data=mtcars)
mtcars.lm2 <- lm(mpg ~ hp + wt + disp + drat, data=mtcars) # 모든 변수 사용
mtcars.lm3 <- lm(mpg ~ . - disp, data=mtcars) # disp 제외 모든 변수
AIC(mtcars.lm1, mtcars.lm2, mtcars.lm3)

summary(mtcars.lm1)
summary(mtcars.lm2)
summary(mtcars.lm3)

vif(mtcars.lm1)
vif(mtcars.lm2)
vif(mtcars.lm3)

# 독립 변수들의 단위가 다른 경우 
# 종속변수에 대한 독립변수(설명변수)들 각각의 예측력을 점검하려면 
# 변수값들을 표준화하여 회귀분석을 수행한다.

st_mtcars.lm <- lm(scale(mpg) ~ scale(hp) + scale(wt) + scale(disp) + scale(drat), 
                   data=mtcars)
summary(st_mtcars.lm) # scale함수는 표준화만 지원




multico = read.csv("data/Multico.csv")
str(multico)
head(multico)
multico.lm <- lm(Y~X1+X2+X3+X4, data=multico)
summary(multico.lm)

cor(multico[-1])

library(car)
vif(multico.lm)

multico.lm <- lm(Y~X1+X2+X3, data=multico)
summary(multico.lm)
vif(multico.lm)


multico.regsubsets <- regsubsets(x=Y ~ . - ID, data=multico, nbest=2)


plot(multico.regsubsets, scale="adjr2", col=brewer.pal(8, "Set3"),
     main="All Subsets Regression")

multico.lm <- lm(Y~X1+X3, data=multico)
summary(multico.lm)
multico.lm <- lm(Y~X1+X4, data=multico)
summary(multico.lm)



# 다중 회귀분석 모델 진단
mtcars.lm <- lm(mpg ~ hp + wt + disp + drat, data=mtcars)
old.par <- par(mfrow=c(2, 2))
plot(mtcars.lm)
old.par

mtcars.lm <- lm(mpg ~ hp + wt, data=mtcars)
old.par <- par(mfrow=c(2, 2))
plot(mtcars.lm)
old.par

# 변동계수 채크

v1 <- c( 3,5,6,8,9,11,15)
v2 <- v1*10

sd(v1) # 표준편차
sd(v2)

(v1.cv = sd(v1) / mean(v1))
(v2.cv = sd(v2) / mean(v2))


group1 <- c(86, 85, 92, 89, 83, 90, 88, 91, 79,83)
group2 <- c(0.88, 0.91, 0.94, 0.84, 0.97, 0.89, 0.99, 0.88, 0.89, 0.96)


sd(group1)
sd(group2)

sd(group1) / mean(group1)
sd(group2) / mean(group2)



normalize <- function(x, minV, maxV)
{
  return((x- minV) /(maxV-minV))
}
rV1 <- range(group1)
rV2 <- range(group2)
st_group1 <- sapply(group1, normalize, rV1[1], rV1[2])
st_group2 <- sapply(group2, normalize, rV2[1], rV2[2])

sd(st_group1)
sd(st_group2)


library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")



# 지도 시각화
install.packages("ggmap")
library(ggmap)
register_google(key='AIzaSyDy81EbO46BRSnX1DOgg_F84bhsdbku2z4')

lon <- 126.9221322
lat <- 37.5268831
cen <- c(lon,lat)
mk <- data.frame(lon=lon, lat=lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=1, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=5, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=10, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=15, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="satellite",zoom=16, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="terrain",zoom=8, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="terrain",zoom=12, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="hybrid",zoom=16, marker=mk)
Sys.sleep(1)
ggmap(map)+labs(title="테스트임", x="경도", y="위도")+
  theme(plot.title=element_text(family="maple", color="blue"))

map <- get_map(location=cen, maptype="toner",zoom=12, marker=mk, source="google")
ggmap(map)
map <- get_map(location=cen, maptype="watercolor",zoom=12, marker=mk, source="stamen")
ggmap(map)
map <- get_map(location=cen, maptype="terrain-background",zoom=12, marker=mk, source="stamen")
ggmap(map)
map <- get_map(location=cen, maptype="toner-lite",zoom=12, marker=mk, source="stamen")
ggmap(map)
map <- get_map(location=cen, maptype="terrain",zoom=12, marker=mk, source="stamen")
ggmap(map)



mk <- geocode("seoul", source = "google")
print(mk)
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=11, marker=mk)
ggmap(map)

mk <- geocode(enc2utf8("부산"), source = "google")
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=11, marker=mk)
ggmap(map)

multi_lonlat <- geocode(enc2utf8("강남구 삼성동 151-7"), source = "google")
mk <- multi_lonlat
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=16)

ggmap(map) + 
  geom_point(aes(x=mk$lon, y=mk$lat), alpha=0.4, size=5, color="pink") +
  geom_text(aes(x=mk$lon, y=mk$lat, label="우리가 공부하는 곳", 
                color="red", vjust=0, hjust=0, family="maple"))


# 제주도
names <- c("용두암","성산일출봉","정방폭포",
           "중문관광단지","한라산1100고지","차귀도")
addr <- c("제주시 용두암길 15",
          "서귀포시 성산읍 성산리",
          "서귀포시 동홍동 299-3",
          "서귀포시 중문동 2624-1",
          "서귀포시 색달동 산1-2",
          "제주시 한경면 고산리 125")
gc <- geocode(enc2utf8(addr))
gc
#save(gc, file="jeju.rda")
#load("jeju.rda")
df <- data.frame(name=names,
                 lon=gc$lon,
                 lat=gc$lat)
cen <- c(mean(df$lon),mean(df$lat)) # 중요
map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     zoom=10,
                     size=c(640,640),
                     marker=gc)
Sys.sleep(2)
ggmap(map) 

ggmap(map) + geom_text(data=df,               
                       aes(x=lon,y=lat,colour="green",
                           family="maple",vjust=1.2,               
                           size=3,label=name)) + guides(color=F)




# 공공 DB 활용 

library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "360"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc) ; top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList[1]")); df
busRouteId <- df$busRouteId
busRouteId
url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc); top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList")); df
# 구글 맵에 버스 위치 출력
df$gpsX <- as.numeric(as.character(df$gpsX))
df$gpsY <- as.numeric(as.character(df$gpsY))
gc <- data.frame(lon=df$gpsX, lat=df$gpsY);gc
cen <- c(mean(gc$lon), mean(gc$lat))
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12, marker=gc)
Sys.sleep(2)
ggmap(map)


library(dplyr)
library(ggmap)
library(ggplot2)

geocode('Seoul', source = 'google')
geocode('Seoul', source = 'google', output = 'latlona')
geocode(enc2utf8('서울'), source = 'google')
geocode(enc2utf8('서울'), source = 'google', output = 'latlona')
geocode(enc2utf8('서울&language=ko'), source = 'google', output = 'latlona')

station_list = c('시청역', '을지로입구역', '을지로3가역', '을지로4가역', 
                 '동대문역사문화공원역', '신당역', '상왕십리역', '왕십리역', '한양대역', 
                 '뚝섬역', '성수역', '건대입구역', '구의역', '강변역', '잠실나루역', 
                 '잠실역', '신천역', '종합운동장역', '삼성역', '선릉역', '역삼역', 
                 '강남역', '2호선 교대역', '서초역', '방배역', '사당역', '낙성대역', 
                 '서울대입구역', '봉천역', '신림역', '신대방역', '구로디지털단지역', 
                 '대림역', '신도림역', '문래역', '영등포구청역', '당산역', '합정역', 
                 '홍대입구역', '신촌역', '이대역', '아현역', '충정로역')
station_df = data.frame(station_list)
station_df$station_list = enc2utf8(station_df$station_list)
# 다음 행은 한번만 수행시켜 주셔영(^^)- 과금 ㅎㅎㅎ
station_lonlat = mutate_geocode(station_df, station_list, source = 'google')
station_lonlat
save(station_lonlat, file="station_lonlat.rda") # 두 번째 테스트부터는 저장했다가 읽자구요
#load("station_lonlat.rda")

seoul_lonlat = unlist(geocode('seoul', source = 'google'))
?qmap

qmap('seoul', zoom = 11)
qmap(seoul_lonlat, zoom = 11, source = 'stamen', maptype = 'toner')
seoul_map <- qmap('Seoul', zoom = 11, source = 'stamen', maptype = 'toner')
seoul_map + geom_point(data = station_lonlat, aes(x = lon, y = lat), colour = 'green',
                       size = 4)



# 지도 응용
df <- read.csv("data/전국전기차충전소표준데이터.csv")       
str(df) 
head(df); View(df)
df_add <- df[,c(13, 17, 18)]
names(df_add) <- c("address", "lat", "lon")
View(df_add)

map_korea <- get_map(location="southKorea", zoom=7, maptype="roadmap") 
ggmap(map_korea)+geom_point(data=df_add, aes(x=lon, y=lat), alpha=0.5, size=2, color="red")


map_seoul <- get_map(location="seoul", zoom=11, maptype="roadmap")       
ggmap(map_seoul)+geom_point(data=df_add, aes(x=lon, y=lat), alpha=0.5, size=5, color="blue")



#leaflet 그리기

install.packages("leaflet")
library(leaflet)
library(dplyr)
library(ggmap)

seoul_lonlat<-geocode("seoul")

# 지도 배경 그리기 
leaflet()

# 지도 배경에 타일깔기
leaflet() %>% addTiles() 

# 지도 배경에 센터 설정하기
map0 <- leaflet() %>% setView(lng = seoul_lonlat$lon, lat = seoul_lonlat$lat, zoom = 16)  
map0

# 지도 배경에 센터 설정하고 타일깔기
map1 <- map0 %>% addTiles() 
map1

mk <- multi_lonlat
lon <- mk$lon
lat <- mk$lat
msg <- '<strong><a href="http://www.multicampus.co.kr" style="text-decoration:none" >멀티캠퍼스</a></strong><hr>우리가 공부하는 곳 ㅎㅎ'
map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 16) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 18) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 5) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 1) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2


content1 <- paste(sep = '<br/>',"<b><a href='https://www.seoul.go.kr/main/index.jsp'>서울시청</a></b>",'아름다운 서울','코로나 이겨냅시다!!')
map3<-leaflet() %>% addTiles() %>%  addPopups(126.97797, 37.56654, content1)
map3

content2 <- paste(sep = '<br/>',"<b><a href='http://www.snmb.mil.kr/mbshome/mbs/snmb/'>국립서울현충원</a></b>",'1955년에 개장', '2013년 ‘서울 미래유산’으로 등재')
map3<-leaflet() %>% addTiles() %>%  addPopups(c(126.97797, 126.97797),  c(37.56654, 37.50124) , c(content1, content2), options = popupOptions(closeButton = FALSE) )
map3

wifi_data = read.csv('data/wifi_data.csv', encoding = 'utf-8')
#View(wifi_data)
leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], 
          lat = seoul_lonlat[2], 
          zoom = 11) %>% 
  addTiles() %>% 
  addCircles(lng = ~lon, lat = ~lat)


leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat = ~lat)


leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  addCircles(lng = ~lon, lat = ~lat)

leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat = ~lat, popup = ~div)

?colorFactor
telecom_color = colorFactor('Set1', wifi_data$div)
telecom_color(wifi_data$div)
str(telecom_color)
mode(telecom_color)
leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat=~lat, popup = ~div, color = ~telecom_color(div)) -> mymap

leaflet() %>%
  #addTiles() %>%
  setView( lng=lon, lat=lat, zoom = 16) %>%
  addProviderTiles("Esri.WorldImagery")


leaflet() %>%
  #addTiles() %>%
  setView( lng=lon, lat=lat, zoom = 6) %>%
  addProviderTiles("NASAGIBS.ViirsEarthAtNight2012")


install.packages("htmlwidgets")
library(htmlwidgets)
saveWidget(mymap, file="output/mymap.html")


