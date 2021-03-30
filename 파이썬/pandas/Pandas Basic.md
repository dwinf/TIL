# Pandas Basic

> 시리즈(Series), 데이터프레임(DataFrame)

- 문자열은 string이 아닌 object로 표현

## 1. 시리즈

- 시리즈는 데이터가 순차적으로 나열된 1차원 배열의 형태를 갖는다. 
- 인덱스와 데이터 값이 일대일 대응된다
  - 파이썬 딕셔너리와 비슷한 구조(`{k:v}`)
- `pandas.Series()` 로 생성

### (1) 시리즈 만들기

- 딕셔너리와 비슷하기 때문에 딕셔너리를 시리즈로 변환하는 방법을 많이 사용

```
딕셔너리 -> 시리즈 변환 : pandas.Series(딕셔너리)
```

##### 예시

```python
# 예제 1-1
# pandas 불러오기 
import pandas as pd

# k:v 구조를 갖는 딕셔너리를 만들고, 변수 dict_data에 저장
dict_data = {'a': 1, 'b': 2, 'c': 3}

# 판다스 Series() 함수로 딕셔너리(dict_data)를 시리즈로 변환. 변수 sr에 저장 
sr = pd.Series(dict_data)

# 변수 sr의 자료형 출력
print(type(sr)) # pandas.core.series.Series
print('\n')

# 변수 sr에 저장되어 있는 시리즈 객체를 출력
print(sr)
```

### (2) 인덱스 구조

- 인덱스는 자기와 짝을 이루는 **원소의 순서와 주소를 저장**
- 인덱스를 잘 활용하면 데이터 값의 탐색, 정렬, 선택, 결합 등 데이터 조작을 쉽게 할 수 있다.
- **인덱스의 종류**
  - 정수형 위치 인덱스(integer position)
  - 인덱스 이름(index name) 또는 인덱스 라벨(index label)

```
인덱스 배열 : Series.index
데이터 값 배열 : Series.values
```

##### 예시

```python
# 예제 1-2
# 리스트를 시리즈로 변환하여 변수 sr에 저장
list_data = ['2019-01-02', 3.14, 'ABC', 100, True]
sr = pd.Series(list_data)
print(sr)

# 인덱스 배열은 변수 idx에 저장. 데이터 값 배열은 변수 val에 저장
idx = sr.index
val = sr.values
print(idx)
print(val)
```



### (3) 원소 선택

- 인덱스를 이용하여 시리즈의 원소를 선택
- 하나의 원소를 선택하거나, 여러 원소를 한꺼번에 선택 가능
- 인덱스 범위를 지정하여 여러 개의 원소 선택 가능
- 인덱스의 유형에 따라 사용법이 조금 다름
  - 정수형 인덱스 : 대괄호(`[]`) 안에 숫자 입력(0부터 시작)
  - 인덱스 이름(라벨) : 대괄호(`[]`) 안에 이름 문자열 입력

##### 예시

```python
# 예제 1-3
import pandas as pd

# 투플을 시리즈로 변환(index 옵션에 인덱스 이름을 지정)
tup_data = ('영인', '2010-05-01', '여', True)
sr = pd.Series(tup_data, index=['이름', '생년월일', '성별', '학생여부'])
print(sr)

# 원소를 1개 선택
print(sr[0])       # sr의 1 번째 원소를 선택 (정수형 위치 인덱스를 활용)
print(sr['이름'])  # '이름' 라벨을 가진 원소를 선택 (인덱스 이름을 활용)

# 여러 개의 원소를 선택 (인덱스 리스트 활용)
print(sr[[1, 2]]) 
print(sr[['생년월일', '성별']])

# 여러 개의 원소를 선택 (인덱스 범위 지정)
print(sr[1 : 2])  
print(sr['생년월일' : '성별'])
```



## 2. 데이터프레임

> 행과 열로 이루어진 2차원 배열

