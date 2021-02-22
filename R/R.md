# R

> 2/22
>
> 마리아DB, 몽고DB를 이용한 데이터 처리
>
> 통계학자들이 만든 통계(데이터셋)처리 전문 언어

- 데이터 수집과 저장
- EDA(Exploratory Data Analysis)를 통한 시각화와 전처리
- 데이터 분석
- 분석 결과 시각화 표현

---

## 1. R &  RStudio 설치

> R 개발환경설치.docx 파일 참고

```R
100:200
200:100
v <- 100:200
v
print(v)
v[1]	# 1
# [1] 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117
# ...
# [91] 190 191 192 193 194 195 196 197 198 199 200
v[1]	# 1

v+1000
#  [1] 1100 1101 1102 1103 1104 1105 1106 1107 1108 1109 1110 1111 1112 1113
# ...
# [99] 1198 1199 1200

plot(v*10)
# 그래프를 그려줌(y축=v, x축=인덱스)
letters	#영소문자
LETTERS	#영대문자
```

- `<-` : R에서의 대입연산자(`=`도 사용 가능)
- [91] : 행의 첫번째 원소의 인덱스
  - R의 인덱스는 1부터 시작
- letters : 영문자를 출력(변수에 대입 가능)
  - s = letters



## 2. R 기본

#### R구문 학습 내용

- R로 다룰 수 있는 데이터 종료 : 자료형(data type)
- R로 다룰 수 있는 데이터셋 종류 : 벡터, 행렬, 배열, 데이터프레임, 리스트
- R에서 사용 가능한 연산자
- 제어문 : for, while, repeat, if, else if, else, break, next(continue 기능)
- 함수 정의와 활용
- 파일에 있는 데이터 읽기 : csv, xml, json, xlsx, txt

![image-20210222113042796](C:\Users\dwinf\AppData\Roaming\Typora\typora-user-images\image-20210222113042796.png)

### 1. R의 자료형

- 문자형(character) : 문자, 문자열 
- 수치형(numeric) : 정수(integer), 실수(double) 
- 복소수형(complex) : 실수+허수 
- 논리형(logical) : 참값과 거짓값



### 2. R의 리터럴

- 문자형(character)리터럴 :"가나다", '가나다', "", '', '123', "abc"  (인용부호로 묶이면 문자형)
- 수치형(numeric)리터럴 : 100, 3.14, 0 
- 논리형(logical)리터럴 : TRUE(T), FALSE(F) 
- NULL(데이터 셋이 비어있음을 의미), 
- NA(데이터 셋의 내부에 존재하지 않는 값(결측치)를 의미) : Not Available
-  NaN(not a number: 숫자가 아님), 
- Inf(무한대값)

#### 타입체크

- `is.character(x)` - 문자형 
- `is.logical(x)` - 논리형 
- `is.numeric(x)` - 수치형
  - `is.double(x)` - 실수형 
  - `is.integer(x)` - 정수형
- `is.null(x)` 
- `is.na(x)` 
- `is.nan(x)`
- `is.finite(x)` 
- `is.infinite(x)`

#### 자동형변환 룰

문자형 > 복소수형 > 수치형 > 논리형

#### 강제형변환 함수

- `as.character(x)` / `as.complex(x)` /  `as.numeric(x)`

- `as.double(x)` / `as.integer(x)` / `as.logical(x)`

#### 자료형/구조 확인

- `class(x)`, `str(x)`, `mode(x)`, `typeof(x)`



### 3. R의 데이터셋

 벡터(팩터), 행렬, 배열, 데이터프레임(정형데이터에 주로 이용), 리스트

![image-20210222131133618](C:\Users\dwinf\AppData\Roaming\Typora\typora-user-images\image-20210222131133618.png)

- 벡터(1차원), 행렬(2차원), 배열(1차원 이상) - 같은 타입의 데이터만 저장 가능
- 스칼라는 벡터로 인식되어 사실상 존재하지 않는다.
- 팩터 : 특별한 형태의 벡터



#### 데이터 프레임

- 열 단위로 서로 다른 타입의 데이터 저장 가능

#### 리스트

- 데이터 타입, 종류에 구애받지 않는다.

#### 벡터(vector)

- 가장 기초적인 데이터셋으로 1차원으로 사용
- 하나의 데이터값도 벡터
- **동일 타입의 데이터만으로 구성**
  - 문자형 저장 후 논리형을 저장하면 자동으로 문자형으로 형변환

```R
v2 <- c(100, 200, TRUE, FALSE); print(v2)	#100 200   1   0
v3 <- c('100', 200, T, F); print(v3)	#"100"   "200"   "TRUE"  "FALSE"
```

- 벡터 생성
  - `c()`, `seq()`, `rep()`, `:` 연산자

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

- 내장된 상수 벡터들

```R
LETTERS	# A B C D E ... X Y Z
letters	# a b c d e ... x y z
month.name	# "January"   "February"  "March" ... "December"
month.abb	# "Jan" "Feb" "Mar" ... "Dec"
pi	# 3.141593
```

- 주요 함수
  - length(길이 리턴), names(엘리먼트에 이름 부여), sort(오름차순 정렬), order() ...

- 인덱싱이 가능

```R
LETTERS[1]; LETTERS[c(3,4,5)]
LETTERS[3:5]; LETTERS[5:3]
LETTERS[-1]; LETTERS[c(-2,-4)]	# 음의 값 인덱스 제외
v3 <- v2[-5]	# 5번째 인덱스를 제외시킴
x[3];x[3] <- 20	# 3번 인덱스 출력, 20 대입
x[c(F,T,F,T,F)] # x[c(T,F)] --> x[c(T,F,T,F,T)]
# 논리형으로도 접근 가능. TRUE일 경우 출력 2,4번 인덱스의 값 출력
x[x > 5]	# 5보다 크면 TRUE
x[x > 5 & x < 15]	# 5보다 크고 15보다 작은 값 출력
# 논리연산을 사용하면 해당하는 값을 출력
```



#### 행렬(Matrix)

- 2차원 벡터
- **동일 타입의 데이터만 저장 가능**

- 행렬 생성방법 : matrix(data=벡터, nrow=행의갯수, ncol=열의갯수, [byrow=TRUE])
  - 행의 개수 혹은 열의 개수중 하나는 주지 않아도 된다. -> nxn 행렬 생성
  - 기본적으로 열부터 채워감
    - `byrow=TRUE`를 주면 행부터 채움
  - rbind(벡터들..), cbind(벡터들..)

- 행렬에 관한 다양한 함수들
  - dim(m)-행렬이 몇차원인지 체크, nrow(행렬), ncol(행렬) colnames(m), rownames(m), rowSums(m), colSums(m), rowMeans(m), colMeans(m), sum(m), mean(m), apply(m, 1 또는 2, 함수)