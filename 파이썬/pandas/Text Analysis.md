# Text Analysis

## 1. 정규표현식

> R시간에도 했기 때문에 예시만 간략하게 소개

```python
import re # 파이썬에서는 re 패키지를 이용해 정규표현식 사용
word = "A JAVA   가나다 javascript Aa 가나다 AAaAaA123 %^&* 파이썬"
print(re.sub("^A", "", word)) # 첫 글자가 A(^가 첫글자를 의미)
print(re.sub("A$", "", word)) # 마지막 글자가 A($가 마지막 글자를 의미)
print(re.sub("Aa", "", word)) # Aa
print(re.sub("(Aa){2}", "", word)) # AaAa
print(re.sub("[Aa]", "", word)) # A 와 a
print(re.sub("[가-힣]", "", word)) # 모든 한글
print(re.sub("[^가-힣]", "", word)) # 한글을 제외한(^가 제외를 의미) 모든 문자
print(re.sub("[-힣]", "", word)) # 모든 한글
print(re.sub("[A-z]", "", word)) # 모든 영어(A-Za-z도 가능)
print(re.sub("\s", "", word)) # 모든 공백(대문자 S를 사용하면 공백를 제외한 모든 문자를 지정)
print(re.sub("\d", "", word)) # 모든 숫자(대문자 D를 사용하면 숫자를 제외한 모든 문자 지정)
print(re.sub("\w", "", word)) # 모든 문자(대문자 D를 사용하면 문자를 제외한 모든 문자(숫자, 특수문자, 공백 등) 지정)
new_word = re.sub("\s+", " ", new_word) # +는 지정한 문자의 마지막이 1번 더 반복될 경우를 지정
re.sub("a+", " ", new_word) # aa를 의미
re.sub("a.", " ", new_word) # a 다음에 임의의 문자 1개가 오는 경우를 의미
re.sub("파*", " ", new_word) # 파 다음에 0개 이상의 임의의 문자를 지정
```



## 2. KoNLPy

> 한국어 정보처리를 위한 파이썬 패키지
>
> 형태소 분석기(Hannanum, Kkma, Komoran, Okt) 사용 가능

### (1) 형태소 분석기 준비

```python
from konlpy.tag import Kkma # Kkma 외에 Hannanum, Komoran, Okt도 사용
from konlpy.utils import pprint
```

### (2) 객체 생성

```python
kkma = Kkma()
hannanum = Hannanum()
komoran = Komoran()
okt = Okt()
```

### (3) 형태소 분석

> KoNLPy 패키지를 안에서 다양한 분석기를 쓰기 때문에 명령어는 공통적으로 쓰임
>
> Komoran은 빈 줄이 있으면 에러 발생
>
> 분석기 별로 품사 분류가 조금씩 다름

#### 1. 문장 분할

```python
pprint(kkma.scentences('네, 안녕하세요. 반갑습니다.'))
# ['네, 안녕하세요.', '반갑습니다.']
```



#### 2. 명사 추출

> Okt가 다른 분석기에 비해 가장 정확하다고 느낌

```python
pprint(kkma.nouns('질문이나 건의사항은 깃헙 이슈 트래커에 남겨주세요.'))
# ['질문', '건의', '건의사항', '사항', '깃헙', '이슈', '트래커']
```



#### 3. 품사 분석

```python
pprint(kkma.pos('오류보고는 실행환경, 에러메세지와함께 설명을 최대한상세히!^^'))
# 결과
[('오류', 'NNG'),
 ('보고', 'NNG'),
 ('는', 'JX'),
 ('실행', 'NNG'),
 ('환경', 'NNG'),
 (',', 'SP'),
 ('에러', 'NNG'),
 ('메세지', 'NNG'),
 ('와', 'JKM'),
 ('함께', 'MAG'),
 ('설명', 'NNG'),
 ('을', 'JKO'),
 ('최대한', 'NNG'),
 ('상세히', 'MAG'),
 ('!', 'SF'),
 ('^^', 'EMO')]
```