- 여러 개의 시리즈들을 각각의 열로 데이터프레임 구성
  - R의 데이터프레임과 유사
- 행 인덱스, 열 이름으로 구분



### (1) 데이터프레임 만들기

- 여러 개의 시리즈를 모아 놓은 집합
- 데이터프레임은 같은 길이의 1차원 배열(시리즈)가 필요
- 딕셔너리의 값(v)에 해당하는 각 리스트가 시리즈 배열로 변환된어 열 구성
- 딕셔너리의 키(k)는 각 시리즈의 이름으로 변환되어 최종적으로 열 이름
- `pandas.DataFrame(딕셔너리 객체)` 로 생성 

```python
# 열이름을 key로 하고, 리스트를 value로 갖는 딕셔너리 정의(2차원 배열)
dict_data = {'c0':[1,2,3], 'c1':[4,5,6], 'c2':[7,8,9], 'c3':[10,11,12], 'c4':[13,14,15]}

# 판다스 DataFrame() 함수로 딕셔너리를 데이터프레임으로 변환. 변수 df에 저장. 
df = pd.DataFrame(dict_data)
```



### (2) 행 인덱스 / 열 이름 설정

> 행/열 이름을 사용자가 지정 가능

#### 행 인덱스/열 이름 설정

```python
pandas.DataFrame(2차원 배열, 
                 index=행 인덱스 배열, 
                 column=열 이름 배열)
```

```python
import pandas as pd

# 행 인덱스/열 이름 지정하여, 데이터프레임 만들기
df = pd.DataFrame([[15, '남', '덕영중'], [17, '여', '수리중']], 
                   index=['준서', '예은'],
                   columns=['나이', '성별', '학교'])

# 행 인덱스, 열 이름 확인하기
print(df)            #데이터프레임
print('\n')
print(df.index)      #행 인덱스 	Index(['준서', '예은'], dtype='object')
print('\n')
print(df.columns)    #열 이름 		 Index(['나이', '성별', '학교'], dtype='object')
print('\n')
```



#### 행 인덱스/ 열 이름 변경(1)

```
행 인덱스 변경 : DataFrame 객체.index = 새로운 행 인덱스 배열
열 이름 변경 : DataFrame 객체.column = 새로운 열 이름 배열
```

##### 예시

```python
df.index=['학생1', '학생2']
df.columns=['연령', '남녀', '소속']
```



#### 행 인덱스/ 열 이름 변경(2)

```
행 인덱스 변경 : DataFrame 객체.rename(index={기존 인덱스:새 인덱스, ...}, inplace=True)
열 이름 변경 : DataFrame 객체.rename(columns={기존 이름:새 이름, ...}, inplace=True)
```

- rename() 매서드는 **원본 객체를 수정하는 것이 아닌** 새로운 데이터프레임 객체를 리턴
- `inplace=True` 옵션을 사용하면 원본 객체를 변경한다.
  - 기본값은 False

##### 예시

```python
# 열 이름 중, '나이'를 '연령'으로, '성별'을 '남녀'로, '학교'를 '소속'으로 바꾸기
a=df.rename(columns={'나이':'연령', '성별':'남녀', '학교':'소속'}, inplace=True)

# df의 행 인덱스 중에서, '준서'를 '학생1'로, '예은'을 '학생2'로 바꾸기
df.rename(index={'준서':'학생1', '예은':'학생2' }, inplace=True)
```



### (3) 행/열 삭제

> drop()

- 삭제할 행/열을 정할 때 축(axis) 옵션을 이용
  - axis=0은 행(기본값이기 때문에 생략해도 무관)
  - axis=1은 열
- drop() 매서드는 **원본 객체를 수정하는 것이 아닌** 새로운 데이터프레임 객체를 리턴
- `inplace=True` 옵션을 사용하면 원본 객체를 변경한다.
  - 기본값은 False

