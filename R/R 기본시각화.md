# R 기본시각화

## 시각화 함수의 종류

> 고수준 함수를 이용해 그래프를 그리고 저수준함수를 사용해 그래프를 꾸며준다.

- 고수준 함수 – plot(), boxplot(), hist(), pie(), barplot() 
- 저수준 함수 – title(), lines(), axis(), legend(), points(), text()
- 칼라팔레트 함수 – rainbow(), cm.colors(), topo.colors(), terrian.colors(), heat.colors(), gray.colors()



- **pch** : 점의 종류(0~25)

  ![image](https://user-images.githubusercontent.com/73389275/111023350-e8d21e80-841b-11eb-8b44-61fab361df9a.png)

- **lty** : Line type, 선의 종류

![image](https://user-images.githubusercontent.com/73389275/111023372-0f905500-841c-11eb-8f93-e1f503c8d7ce.png)



## 2. 산포도

> 데이터가 얼마나 그리고 어떻게 퍼져있나를 나타내는 통계학 용어

- 점 그래프

```R
국어<- c(4,7,6,8,5,5,9,10,4,10)  
plot(국어)
```

- 점 + 선 그래프

```R
plot(국어, type="o", col="blue")
title(main="성적그래프", col.main="red", font.main=4)
```

```R
수학 <- c(7,4,7,3,8,10,4,10,5,7)
plot(국어, type="o", col="blue")
lines(수학, type="o", pch=16, lty=2, col="red")     
title(main="성적그래프", col.main="red", font.main=4)
```

![image](https://user-images.githubusercontent.com/73389275/111023744-246de800-841e-11eb-8aef-fad98bfb3189.png)

- 다양한 타입의 그래프

```R
par(mar=c(1,1,1,1), mfrow=c(4,2)) #  mar:여백, mfrow:화면에 나타낼 그래프의 수
plot(국어, type="p", col="blue", main="type = p", xaxt="n", yaxt="n")
plot(국어, type="l", col="blue", main="type = l", xaxt="n", yaxt="n")
plot(국어, type="b", col="blue", main="type = b", xaxt="n", yaxt="n")
plot(국어, type="c", col="blue", main="type = c", xaxt="n", yaxt="n")
plot(국어, type="o", col="blue", main="type = o", xaxt="n", yaxt="n")
plot(국어, type="h", col="blue", main="type = h", xaxt="n", yaxt="n")
plot(국어, type="s", col="blue", main="type = s", xaxt="n", yaxt="n")
plot(국어, type="S", col="blue", main="type = S", xaxt="n", yaxt="n")
```

![image](https://user-images.githubusercontent.com/73389275/111024612-08207a00-8423-11eb-8588-22b7f7d6aa0b.png)



- 그래프 작성

```R
par(mar=c(5,5,5,5), mfrow=c(1,1)) # 여백 5, 1개의 그래프
# 테두리와 x축y축의 이름이 없는 그래프
plot(국어, type="o", col="blue", ylim=c(0,12), axes=F, ann=F) # ann:축의 이름, axes:테두리

axis(1, at=1:10, lab=c("01","02","03","04", "05","06","07","08","09","10")) # x축 추가
axis(2, at=c(0,2,4,6,8,10))  # y축 추가

lines(수학, type="o", pch=16, lty=2, col="red") # 16번 점과 2번 선으로 그래프 생성
box()  # 그래프에 테두리 추가

title(main="성적그래프", col.main="red", font.main=4) # 그래프 타이틀 추가
title(xlab="학번", col.lab=rgb(0,1,0)) # x축의 이름
title(ylab="점수", col.lab=rgb(1,0,0)) # y축의 이름
legend(1, 10, c("국어","수학"), cex=0.8, col=c("blue","red"), pch=c(16,21), lty=c(1,2))
# 범례, cex:크기
```

- 그래프를 생성하여 파일로 저장

```R
(성적 <- read.table("data/성적.txt", header=TRUE))

plot(성적$학번, 성적$국어, main="성적그래프", xlab="학번", ylab="점수",  xlim=c(0, 11), ylim=c(0, 11)) 
ymax <- max(성적[3:5]) #성적 데이터 중에서 최대값을 찾는다(y 축의 크기 제한)
ymax
pcols<- c("red","blue","green")

# 그래프를 파일로 저장
png(filename="output/성적.png", height=400, width=700, bg="white") # 출력을 png파일로 설정
plot(성적$국어, type="o", col=pcols[1], ylim=c(0, ymax), axes=FALSE, ann=FALSE)
axis(1, at=1:10, lab=c("01","02","03","04","05","06","07","08","09","10"))
axis(2, at=c(0,2,4,6,8,10), lab=c(0,2,4,6,8,10))
box()
lines(성적$수학, type="o", pch=16, lty=2, col=pcols[2])
lines(성적$영어, type="o", pch=23, lty=3, col=pcols[3] )
title(main="성적그래프", col.main="red", font.main=4)
title(xlab="학번", col.lab=rgb(1,0,0))
title(ylab="점수", col.lab=rgb(0,0,1))
legend(1, ymax, names(성적)[c(3,4,5)], cex=0.8, col=pcols, pch=c(21,16,23), lty=c(1,2,3))
dev.off() # 저장 종료
```



## 3. 바 그래프

> barplot()

- `table()` 함수의 결과와 같은 범주형 데이터를 시각화

```R
barplot(데이터, # 그래프로 표현할 도수분포표
	main='막대그래프제목', 
    col.main='제목 색',
	col='막대의 색', # 막대별로 지정하거나 팔레트를 사용할 수 있음
	xlab='x축설명', 
	ylab='y축설명',
	horiz=T, # 그래프를 수평 방향으로 출력
	names=c("FA", "SP", "SU", "WI"), # x축의 그룹이름 지정
	las=2, # x축 그룹의 출력 방향
)
```

- `col`의 색 지정 방법
  - 색의 이름
    - "blue", "red", ...
  - 색상 코드(
    - "#ff0000". "#000000", ...
  - rgb 조합
    - rgb(0,0,0,255, maxColorValue=255)
- `las` (0,1,2,3) : 기본그래프는 수평, 수직만 지원
  - 0 : 축 방향(기본)
  - 1 : 수평 방향(축 방향과 무관)
  - 2 : 축 기준 수직
  - 3 : 수직 방향(축 방향과 무관)
