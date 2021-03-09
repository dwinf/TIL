# 텍스트 마이닝

> 텍스트 마이닝은 당어의 출현 빈도, 단어간 관계성 등을 파악하여 유의미한 정보를 추출하는 것
>
> 데이터 마이닝의 일부로 자연어 처리 기술을 기반으로 함



## 1. 텍스트 마이닝 개요

#### 텍스트마이닝(Text mining)은 데이터마이닝의 일부

- 데이터마이닝이 **수치데이터와 범주형데이터**를 집중적으로 보는 반면
- 텍스트마이닝은 **텍스트 데이터**를 중점적으로 다룬다. 

#### 텍스트마이닝을 잘 하기 위해서는 

- **형태소분석기**나 **구문분석기**와 같은 **자연어처리 도구를 잘 사용할 수 있어야** 하며 

- 그 외에 다루는 언어에 대해서도 잘 알고 있어야 한다. 

#### 텍스트 마이닝

- 많은 양의 비정형 데이터에 접근하고 활용하는데 사용
- 가치나 인사이트를 찾을 수 있을 뿐 아니라 
- 비정형 데이터를 관리함으로써 실질적인 ROI(Return On Investment)를 이끌어 낼 수도 있다. 

#### 텍스트 마이닝 활용

- 소셜 미디어는 시장 및 고객 정보를 파악하는데 있어서 점차 그 중요성이 높음
- 많은 양의 비정형 데이터를 분석하여 해당 브랜드나 제품에 대한 다양한 의견과 감성반응을 살펴볼 수 있다. 
- 문서들을 자동으로 분류할 수 있고, 문서나 단어들간의 연관성을 분석
- 텍스트에 담겨있는 감성(평가, 성향 등)을 예측할 수 있고 시간의 흐름에 따른 이슈들의 변환과정을 추적



## 2. 자연어 처리

> 자연어란 우리가 일상생활에서 사용하는 말, 언어

- 자연어 처리 기술을 바탕으로 사람들이 작성한 텍스트를 컴퓨터가 분석하여 중요한 단어나 문장들을 추출할 수 있음
  - 매력적인 뉴스 기사의 헤드라인 작성
  - 제품에 대한 고객 반응 분석
  - 우리 브랜드에 대한 고객 생각 등을 알아냄

- 한국어는 어순이나 조사 등을 영어처럼 명확하게 끊어지지 않는 부분이 있다. 

- ‘한국어’라는 단어를 분석하면 ‘한국어는’, ‘한국어의’, ‘한국어를’ 등의 표현은 모두 ‘한국어’라는 핵심 단어를 가지고 있다. 
  - 하지만 기계적으로 이 표현들을 각각 다르게 인식할 수도 있으므로 한국어로 된 텍스트를 쪼개는 과정이 영어보다 더 많이 필요
  - 현재 나와 있는 기술만으로도 텍스트 마이닝을 통하여 충분히 유의미한 인사이트를 도출

- **자연어 처리는 인간이 사용하는 언어를 컴퓨터가 사용할 수 있게 처리하는 것**을 말한다. 
  - 애플의 시리(Siri)와 같은 음성인식이나 광학문자판독을 통해서 책에서 글자를 읽어 들이거나 
  - 사람이 작성한 글을 로봇을 이용해서 크롤링 하고 해석하여 어떤 것이 핵심어이고 어떤 것이 주제어인가 등을 알아내기도 하며 
  - 글쓴이의 감정이나 상태 등을 알아내기도 한다.

#### 자연어 처리

- 자언어 처리는 **형태소분석기**, **구문분석기**와 같은 사람이 작성한 글이나 대화를 컴퓨터를 통해 해석할 수 있게 하는 소프트웨어를 개발하거나 연구하고 

- 그런 것들을 이용 해서 실제로 작업하는 것

#### 형태소분석기 