```
행 인덱스 삭제 : DataFrame 객체.drop(행 인덱스 또는 배열. axis = 0)
열 이름 삭제 : DataFrame 객체.drop(열 이름 또는 배열. axis = 1)
```

##### 예시

```python
# 행 삭제
import pandas as pd

exam_data = {'수학' : [ 90, 80, 70], '영어' : [ 98, 89, 95],
             '음악' : [ 85, 95, 100], '체육' : [ 100, 90, 90]}
df = pd.DataFrame(exam_data, index=['서준', '우현', '인아'])

# 데이터프레임 df를 복제하여 변수 df2에 저장. df2의 1개 행(row)을 삭제
df2 = df.copy()
df2.drop('우현', inplace=True)
print(df2)

# 데이터프레임 df를 복제하여 변수 df3에 저장. df3의 2개 행(row)을 삭제
df3 = df.copy()
df3.drop(['우현', '인아'], axis=0, inplace=True) 
print(df3)
```

```python
# 열 삭제
import pandas as pd

exam_data = {'수학' : [ 90, 80, 70], '영어' : [ 98, 89, 95],
             '음악' : [ 85, 95, 100], '체육' : [ 100, 90, 90]}
df = pd.DataFrame(exam_data, index=['서준', '우현', '인아'])

# 데이터프레임 df를 복제하여 변수 df4에 저장. df4의 1개 열(column)을 삭제
df4 = df.copy()
df4.drop('수학', axis=1, inplace=True)
print(df4)

# 데이터프레임 df를 복제하여 변수 df5에 저장. df5의 2개 열(column)을 삭제
df5 = df.copy()
df5.drop(['영어', '음악'], axis=1, inplace=True)
print(df5)
```



### (4) 행 선택

> loc, iloc 인덱서 사용

- 인덱스 이름을 기준으로 행을 선택할 때는 **loc** 사용
  - `df.loc['a']` or `df.loc['a':'c']`
- 정수형 위치 인덱스를 사용할 때는 **iloc** 사용
  - 데이터프레임 인덱싱 방법
  - `df.iloc[0]` or `df.iloc[0:3]` or `df.iloc[0,]` 등
  - 마지막 인자에 슬라이싱 간격을 줘서 범위 슬라이싱 활용 가능
    - `df.iloc[::2]` , `df.iloc[:3:2]`  : 2행 간격
    - `df.iloc[::-1]` : 역순 정렬

```python
# 예제 1-9
import pandas as pd

exam_data = {'수학' : [ 90, 80, 70], '영어' : [ 98, 89, 95],
             '음악' : [ 85, 95, 100], '체육' : [ 100, 90, 90]}
df = pd.DataFrame(exam_data, index=['서준', '우현', '인아'])

# 행 인덱스를 사용하여 행 1개를 선택
label1 = df.loc['서준']    # loc 인덱서 활용
position1 = df.iloc[0]     # iloc 인덱서 활용
print(label1)
print(position1)
```



### (5) 열 선택

- 대괄호 안에 이름을 입력하는 방식

```
열 1개 생성(시리즈 생성) : df['열 이름'] 또는 df.열 이름
열 n개 생성(데이터프레임 생성) : df[ [열1, 열2 ... 열n] ]
```

##### 예시

```python
# 예제 1-10
import pandas as pd
exam_data = {'이름' : [ '서준', '우현', '인아'],
             '수학' : [ 90, 80, 70],
             '영어' : [ 98, 89, 95],
             '음악' : [ 85, 95, 100],
             '체육' : [ 100, 90, 90]}
df = pd.DataFrame(exam_data)
print(type(df))

# '수학' 점수 데이터만 선택. 변수 math1에 저장
math1 = df['수학']
print(math1)
print(type(math1)) # <class 'pandas.core.series.Series'>

# '영어' 점수 데이터만 선택. 변수 english에 저장
english = df.영어
print(english)

# '음악', '체육' 점수 데이터를 선택. 변수 music_gym 에 저장
music_gym = df[['음악', '체육']]
print(music_gym)
print(type(music_gym)) # <class 'pandas.core.frame.DataFrame'>

# '수학' 점수 데이터만 선택. 변수 math2에 저장
math2 = df[['수학']]
print(math2)
```



