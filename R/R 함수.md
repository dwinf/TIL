# R 함수

## R 공통

### 1. 타입체크 함수

| is.character()            | is.logical()                                | is.numeric()                  | is.double() | is.integer    |
| ------------------------- | ------------------------------------------- | ----------------------------- | ----------- | ------------- |
| 문자형                    | 논리형                                      | 수치형                        | 실수형      | 정수형        |
| is.null()                 | is.na()                                     | is.nan()                      | is.finite() | is.infinite() |
| 데이터셋이 <br />비어있음 | 내부에 존재하지<br /> 않는 값<br />(결측치) | 숫자가 아님<br />Not a number | 유한수      | 무한수        |



### 2. 형변환 함수

| as.character() | as.complex() - 복소수 | as.numeric() |
| -------------- | --------------------- | ------------ |
| as.double()    | as.integer()          | as.logical() |



### 3. 자료형/구조 확인 함수

- `class(x)`, `str(x)`, `mode(x)`, `typeof(x)`



## 벡터

### 1.  생성 함수

- `c()`
  - 일반적인 생성함수
- `seq()`
  - 일정한 규칙을 가지는 벡터
- `rep()`
  - 반복되는 구조의 벡터
- `:`
  - 지정된 숫자 범위만큼의 벡터

```R
v1 <- c(4, 1, 8, 6, 10)	# 4 1 8 6 10	c()함수에는 아규먼트를 원하는 만큼 전달 가능
v1[0]	# numeric(0)
v1[6]	# NA
v2 <- seq(1, 9, 2) 	# 1 3 5 7 9 == sep(1,10,by=2)
v3 <- rep(1, 5)		# 1 1 1 1 1
v4 <- rep(1:3, 3) 	# 1 2 3 1 2 3 1 2 3 == rep(1:3, times=3)	
v5 <- rep(1:4, each=2)	# 1 1 2 2 3 3 4 4
v6 <- 1:10	# 1 2 3 4 5 6 7 8 9 10
v7 <- 10:1	# 10 9 8 7 6 5 4 3 2 1
```



### 2. 상수 벡터

```R
LETTERS	# A B C D E ... X Y Z
letters	# a b c d e ... x y z
month.name	# "January"   "February"  "March" ... "December"
month.abb	# "Jan" "Feb" "Mar" ... "Dec"
pi	# 3.141593
```



### 3. 기타 주요 함수

#### (1) length()

길이를 리턴

```R
v3 <- c('100', 200, T, F);length(v3)	# 4
```

#### (2) names()

벡터의 요소에 이름을 부여. 이름을 통한 추출이 가능해진다.
텍스트 마이닝에 주소 사용

```R
v8 <- seq(1, 10, 3)	# 1 4 7 10
names(v8) <- LETTERS[1:length(v8)]	# A B C D
```

#### (3) sort()

원소를 정렬시킴

```R
sort(x) # 오름차순 정렬
sort(x, decreasing = TRUE) # 내림차순 정렬
sort(x, decreasing = T) # 내림차순 정렬
```

#### (4) rev()

원소를 역순으로 출력

```R
rev(sort(x))	# 내림차순 정렬
```

#### (5) order()

원소의 값을 비교하여 작은 값부터 인덱스값으로 리턴

```R
x <- c(10,2,7,4,15)
order(x)	# 2 4 1 5 3
```

#### (6) range()

최소값과 최대값 출력

```R
range(x)	# 2 15
```

#### (7) 최소, 최대 평균 등

| min()  | max()  | mean() | sum() | summary()   |
| ------ | ------ | ------ | ----- | ----------- |
| 최소값 | 최대값 | 평균   | 합계  | 기술 통계량 |

#### (8) which()

해당하는 인덱스를 추출

```R
rainfall <- c(21.6, 23.6, 45.8, 77.0, 
              102.2, 133.3,327.9, 348.0, 
              137.6, 49.3, 53.0, 24.9)
```

- `which(조건)`

  - 조건에 해당하는 인덱스 추출

  - ```R
    which(rainfall > 100)	# 5 6 7 8 9
    month.name[which(rainfall > 100)]	# "May" "June" "July" "August" "September"
    ```

- `which.max()`
  - 벡터의 최대값의 인덱스 리턴
- `which.min()`
  - 벡터의 최소값의 인덱스 리턴

#### (9) sample()

난수발생

```R
sample(1:20)	# 1~20까지 무작위로 출력
sample(1:20, 6)	# 1~20 중 6개 무작위 출력
sample(1:10, 7, replace=T) # 중복 허용
```

#### (10) paste()

벡터 결합 함수

```R
paste("I'm","Duli","!!")	# 기본적으로 구분자 = ' '(공백)
paste("I'm","Duli","!!", sep="")	# 구분자 지정

fruit <- c("Apple", "Banana", "Strawberry")
food <- c("Pie","Juice", "Cake")
paste(fruit, food)

paste(fruit, food, sep=":::")	# "Apple:::Pie" "Banana:::Juice" "Strawberry:::Cake"
paste(fruit, food, sep="", collapse="-")# "Apple Pie-Banana Juice-Strawberry Cake"
paste(fruit, food, sep="", collapse="")	#"ApplePieBananaJuiceStrawberryCake"
paste(fruit, food, collapse=",")	# "Apple Pie,Banana Juice,Strawberry Cake"
```

##### paste0()

공백없이 결합

```R
paste0("I'm","Duli","!!")	# "I'mDuli!!
paste("I'm","Duli","!!", sep="") # 동일한 기능
```