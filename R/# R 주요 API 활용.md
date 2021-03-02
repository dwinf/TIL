# R 주요 API 활용

install.packages() 

library() : 파이썬의 import와 유사

`::` : 패키지 안의 특정 함수를 사용하고자 할 때

data(iris) : 특정 데이터셋을 로드할 때



## 날짜, 시간관련 함수

 Sys.Date() : 현재 날짜

Sys.time() : 현재 날짜 및 시간

date() : 미국식 날찌 및 시간



**POSIXct, POSIXlt**



## 정규표현식

[A-Z] : ABCDEFGHIJKLMNOPQRSTUVWXYZ

[가-힣] : 모든 한글

[0-9] : 01234556789



010-1234-5678 : [0-9]{3}-[0-9]{4}-[0-9]{4}