### (6) 원소 선택

- 행 인덱스와 열 이름을 **[행, 열]** 형식의 2차원 좌표로 입력하여 원소 위치 지정
  - 2개 이상의 행과 1개 열을 선택하면 시리즈 객체 반환
  - 2개 이상의 행과 2개 이상의 열을 선택하면 데이터프레임 객체 반환

```
인덱스 이름 : DataFrame 객체.loc[행 인덱스, 열 이름]
정수 위치 인덱스 : DataFrame 객체.iloc[행 번호, 열 번호]
```

##### 예시

```python
# 예제 1-11
import pandas as pd
exam_data = {'이름' : [ '서준', '우현', '인아'],
             '수학' : [ 90, 80, 70],
             '영어' : [ 98, 89, 95],
             '음악' : [ 85, 95, 100],
             '체육' : [ 100, 90, 90]}
df = pd.DataFrame(exam_data)

# '이름' 열을 새로운 인덱스로 지정하고, df 객체에 변경사항 반영
df.set_index('이름', inplace=True) # 행 이름의 이름

# 데이터프레임 df의 특정 원소 1개 선택 ('서준'의 '음악' 점수)
a = df.loc['서준', '음악']
print(a) # 85
b = df.iloc[0, 2]
print(b) # 85

# 데이터프레임 df의 특정 원소 2개 이상 선택 ('서준'의 '음악', '체육' 점수) 
c = df.loc['서준', ['음악', '체육']]
print(c)
d = df.iloc[0, [2, 3]]
print(d)
e = df.loc['서준', '음악':'체육']
print(e)
f = df.iloc[0, 2:]
print(f)

# df의 2개 이상의 행과 열로부터 원소 선택 ('서준', '우현'의 '음악', '체육' 점수) 
g = df.loc[['서준', '우현'], ['음악', '체육']]
print(g)
h = df.iloc[[0, 1], [2, 3]]
print(h)
i = df.loc['서준':'우현', '음악':'체육']
print(i)
j = df.iloc[0:2, 2:]
print(j)
```



### (7) 열 추가

- 데이터프레임에 열 추가
- 추가한 열의 모든 행에 동일한 값이 입력됨

```
열 추가 : DataFrame 객체['추가하려는 열 이름'] = 데이터 값
```

##### 예시

```python
# 예제 1-12
import pandas as pd

exam_data = {'이름' : [ '서준', '우현', '인아'],
             '수학' : [ 90, 80, 70],
             '영어' : [ 98, 89, 95],
             '음악' : [ 85, 95, 100],
             '체육' : [ 100, 90, 90]}
df = pd.DataFrame(exam_data)

# 데이터프레임 df에 '국어' 점수 열(column)을 추가. 데이터 값은 80 지정
df['국어'] = 80
df.국어 = 100
df.국어 = [100, 90, 80]
df['사회'] = 70 # 처음 추가하는 열이름인 경우에는 . 사용 못함
```



### (8) 행 추가

- 데이터프레임에 행 추가
- 행 인덱스와 데이터 값을 loc 인덱서를 사용해 입력

```
행 추가 : DataFrame.loc['추가하려는 행 이름'] = 데이터 값(또는 배열)
```

- 데이터 값을 주면 모든 열에 동일한 값 입력
- 배열을 주면 배열의 값 적용

##### 예시