- 형태소를 구분하고 무엇인지 알려주는 것이다. 
- 형태소 분석으로 어절들의 품사를 파악한 후 명사,동사, 형용사 등 의미를 지닌 품사의 단어를 추출해 각 단어가 얼마나 많이 등장했는지 확인

#### 구문분석기 

- 주어, 목적어, 서술어와 같은 형태로 품사보다는 단위가 더 높은 논리적 레벨까지를 처리해주는 것이다. 
- 잘 알려진 형태소분석기 종류 
  - Hannanum: KAIST의 한나눔 형태소 분석기와 NLP_HUB 구문분석기 
  - KKMA: 서울대의 꼬꼬마 형태소/구문 분석기 v2..1 
  - KOMORAN: Junsoo Shin님의 코모란 v3.3.3 
  - Twitter: OpenKoreanText의 오픈 소스 한국어 처리기 v2..2..0 (구 Twitter 한국어 분석기)1-1 
  - Eunjeon: 은전한닢 프로젝트의 SEunjeon(S은전) 
  - Arirang: 이수명님의 Arirang Morpheme Analyzer 1-2. 
  - RHINO: 최석재님의 RHINO v2..5.4



### 한국어 형태소 분석 패키지

> KoNLP(Korean Natural Language Processing)

#### KoNLP 패키지 설치

```R
install.packages("Sejong")
install.packages("hash")
install.packages("tau")
install.packages("devtools")

# github 버전 설치
install.packages("remotes")
# 64bit 에서만 동작합니다.
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

library(KoNLP)
useSejongDic()
```

#### 한나눔에서 사용하는 카이스트 품사 태그 셋

- S : 기호
- F : 외국어
- N : 체언
  - NC : 보통명사
  - NQ : 고유명사
  - NB : 의존명사
  - NP : 대명사
  - NN : 수사
- P : 용언
  - PV : 동사
  - PA : 형용사
  - PX : 보조용언
- M : 수식언
  - MM : 관형사
  - MA : 부사
- I : 독립언
  - II : 감탄사
- J : 관계언
  - JC : 격조사
  - JX : 보조사
  - JP : 서술격조사
- E : 어미
  - EP
  - EC
  - ET
  - EF
- X : 접사



## 3. 텍스트 전처리와 tm 패키지

### 정규표현식 활용

```R
word <- "JAVA javascript 가나다 12.3 %^&*"
gsub("A", "", word)
gsub("a", "", word)
gsub("[Aa]", "", word)
gsub("[가-힣]", "", word)
gsub("[^가-힣]", "", word)
gsub("[&^%*]", "", word)
gsub("[[:punct:]]", "", word)
gsub("[[:alnum:]]", "", word)
gsub("[12.34567890]", "", word)
gsub("[[:digit:]]", "", word)
gsub("[^[:alnum:]]", "", word)
gsub("[[:space:]]", "", word)
gsub("[[:space:][:punct:]]", "", word)
```

### stringr 패키지 활용

> 문자열 처리 패키지

```R
# 패키지 설치
install.packages("stringr")
library(stringr
```

- Detect Matches
  - `str_detect(string, pattern)`
    - 해당 문자열에 pattern이 있는지 확인
    - bool 형식 반환
  - `str_which(string, pattern)`
    - 해당 문자열에서 pattern의 위치 인덱스를 반환
  - `str_count(string, pattern)`
    - 해당 문자열에서 pattern의 갯수 반환
  - `str_locate(string, pattern)`
  - `str_locate_all.str_locate(string, pattern)`
- Subset Strings
  - `str_sub(str, start=1L, end=-1L)`
  - `str_subset(string, pattern)`
  - `str_extract(string, pattern)`
  - `str_match(string, pattern)`
- Manage Lengths
  - `str_length(string)`
  - `str_pad(string, width, side=c("left", "right", "both"), pad="")`
  - `str_trunc(string, width, side=c("right", "left", "center"), ellipsis="...")`
  - `str_trim(string, side=c("both", "left", "right"))`