- `형태소분석기.tagsets` : 분석기의 품사 분류를 볼 수 있음



#### 4. 형태소 추출

```python
pprint(hannanum.morphs('이것은 형태소 분석기 입니다 아버지가방에들어가신다'))
# ['이것', '은', '형태소', '분석기', '일', 'ㅂ니다', '아버지가방에들어가', '이', '시ㄴ다']
```





## 3. 워드 클라우드

### (1) 폰트 설정

```python
myfontpath = "data/THEdog.ttf"   #폰트파일의 위치
```

- 폰트를 주지 않으면 글자 대신 네모박스가 출력됨



### (2) 워드 클라우드 객체 생성

```python
from wordcloud import WordCloud    ## 워드 클라우드 모듈을 사용한다 
wc = WordCloud(                    ## 워드클라우드 객체를 만들때 한글로 출력되도록 객체를 만든다 
    font_path = myfontpath,
    #background_color='white',
    width = 200,
    height = 200
)
```

- **background** 옵션을 주지 않으면 검은 배경을 기본값으로 설정

### (3) 텍스트 입력

```python
text = "둘리 도우너 또치 마이콜 희동이 둘리 둘리 도우너 또치 토토로 둘리 올라프 토토로 올라프 올라프"
wc = wc.generate(text)   
```



### (4) 워드 클라우드 저장

```python
wc.to_file('output/ptest2.png')
```



### (5) 워드 클라우드 출력

```python
import matplotlib.pyplot as plt 
fig = plt.figure()
plt.imshow(wc, interpolation='bilinear')               ## 워드 클라우드 이미지로 출력한다 
plt.axis('off') # 필요없는 좌표데이터가 뜨지 않도록 설정
plt.show()
```



### (6) 예시

#### 딕셔너리를 통한 생성

```python
keywords = {'파이썬':7, '넘파이':3, '판다스':5, '매트플롭립':2, '시본':2, '폴리엄':2}             ## 특정 단어의 빈도를 딕셔너리로 만든다 

wc = wc.generate_from_frequencies(keywords)        ## 빈도별로 워드클라우드를 만든다 

fig = plt.figure()
plt.imshow(wc, interpolation='bilinear')
plt.axis('off')
plt.show()
```



#### 불용어 설정 및 클라우드 모양 설정

```python
from PIL import Image                             ## 이미지 파일을 처리하는 모듈을 사용한다. 
import numpy as np
r2d2_mask = np.array(Image.open('data/r2d2.JPG')) ## 이미지를 읽어와서 다차원 배열로 변환한다 

from wordcloud import STOPWORDS  
stopwords = set()                                 ## 한글은 별도로 집합으로 불용어를 만든다 
stopwords.add("은")
stopwords.add("입니다")
stopwords.add("것인가")
stopwords.add("처럼")

wc = WordCloud( stopwords=stopwords,              ## 워드 클라우드 객체를 만든다 
                          font_path = myfontpath,
                          background_color='white',
                           width = 800,
                           height = 800,
                          mask=r2d2_mask)  ## 마스크 인자에 이미지를 전달한다 , 마스크의 형태로 워드클라우드 생성
```



#### 문장으로 생성

```python
texts = ['로봇 처럼 표시하는 것을 보기 위해 이것 은 예문 입니다 가을이라 겨울 바람 솔솔 불어오니 ',
         '여러분 의 문장을 넣 으세요 ㅎㅎㅎ 스타워즈 영화에 나오는 다양한 로봇처럼 r2d2']

wc = wc.generate_from_text(texts[0]+texts[1])    ## 두 개의 문자을 연결해서 워드클라우드를 만든다 

plt.figure(figsize=(8,8))
plt.imshow(wc, interpolation="bilinear")         ## 이미지를 출력하면 전달된 모양에 따라 표시한다 
plt.axis("off")
plt.show()
```



## 4. NLTK

> 한국어 기반의 자연어 처리 모듈(Natural Language Toolkit)