```python
# 예제 1-13
import pandas as pd

exam_data = {'이름' : ['서준', '우현', '인아'],
             '수학' : [ 90, 80, 70],
             '영어' : [ 98, 89, 95],
             '음악' : [ 85, 95, 100],
             '체육' : [ 100, 90, 90]}
df = pd.DataFrame(exam_data)

# 새로운 행(row)을 추가 - 같은 원소 값을 입력
df.loc[3] = 0

# 새로운 행(row)을 추가 - 원소 값 여러 개의 배열 입력
df.loc[4] = ['동규', 90, 80, 70, 60]

# 새로운 행(row)을 추가 - 기존 행을 복사
df.loc['행5'] = df.loc[3] # 행이름= '행5', 행 내용 = df.loc[3]
```



### (9) 원소 값 변경

- 원소를 선택하고 새로운 데이터 값을 지정

```
원소 값 변경 : DataFrame 객체의 일부 또는 원소 선택 = 데이터 값(또는 배열)
```

- 데이터 값을 주면 모든 열에 동일한 값 입력
- 배열을 주면 배열의 값 적용

##### 예시

```python
# 예제 1-14
import pandas as pd

exam_data = {'이름' : [ '서준', '우현', '인아'],
             '수학' : [ 90, 80, 70],
             '영어' : [ 98, 89, 95],
             '음악' : [ 85, 95, 100],
             '체육' : [ 100, 90, 90]}
df = pd.DataFrame(exam_data)

# '이름' 열을 새로운 인덱스로 지정하고, df 객체에 변경사항 반영
df.set_index('이름', inplace=True)
print(df)

# 데이터프레임 df의 특정 원소를 변경하는 방법: '서준'의 '체육' 점수
df.iloc[0][3] = 80
print(df)

df.loc['서준']['체육'] = 90
print(df)

df.loc['서준', '체육'] = 100
print(df)

# 데이터프레임 df의 원소 여러 개를 변경하는 방법: '서준'의 '음악', '체육' 점수
df.loc['서준', ['음악', '체육']] = 50
print(df)

df.loc['서준', ['음악', '체육']] = 100, 50
print(df)
```



### (10) 행, 열의 위치 바꾸기

- 데이터프레임의 행과 열을 서로 맞바꿈
- 전치의 결과로 새로운 객체 반환

```
행,열 바꾸기 : DataFrame 객체.tranpose() 또는 DataFrame 객체.T
```

##### 예시

```python
# 예제 1-15
import pandas as pd

exam_data = {'이름' : [ '서준', '우현', '인아'],
             '수학' : [ 90, 80, 70],
             '영어' : [ 98, 89, 95],
             '음악' : [ 85, 95, 100],
             '체육' : [ 100, 90, 90]}
df = pd.DataFrame(exam_data)
print(df)

# 데이터프레임 df를 전치하기 (메소드 활용)
df = df.transpose()
print(df)

# 데이터프레임 df를 다시 전치하기 (클래스 속성 활용)
df = df.T
```



## 3. 인덱스 활용

### (1) 특정 열을 행 인덱스로 설정

- `set_index()` 메소드를 사용해 설정
- 원본 데이터프레임을 바꾸지 않고 **새로운 데이터프레임 객체를 반환**한다.
  - inplace 옵션을 쓰면 원본을 바꿈

```
특정 열을 행 인덱스로 설정 : df.set_index(['열 이름'] 또는 '열 이름')
```

##### 예시

```python
# 예제 1-16
import pandas as pd

exam_data = {'이름' : [ '서준', '우현', '인아'],
             '수학' : [ 90, 80, 70],
             '영어' : [ 98, 89, 95],
             '음악' : [ 85, 95, 100],
             '체육' : [ 100, 90, 90]}
df = pd.DataFrame(exam_data)

# 특정 열(column)을 데이터프레임의 행 인덱스(index)로 설정 
ndf = df.set_index(['이름'])
print(ndf)
ndf2 = ndf.set_index('음악')
print(ndf2)
ndf3 = ndf.set_index(['수학', '음악']) # 2개 이상도 가능
print(ndf3)
```



### (2) 행 인덱스 재배열

- `reindex()` 메소드를 사용
- 원본 데이터프레임을 바꾸지 않고 **새로운 데이터프레임 객체를 반환**한다.

