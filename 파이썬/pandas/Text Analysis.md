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

#### (1) nltk 사용

```python
import nltk                     ## 한국어 자연어처리 모듈 
```



#### (2) 테스트용 말뭉치

```python
from konlpy.corpus import kobill
files_ko = kobill.fileids() # 국회 의안 말뭉치
files_ko
doc_ko = kobill.open('1809898.txt').read()         ## 특정 텍스트 파일을 읽어온다 
doc_ko
```



#### (3) 명사 추출

```python
from konlpy.tag import Okt      
t = Okt()
tokens_ko = t.nouns(doc_ko)                ## 텍스트에서 명사를 추출한다. 
print(tokens_ko[:10])
```



#### (4) 텍스트 객체 생성

```python
nouns_text = nltk.Text(tokens_ko, name='국군부대의 소말리아 해역 파견연장 동의안')
```

- name 옵션 객체명을 의미



#### (5) 텍스트 객체 사용

```python
nouns_text # name 출력
type(nouns_text)				## nltk.text.Text
len(nouns_text.tokens)          ## 명사로 분리된 개수를 확인한다 
len(set(nouns_text.tokens))     ## 유일한 단어의 개수를 확인한다 
nouns_text.tokens[:10]			## 명사 출력
nouns_text.vocab()              ## 동일한 단어의 발생 빈도를 확인한다. 
nouns_text.count('파견')         ## 특정 단어의 발생빈도를 확인한다. 
nouns_text.concordance('소말리아')      ## 특정 단어가 있는 곳 리턴
data = nouns_text.vocab().most_common(150)   ## 가장 많이 발생한 150개의 단어를 선택한다. 
```



#### (6) 워드 클라우드 생성

```python
wc = WordCloud(font_path=myfontpath,       ## .한글에 대한 위치를 표시한다. 
                      relative_scaling = 0.2,
                      background_color='white',
                      ).generate_from_frequencies(dict(data))    ## .단어별 빈도수를 딕셔너리로 변환해서 전달한다 
plt.figure(figsize=(10,6))
plt.imshow(wc)             ## .이미지를 출력한다 
plt.axis("off")            ## 그래프에 대한 축을 표시하지 않는다 
plt.show()
```

- **mask** : 워드 클라우드의 형태 지정 옵션
  - `mask=np.array(Image.open('images/clover.jpg'))`



## 5. 텍스트 전처리

> 한국어 전처리 패키지 : PyKoSpacing & Py-Hanspell

### PyKoSpacing 

- 한국어 띄어쓰기 패키지
- 띄어쓰기가 되어있지 않은 문장을 띄어쓰기를 한 문장으로 변환해주는 패키지
- 대용량 코퍼스를 학습하여 만들어진 띄어쓰기 딥 러닝 모델로 준수한 성능을 가지고 있다.

### Py-Hanspell

- 한국어 맞춤법 검사 패키지
- 맞춤법을 교정해줌



### 패키지 준비

```python
from pykospacing import spacing
from hanspell import spell_checker
```

#### 띄워쓰기 교정

```python
sent = '김철수는 극중 두 인격의 사나이 이광수 역을 맡았다. 철수는 한국 유일의 태권도 전승자를 가리는 결전의 날을 앞두고 10년간 함께 훈련한 사형인 유연재(김광수 분)를 찾으러 속세로 내려온 인물이다.'
new_sent = sent.replace(" ", '') # 띄어쓰기가 없는 문장 임의로 만들기
print(new_sent)

kospacing_sent = spacing(new_sent)
print(kospacing_sent) # sent와 동일하게 출력
```

#### 맞춤법 교정

```python
from hanspell import spell_checker

sent = "맞춤법 틀리면 외 않되? 쓰고싶은대로쓰면돼지 "
spelled_sent = spell_checker.check(sent) # 맞춤법 체크, ㄷ

hanspell_sent = spelled_sent.checked
print(hanspell_sent) # 맞춤법 틀리면 왜 안돼? 쓰고 싶은 대로 쓰면 되지
```

- 맞춤법과 띄어쓰기까지 교정



## 6. 카운트 기반의 단어 표현

> 토큰화 : 주어진 코퍼스(corpus)에서 토큰(token)이라 불리는 단위로 나누는 작업을 토큰화(tokenization)라고 한다.

- 토큰화를 위한 패키지 설치

```python
import nltk
nltk.download('punkt')
```



#### 방법(1) - nltk 패키지의 word_tokenize() 사용

```python
from nltk.tokenize import word_tokenize 

corpus = "고기를 아무렇게나 구우려고 하면 안 돼. 고기라고 다 같은 게 아니거든. 예컨대 삼겹살을 구울 때는 중요한 게 있지."
word_tokens1 = word_tokenize(corpus)
print(word_tokens1) 
```

- ```
  ['고기를', '아무렇게나', '구우려고', '하면', '안', '돼', '.', '고기라고', '다', '같은', '게', '아니거든', '.', '예컨대', '삼겹살을', '구울', '때는', '중요한', '게', '있지', '.']
  ```



#### 방법(2) - Okt 객체의 morphs() 사용

```python
from konlpy.tag import Okt
t = Okt()  
corpus = "고기를 아무렇게나 구우려고 하면 안 돼. 고기라고 다 같은 게 아니거든. 예컨대 삼겹살을 구울 때는 중요한 게 있지."  
word_tokens2 = t.morphs(corpus)  
print(word_tokens2)
```

