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



### 3. 벡터의 주요 함수

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



---



## 행렬(Matrix)

### 1. 생성 함수

> matrix(data=벡터, nrow=행의갯수, ncol=열의갯수, [byrow=TRUE])
>
> rbind(), cbind()

- byrow=TRUE일 경우 행렬의 행부터 원소를 채움
  - 기본적으로는 열부터 채움

- `rbind()` : 행을 기준으로 행렬 생성
- `cbind()` : 열을 기준으로 행렬 생성

```R
x1 <-matrix(1:8, nrow = 2) # 행 또는 열의 수가 주어지면 나머지는 생략 가능
     [,1] [,2] [,3] [,4]
[1,]    1    3    5    7
[2,]    2    4    6    8

mat1 <-matrix(letters[1:10]) # 행이나 열이 주어지지 않으면 1열로 생성

mat1 <-matrix(chars, nrow=2) # 5행 2열
     [,1] [,2] [,3] [,4] [,5]
[1,] "a"  "c"  "e"  "g"  "i" 
[2,] "b"  "d"  "f"  "h"  "j" 

mat1 <-matrix(chars, nrow=5, byrow=T) # 원소를 행부터 채움
     [,1] [,2] [,3] [,4] [,5]
[1,] "a"  "b"  "c"  "d"  "e" 
[2,] "f"  "g"  "h"  "i"  "j" 

vec1 <- c(1,2,3);vec2 <- c(4,5,6);vec3 <- c(7,8,9)
mat1 <- rbind(vec1,vec2,vec3); mat1	# 행 이름에 주목
     [,1] [,2] [,3]
vec1    1    2    3
vec2    4    5    6
vec3    7    8    9

mat2 <- cbind(vec1,vec2,vec3); mat2	# 열 이름에 주목
     vec1 vec2 vec3
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9
```



### 2. 행렬의 주요 함수

#### (1) 행, 열 개수

- `dim(x1)` : 몇차원 행렬인지 체크
- `nrow(x1)` : 행의 개수
- `ncol(x1)` : 열의 개수

#### (2) 행, 열 이름

- `rownames(x2)` : 행에 이름 부여
- `colnames(x1)` : 열에 이름 부여

#### (3) 행렬의 통계 관련 연산

- `rowSums(m)` : 행 원소의 합
- `colSums(m)` : 열 원소의 합
- `rowMeans(m)` : 행의 평균
- `colMeans(m)` : 열의 평균
- `sum(m)` : 행렬의 모든 원소의 합
- `mean(m)` : 행렬의 모든 원소의 평균
-  `min(m), max(m)` : 행렬의 원소 중 최소값, 최대값

#### (4) apply(m, 1 or 2, 함수)

> 행렬에 함수를 적용하여 결과를 리턴

```R
apply(x2, 1, max) # 1일 경우 행 단위 연산
apply(x2, 1, min)
apply(x2, 1, mean)
apply(x2, 1, sum) # == rowSums(x2)

apply(x2, 2, max) # 2일 경우 열 단위 연산
apply(x2, 2, min)
apply(x2, 2, mean)
apply(x2, 2, sum) # colSums(x2)
```



## 배열(Array)

```R
a1 <- array(1:30, dim=c(2,3,5)) # dim 매개변수 필수
```

- 인덱스를 통한 접근 가능(벡터 참고)



## 팩터(Factor)

> 범주형 데이터셋

- plot() 함수 실행 시 막대그래프로 표현

### 1. 생성 함수

- `factor(벡터)`
- `factor(벡터[, levels=레벨벡터])`
- `factor(벡터[, levels=레벨벡터], ordered=TRUE)`

```R
score <- c(1,3,2,4,2,1,3,5,1,3,3,3)

f_score <- factor(score) # 팩터 생성
f_score1 <- as.factor(score)
class(f_score)	# "factor"
f_score
 [1] 1 3 2 4 2 1 3 5 1 3 3 3
Levels: 1 2 3 4 5
summary(f_score) # 범주 데이터의 개수
1 2 3 4 5 
3 2 5 1 1

```

### 2. 레벨 정보 추출

- `levels(팩터변수)`

```R
levels(f_score) # 1~5까지의 데이터
"1" "2" "3" "4" "5"
```

### 3. 그 외 활용

```R
btype <- factor(
  c("A", "O", "AB", "B", "O", "A", "O"), 
  levels=c("A", "B", "O"))	# 팩터의 레벨을 지정하여 생성
btype
summary(btype)
levels(btype)

gender <- factor(c(1,2,1,1,1,2,1,2), 
                 levels=c(1,2), 
                 labels=c("남성", "여성"))
gender
summary(gender)
levels(gender)
```

- 레벨에 없는 값은 NA로 처리
- labels를 통해 labels에 따른 이름으로 사용 가능



## 데이터 프레임(data.frame)

### 1. 생성 함수

- **data.frame**(백터들..)
- data.frame(열이름=벡터,…) 
- data.frame(벡터들…) [**,stringsAsFactors=FALSE**])  # 4.0 이전에는 T가 기본 4.0 부터는 F 가 기본 
- as.data.frame(벡터 또는 행렬 등)