```
새로운 배열로 행 인덱스를 재지정 : df.reindex(새로운 인덱스 배열)
```

- 기존 데이터프레임에 존재하지 않는 행 인덱스가 새롭게 추가되는 경우, 그 행의 데이터 값은 NaN 값이 입력
  - fill_value 옵션으로 NaN이 아닌 값으로 입력

##### 예시

```python
# 예제 1-17
import pandas as pd

# 딕셔서리를 정의
dict_data = {'c0':[1,2,3], 'c1':[4,5,6], 'c2':[7,8,9], 'c3':[10,11,12], 'c4':[13,14,15]}

# 딕셔서리를 데이터프레임으로 변환. 인덱스를 [r0, r1, r2]로 지정
df = pd.DataFrame(dict_data, index=['r0', 'r1', 'r2'])
print(df)

# 인덱스를 [r0, r1, r2, r3, r4]로 재지정
new_index = ['r0', 'r1', 'r2', 'r3', 'r4']
ndf = df.reindex(new_index)
print(ndf)

# reindex로 발생한 NaN값을 숫자 0으로 채우기
new_index = ['r0', 'r1', 'r2', 'r3', 'r4']
ndf2 = df.reindex(new_index, fill_value=0)
print(ndf2)
```



### (3) 행 인덱스 초기화

- `reset_index()` 메소드를 사용
- 원본 데이터프레임을 바꾸지 않고 **새로운 데이터프레임 객체를 반환**한다.

```
정수형 위치 인덱스로 초기화 : df.reset_index(새로운 인덱스 배열)
```

##### 예시

```python
# 예제 1-18
import pandas as pd

# 딕셔서리를 정의
dict_data = {'c0':[1,2,3], 'c1':[4,5,6], 'c2':[7,8,9], 'c3':[10,11,12], 'c4':[13,14,15]}

# 딕셔서리를 데이터프레임으로 변환. 인덱스를 [r0, r1, r2]로 지정
df = pd.DataFrame(dict_data, index=['r0', 'r1', 'r2'])
print(df)

# 행 인덱스를 정수형으로 초기화 
ndf = df.reset_index()
print(ndf)
```



### (4) 행 인덱스를 기준으로 데이터프레임 정렬

- `sort_index()` 메소드를 사용
- 원본 데이터프레임을 바꾸지 않고 **새로운 데이터프레임 객체를 반환**한다.
- ascending 옵션을 사용하여 오름차순 또는 내림차순 설정
  - ascending = True : 오른차순
  - ascending = False : 내림차순

```
행 인덱스 기준 정렬 : df.sort_index()
```

##### 예시

```python
# 예제 1-19
import pandas as pd

# 딕셔서리를 정의
dict_data = {'c0':[1,2,3], 'c1':[4,5,6], 'c2':[7,8,9], 'c3':[10,11,12], 'c4':[13,14,15]}

# 딕셔서리를 데이터프레임으로 변환. 인덱스를 [r0, r1, r2]로 지정
df = pd.DataFrame(dict_data, index=['r0', 'r1', 'r2'])
print(df)
print('\n')

# 내림차순으로 행 인덱스 정렬 
ndf = df.sort_index(ascending=False)
print(ndf)
```



### (5) 특정 열의 데이터 값을 기준으로 데이터프레임 정렬

- `sort_values()` 메소드를 사용
- 원본 데이터프레임을 바꾸지 않고 **새로운 데이터프레임 객체를 반환**한다.
- ascending 옵션을 사용하여 오름차순 또는 내림차순 설정
  - ascending = True : 오른차순
  - ascending = False : 내림차순
- by 옵션을 통해 기준 설정

```
열 기준 정렬 : df.sort_values()
```

##### 예시