- ```
  ['고기', '를', '아무렇게나', '구', '우려', '고', '하면', '안', '돼', '.', '고기', '라고', '다', '같은', '게', '아니거든', '.', '예컨대', '삼겹살', '을', '구울', '때', '는', '중요한', '게', '있지', '.']
  ```



#### 방법(3) - Okt 객체의 nouns() 사용

```python
from konlpy.tag import Okt
t = Okt()  
corpus = "고기를 아무렇게나 구우려고 하면 안 돼. 고기라고 다 같은 게 아니거든. 예컨대 삼겹살을 구울 때는 중요한 게 있지."  
word_tokens3 = t.nouns(corpus)  
print(word_tokens3)
```

- ```
  ['고기', '우려', '안', '고기', '게', '삼겹살', '구울', '때', '게']
  ```



#### 불용어를 제거한 토큰 출력

```python
stop_words = "아무거나 아무렇게나 어찌하든지 같다 비슷하다 예컨대 이럴정도로 하면 아니거든 게 때"
stop_words = stop_words.split(' ')

result = [] 
for w in word_tokens3: 
    if w not in stop_words: 
        result.append(w) 

print(result)
```



### 카운트 기반의 단어 표현

- **Bag of Words(BoW)**
  - 단어들의 순서는 고려하지 않고, 단어들의 출현 빈도에만 집중하는 텍스트 데이터의 수치화 표현 방법
- **DTM(또는 TDM)**
  - BoW의 확장으로서 TF 방법과 TF_IDF 방식으로 생성 가능
- **TF-IDF(Term Frequency-Inverse Document Frequency)**
  - 빈도수 기반 단어 표현에 단어의 중요도에 따른 가중치를 주는 방법
- **사이킷 런**
  - 단어의 빈도를 Count하여 Vector로 만드는 **CountVectorizer** 클래스를 지원

##### 예시1

```python
from sklearn.feature_extraction.text import CountVectorizer
corpus = ["정부가 발표하는 물가상승률과 소비자가 느끼는 물가상승률은 다르다"]
vector = CountVectorizer(stop_words=["정부가", "소비자가"])
r = vector.fit_transform(corpus).toarray()
print(r) # 코퍼스로부터 각 단어의 빈도 수를 기록한다.
print(r.shape)
print(vector.vocabulary_)
```

- **CountVectorizer** : 각 텍스트에서 단어 출현 횟수를 카운팅한 벡터
- `fit_transform(corpus)` : 문자열을 토큰화하여 빈도 수 카운트
- `vector.vocabulary_` : 토큰화된 단어들을 보여줌



##### 예시2

```python
import pandas as pd # 데이터프레임 사용을 위해

corpus = [
  '먹고 싶은 사과',
  '먹고 싶은 바나나',
  '길고 노란 바나나 바나나',
  '저는 과일이 좋아요'
] 

vector = CountVectorizer()
dtm = vector.fit_transform(corpus).toarray()
print(dtm) 
print(vector.vocabulary_) # 각 단어들의 인덱스가 어떻게 부여되었는지를 보여준다.

tf = pd.DataFrame(dtm, columns = vector.get_feature_names())
display(tf)

from sklearn.feature_extraction.text import TfidfVectorizer
vector = TfidfVectorizer()
dtm = vector.fit_transform(corpus).toarray()
print(dtm) 
print(vector.vocabulary_) # 각 단어들의 인덱스가 어떻게 부여되었는지를 보여준다.

tfidf = pd.DataFrame(dtm, columns = vector.get_feature_names())
display(tfidf)
```

- **TfidfVectorizer** : TF-IDF라는 값을 사용하여 CountVectorizer의 단점을 보완함
  - 빈도수 기반으로 단어의 중요도에 따른 가중치를 줌



##### 예시3(코사인 유사도 분석)

```python
from sklearn.metrics.pairwise import cosine_similarity

similarity_simple_pair = cosine_similarity(dtm, dtm) # 코사인 유사도 분석
print(similarity_simple_pair)
```



## 7. 한글 자모 분해와 결합

```python
import hgtk                      ## 한글의 자음과 모음을 분리하는 모듈을 사용한다 
```



### 자모 분해, 결합

```python
hgtk.letter.decompose('감')          ## 특정 글자를 분리하면 초성 중성 종성으로 분리된다 
# ('ㄱ', 'ㅏ', 'ㅁ')
hgtk.letter.compose('ㄱ', 'ㅏ', 'ㅁ')      ## 분리된 글자를 하나의 글자로 합친다. 
# '감'
```



### 언어 확인

```python
hgtk.checker.is_hangul('한글입니다')           ## 한글 여부를 확인한다 
hgtk.checker.is_hanja('大韓民國')                  ## 한자도 확인할 수 있다. 
```

- 조건을 충족하면 True 리턴
  - 일부라도 다른 언어(특수문자 포함)가 들어가면 False리턴



### 조사 부착

```python
hgtk.josa.attach('하늘', hgtk.josa.EUN_NEUN)   ## 단어에 맞는 조사를 붙여볼 수 있다. 
hgtk.josa.attach('하늘', hgtk.josa.I_GA)
hgtk.josa.attach('하늘', hgtk.josa.EUL_REUL)
```

- 은/는, 이/가, 을/를 중 단어에 맞는 조사를 붙임