```R
english <- c(90, 80, 60, 70)
math <- c(50, 60, 100, 20)
classnum <- c(1,1,2,2)
df_midterm <- data.frame(
  english, math, classnum)
  english math classnum
1      90   50        1
2      80   60        1
3      60  100        2
4      70   20        2

df_midterm2 <- data.frame(
  c(90, 80, 60, 70), 
  c(50, 60, 100, 20), 
  c(1,1,2,2))
  c.90..80..60..70. c.50..60..100..20. c.1..1..2..2.  #벡터에 이름을 주는 방식을 이용하자
1                90                 50             1
2                80                 60             1
3                60                100             2
4                70                 20             2

df_midterm2 <- data.frame(
  영어=c(90, 80, 60, 70), 
  수학=c(50, 60, 100, 20), 
  클래스=c(1,1,2,2))
  영어 수학 클래스
1   90   50      1
2   80   60      1
3   60  100      2
4   70   20      2

df <- data.frame(var1=c(4,3,8), 
                 var2=c(2,6)) # 오류. 행과 열의 수가 같아야 함
df <- data.frame(var1=c(4,3,8), 
                 var2=c(2,6,1))
```



### 2. 변환 함수

-  `rbind(df, 백터)` : 행을 추가로 결합
- `cbind(df, 벡터)` : 주로 사용됨. 열을 추가로 결합

```R
stat <- c(76, 73, 95, 82, 35)
df4 <- cbind(df4, stat)
```



### 3. 구조 확인

- `str(df)` : 데이터 프레임의 구조를 파악(변수의 수, 데이터의 수 등)
- `dim(df)` : 행과 열의 개수만 파악

```R
str(df)
'data.frame':	3 obs. of  2 variables:
 $ var1    : num  4 3 8
 $ var2    : num  2 6 1
```



### 4. 인덱싱

- `[행의인덱싱, 열의인덱싱]` 

- `[열의인덱싱]` : 열 단위 처리가 일반적이므로 컬럼이름 혹은 숫자만 작성할 경우 열의 인덱싱으로 간주

- `df$컬럼이름` : 데이터프레임의 컬럼에 접근

- `[[열인덱싱]]` : 리스트에서 주로 사용

- #### subset(df, select=컬럼명들, subset=(조건))

  - 조건을 통해 원하는 데이터 추출

```R
emp$ename
emp[,2]
emp[,"ename"]
# 데이터프레임 구조를 유지하여 출력
emp[,2, drop=FALSE]
emp[,"ename",drop=F] 
emp[2]
emp["ename"] 

# emp에서 직원이름, 잡, 샐러리
emp[,c(2,3,6)] # 자동으로 데이터프레임 구조로 출력
emp[,c("ename","job","sal")]
subset(emp,select = c(ename, job, sal))
# emp에서 1,2,3 행 들만
emp[1:3,]
emp[c(1,2,3),]

# ename이 "KING"인 직원의 모든 정보
emp[9,] 
emp$ename=="KING"
emp[c(F,F,F,F,F,F,F,F,T,F,F,F,F,F,F,F,F,F,F,F),]
emp[emp$ename=="KING",]
subset(emp,subset=emp$ename=="KING")
subset(emp,emp$ename=="KING") 
      
# 커미션이 정해지지 않은(NA) 직원들의 모든 정보 출력
emp[is.na(emp$comm),]
# 커미션을 받는 직원들의 모든 정보 출력
emp[!is.na(emp$comm),] # !는 논리부정연산자
subset(emp,!is.na(emp$comm)) 
# select ename,sal from emp where sal>=2000
subset(emp, emp$sal>= 2000, 
       c("ename","sal"))
subset(emp, select=c("ename","sal"), 
       subset= emp$sal>= 2000)
emp[emp$sal>=2000,c("ename","sal")]

# select ename,sal from emp where sal between 2000 and 3000
subset(emp, sal>=2000 & sal<=3000, c("ename","sal"))
emp[emp$sal>=2000 & emp$sal <=3000, c("ename","sal")]
```



### 5. ifelse

> ifelse(조건, 참일 경우, 거짓일 경우)

```R
df4$grade <- ifelse(df4$score >= 150, 'A', 
                    ifelse(df4$score >=100, 'B', 
                           ifelse(df4$score >= 70, 'C', 'D')))
```



### 6. 기타 함수

- `data()` : 내장 데이터셋 확인
- `iris` : 내장 데이터셋 예시(iris라는 꽃의 데이터)
- `head(iris)` : 데이터를 앞에서 부터 6개 확인
- `tail(iris)` : 데이터를 뒤에서 부터 6개 확인
  - `tail(iris, 10)` 보일 개수 지정 가능(기본 6)
- `View(iris)` : 엑셀처럼 보이게 함
- `str(iris)` : structure의 약어. 구조를 보여줌 
- `summary(iris)` : 데이터 프레임의 통계정보