```python
# 예제 1-20
import pandas as pd

# 딕셔서리를 정의
dict_data = {'c0':[1,2,3], 'c1':[4,5,6], 'c2':[7,8,9], 'c3':[10,11,12], 'c4':[13,14,15]}

# 딕셔서리를 데이터프레임으로 변환. 인덱스를 [r0, r1, r2]로 지정
df = pd.DataFrame(dict_data, index=['r0', 'r1', 'r2'])
print(df)

# c1 열을 기준으로 내림차순 정렬 
ndf = df.sort_values(by='c1', ascending=False)
print(ndf)
```



## 4. 산술연산

#### 판다스 객체의 산술연산은 내부적으로 3단계 프로세스를 거친다.

1. 행/열 인덱스를 기준으로 모든 원소를 정렬한다.
2. 동일한 위치에 있는 원소끼리 일대일로 대응시킨다.
3. 일대일 대응이 되는 원소끼리 연산을 처리한다. 이때, 대응되는 원소가 없으면 NaN으로 처리한다.



### (1) 시리즈 연산

#### 1. 시리즈 vs 숫자

- 시리즈의 개별 원소에 각각 숫자를 연산한 결과를 새로운 시리즈 객체로 반환

```
시리즈와 숫자 연산 : Series객체 + 연산자(+,-,*,/) + 숫자
```

##### 예시

```python
# 예제 1-21
import pandas as pd

# 딕셔너리 데이터로 판다스 시리즈 만들기
student1 = pd.Series({'국어':100, '영어':80, '수학':90})
print(student1)

# 학생의 과목별 점수를 200으로 나누기
percentage = student1 / 200

print(percentage)
print(type(percentage)) # <class 'pandas.core.series.Series'>
```



#### 2. 시리즈 vs 시리즈

- 같은 인덱스를 가진 원소끼리 계산
- 연산 결과를 매칭하여 새로운 시리즈 반환

```
시리즈와 숫자 연산 : Series객체 + 연산자(+,-,*,/) + 시리즈
```

##### 예시

```python
# 예제 1-22
import pandas as pd

# 딕셔너리 데이터로 판다스 시리즈 만들기
student1 = pd.Series({'국어':100, '영어':80, '수학':90})
student2 = pd.Series({'수학':80, '국어':90, '영어':80})

print(student1)
print(student2)

# 두 학생의 과목별 점수로 사칙연산 수행
addition = student1 + student2               #덧셈
subtraction = student1 - student2            #뺄셈
multiplication = student1 * student2         #곱셈
division = student1 / student2               #나눗셈
print(addition)
print()
print(division)
print(type(division)) # <class 'pandas.core.series.Series'>

result = pd.DataFrame([addition, subtraction, multiplication], 
                      index=['덧셈', '뺄셈', '곱셈'])
print(result)

# 사칙연산 결과를 데이터프레임으로 합치기 (시리즈 -> 데이터프레임)
result = pd.DataFrame([addition, subtraction, multiplication, division], 
                      index=['덧셈', '뺄셈', '곱셈', '나눗셈'])
print(result)
```



- 시리즈의 원소 개수가 다르거나 인덱스 값이 다를 경우 NaN 처리
- 같은 인덱스가 양 쪽에 존재하여도 어느 한 쪽의 데이터 값이 NaN인 경우에도 NaN 처리

```python
# 예제 1-23
import pandas as pd
import numpy as np

# 딕셔너리 데이터로 판다스 시리즈 만들기
student1 = pd.Series({'국어':np.nan, '영어':80, '수학':90})
student2 = pd.Series({'수학':80, '국어':90})

print(student1)
print(student2)

# 두 학생의 과목별 점수로 사칙연산 수행 (시리즈 vs. 시리즈)
addition = student1 + student2               #덧셈
subtraction = student1 - student2            #뺄셈
multiplication = student1 * student2         #곱셈
division = student1 / student2               #나눗셈
print(type(division))

# 사칙연산 결과를 데이터프레임으로 합치기 (시리즈 -> 데이터프레임)
result = pd.DataFrame([addition, subtraction, multiplication, division], 
                      index=['덧셈', '뺄셈', '곱셈', '나눗셈'])
print(result)
```