- Mutate Strings
  - `str_sub()`
  - `str_replace(string, pattern, replacement)`
  - `str_replace_all(string, pattern, replacement)`
  - `str_to_lower(string, locale="en")`
  - `str_to_upper(string, locale="en")`
  - `str_to_title(string, locale="en")`
- Join and Split
- Order Strings
  - `str_order(x, decreasing=F, na_last=T, locale="en", numeric=F, ...)`
  - `str_sort(x, decreasing=F, na_last=T, locale="en", numeric=F, ...)`
- Helpers(잘 사용되지 않음)



## 3. 텍스트 전처리와 tm 패키지

> tm 패키지 : text mining 패키지

- 텍스트 마이닝에 특화된 패키지
- `tm_map()` : 텍스트 전처리를 효율적으로 함
- bow(bag of word, 말뭉치)



```R
tm_map(
	x,   # 코퍼스
	FUN  # 변환에 사용할 함수
)                        
```

-  `corp2. <- tm_map(corp1,stripWhitespace)` 
  - 여러 개의 공백을 하나의 공백으로 변환한다.
- `corp2. <- tm_map(corp2.,removeNumbers)` 
  - 숫자를 제거한다.
- `corp2. <- tm_map(myCorpus, content_transformer(tolower))` 
  - 영문 대문자를 소문자로 변환한다.
- `corp2. <- tm_map(corp2.,removePunctuation)` 
  - 마침표,콤마,세미콜론,콜론 등 문자 제거한다.
- `corp2. <- tm_map(corp2.,PlainTextDocument)`
- `stopword2. <- c(stopwords('en'),"and","but")` 
  - 기본 불용어 외에 불용어로 쓸 단어 추가(한국어는 안됨)
- `corp2. <- tm_map(corp2.,removeWords,stopword2.)` 
  - 불용어 제거하기 (전치사 , 관사 등)                   



### 코퍼스란

> 코퍼스(corpus; 말뭉치): 언어학에서 구조를 이루고 있는 텍스트 집합
>
> 통계 분석 및 가설 검증, 언어 규칙의 검사 등에 사용된다. 
>
> 텍스트 마이닝 패키지인 tm에서 문서를 관리하는 기본구조를 Corpus라 부르며, 이는 텍스트 문서들의 집합을 의미한다
>
> 보통 벡터를 가지고 만듬(vcorpus)



#### [ tm 패키지를 이용한 텍스트 마이닝 예제 1 ]

```R
lunch <- c("커피 파스타 치킨 샐러드 아이스크림",
                "커피 우동 소고기김밥 귤",
                "참치김밥 커피 오뎅",
                "샐러드 피자 파스타 콜라",
                "티라무슈 햄버거 콜라",
                "파스타 샐러드 커피"
               )

cps <- VCorpus(VectorSource(lunch))
tdm <- TermDocumentMatrix(cps) # 기본적으로 텀의 길이가 3자 이상인 것만 사용
tdm
(m <- as.matrix(tdm))

cps <- VCorpus(VectorSource(lunch))
tdm <- TermDocumentMatrix(cps, control=list(wordLengths = c(1, Inf)))
tdm
(m <- as.matrix(tdm))
```



#### [ tm 패키지를 이용한 텍스트 마이닝 예제 2 ]

```R
library(tm)
A <- c('포도 바나나 딸기 맥주 비빔밥 여행 낚시 떡볶이 분홍색 듀크 귤')
B <- c('사과 와인 스테이크 배 포도 여행 등산 짜장면 냉면 삼겹살 파란색 듀크 귤 귤')
C <- c('백숙 바나나 맥주 여행 피자 콜라 햄버거 비빔밥 파란색 듀크 귤')
D <- c('귤 와인 스테이크 배 포도 햄버거 등산 갈비 냉면 삼겹살 녹색 듀크')
data <- c(A,B,C,D)
cps <- Corpus(VectorSource(data))
tdm <- TermDocumentMatrix(cps)
inspect(tdm)
m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing=T)
```