![image](https://user-images.githubusercontent.com/73389275/112942078-8f335900-916a-11eb-845e-5ead1141880e.png)



#### 3. 연산 메소드 활용

- 객체 사이에 공통 인덱스가 없는 경우 NaN으로 반환
  - fill_value 옵션으로 원하는 값 입력

```
연산 메소드 사용(시리즈와 시리즈 덧셈) : Series1.add(Series2, fill_value=0)
```

##### 예시

```python
# 예제 1-24
import pandas as pd
import numpy as np

# 딕셔너리 데이터로 판다스 시리즈 만들기
student1 = pd.Series({'국어':np.nan, '영어':80, '수학':90})
student2 = pd.Series({'수학':80, '국어':90})

print(student1)
print(student2)

# 두 학생의 과목별 점수로 사칙연산 수행 (연산 메소드 사용)
sr_add = student1.add(student2, fill_value=0)    #덧셈
sr_sub = student1.sub(student2, fill_value=0)    #뺄셈
sr_mul = student1.mul(student2, fill_value=0)    #곱셈
sr_div = student1.div(student2, fill_value=0)    #나눗셈

# 사칙연산 결과를 데이터프레임으로 합치기 (시리즈 -> 데이터프레임)
result = pd.DataFrame([sr_add, sr_sub, sr_mul, sr_div], 
                      index=['덧셈', '뺄셈', '곱셈', '나눗셈'])
print(result)
```



### (2) 데이터프레임 연산

- 행/열 인덱스를 기준으로 정렬하고 일대일 대응되는 원소끼리 연산을 처리

#### 1. 데이터프레임 vs 숫자

- 데이터프레임에 숫자를 더하면, 모든 원소에 숫자를 더한다.(덧셈, 뺄셈, 곱셈, 나눗셈 모두 가능)
- 기존 데이터프레임의 형태를 그대로 유지한 채, 원소 값만 새로운 값으로 바뀐다.

```
데이터프레임과 숫자 연산 : DataFrame객체 + 연산자(+,-,*,/) + 숫자
```

##### 예시

```python
# 예제 1-25
#import pandas as pd
import seaborn as sns

# titanic 데이터셋에서 age, fare 2개 열을 선택하여 데이터프레임 만들기
titanic = sns.load_dataset('titanic')
df = titanic.loc[:, ['age','fare']]
print(df.head())   #첫 5행만 표시
print(type(df))

# 데이터프레임에 숫자 10 더하기
addition = df + 10
print(addition.head())   #첫 5행만 표시
print(type(addition))
```

- seaborn라이브러리에서 titanic 데이터 셋 제공



#### 2. 데이터프레임 vs 데이터프레임 

- 각 데이터프레임의 같은 행, 간은 열 위치에 있는 원소끼리 계산
- 동일한 위치의 숸소끼리 계산한 결과값을 원래 위치에 다시 입력하여 데이터프레임을 만듦

```
데이터프레임의 연산자 활용 : DataFrame1 + 연산자(+,-,*,/) + DataFrame2
```

![image](https://user-images.githubusercontent.com/73389275/112943221-2e0c8500-916c-11eb-94a7-a7681f043030.png)

##### 예시

```python
# 예제 1-26
#import pandas as pd
import seaborn as sns

# titanic 데이터셋에서 age, fare 2개 열을 선택하여 데이터프레임 만들기
titanic = sns.load_dataset('titanic')
df = titanic.loc[:, ['age','fare']]
print(df.tail())          #마지막 5행을 표시
print(type(df))

# 데이터프레임에 숫자 10 더하기
addition = df + 10
print(addition.tail())    #마지막 5행을 표시
print(type(addition))

# 데이터프레임끼리 연산하기 (additon - df)
subtraction = addition - df
print(subtraction.tail())   #마지막 5행을 표시
print(type(subtraction))
```

