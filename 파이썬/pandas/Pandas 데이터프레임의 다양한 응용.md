# Pandas 데이터프레임의 다양한 응용(part 6)

## 1. 함수 매핑

> 함수 매핑은 시리즈 또는 데이터프레임의 개별 원소를 특정 함수에 일대일 대응시키는 과정을 뜻한다.

- 사용자가 직접 만든 함수(lambda 함수 포함)를 적용할 수 있기 때문에 판다스 기본 함수로 처리하기 어려운 연산을 적용시킬 수 있다.

### 1-1 개별 원소에 함수 매핑

#### (1) 시리즈 원소에 함수 매핑

- `apply()` 메소드를 적용

```
시리즈 원소에 함수 매핑 : Series객체.apply(매핑 함수)
```

##### 예시

```python
# 예제 6-1
import seaborn as sns

# titanic 데이터셋에서 age, fare 2개 열을 선택하여 데이터프레임 만들기
titanic = sns.load_dataset('titanic')
df = titanic.loc[:, ['age','fare']]
df['ten'] = 10
print(df.head())
print('\n')

# 사용자 함수 정의
def add_10(n):   # 10을 더하는 함수
    return n + 10

def add_two_obj(a, b):    # 두 객체의 합
    return a + b

print(add_10(10))
print(add_two_obj(10, 10))

# 시리즈 객체에 적용
sr1 = df['age'].apply(add_10)               # n = df['age']의 모든 원소
print(sr1.head())
  
# 시리즈 객체와 숫자에 적용 : 2개의 인수(시리즈 + 숫자)
sr2 = df['age'].apply(add_two_obj, b=10)    # a=df['age']의 모든 원소, b=10
print(sr2.head())

# 람다 함수 활용: 시리즈 객체에 적용
sr3 = df['age'].apply(lambda x: add_10(x))  # x=df['age']
print(sr3.head())
```



#### (2) 데이터프레임 원소에 함수 매핑

- `applymap()` 메소드를 적용

```
데이터프레임 원소에 함수 매핑 : DataFrame객체.applymap(매핑 함수)
```

##### 예시

```python
# 예제 6-2
import seaborn as sns

# titanic 데이터셋에서 age, fare 2개 열을 선택하여 데이터프레임 만들기
titanic = sns.load_dataset('titanic')
df = titanic.loc[:, ['age','fare']]
print(df.head())

# 사용자 함수 정의
def add_10(n):   # 10을 더하는 함수
    return n + 10
    
# 데이터프레임에 applymap()으로 add_10() 함수를 매핑 적용
df_map = df.applymap(add_10)   
print(df_map.head())
```



### 1-2 시리즈 객체에 함수 매핑

#### (1) 데이터프레임의 각 열에 함수 매핑

- `apply(axis=0)` 메소드 적용

```
데이터프레임의 열에 함수 매핑 : DataFrame객체.apply(매핑 함수, axis=0)
```

##### 예시

```python
# 예제 6-3
import seaborn as sns

# titanic 데이터셋에서 age, fare 2개 열을 선택하여 데이터프레임 만들기
titanic = sns.load_dataset('titanic')
df = titanic.loc[:, ['age','fare']]
print(df.head())
print('\n')

# 사용자 함수 정의
def missing_value(series):    # 시리즈를 인수로 전달
    return series.isnull()    # 불린 시리즈를 반환
    
# 사용자 함수 정의
def min_max(x):    # 최대값 - 최소값
    return x.max() - x.min()

# 데이터프레임의 각 열을 인수로 전달하면 데이터프레임을 반환
result = df.apply(missing_value, axis=0)  
print(result.head())
print(type(result))
# 데이터프레임의 각 열을 인수로 전달하면 데이터프레임을 반환
result = df.apply(min_max)   #기본값 axis=0 
print(result)
print(type(result))
```



#### (2) 데이터프레임의 각 행에 함수 매핑

- `apply(axis=1)` 메소드 적용

```
데이터프레임의 열에 함수 매핑 : DataFrame객체.apply(매핑 함수, axis=1)
```

##### 예시

```python
# 예제 6-5
import seaborn as sns

# titanic 데이터셋에서 age, fare 2개 열을 선택하여 데이터프레임 만들기
titanic = sns.load_dataset('titanic')
df = titanic.loc[:, ['age','fare']]
df['ten'] = 10
print(df.head())

# 사용자 함수 정의
def add_two_obj(a, b):    # 두 객체의 합
    return a + b
    
# 데이터프레임의 2개 열을 선택하여 적용
# x=df, a=df['age'], b=df['ten']
df['add'] = df.apply(lambda x: add_two_obj(x['age'], x['ten']), axis=1)   
print(df.head())
```



### 1-3 데이터프레임 객체에 함수 매핑

- `pipe()` 메소드 활용
- 함수의 리턴값에 다시 pipe() 함수 사용 가능

```
데이터프레임 객체에 함수 매핑 : DataFrame객체.pipe(매핑 함수)
df.pipe(함수1).pipe(함수2)
```

##### 예시

```python
# 예제 6-6
import seaborn as sns

# titanic 데이터셋에서 age, fare 2개 열을 선택하여 데이터프레임 만들기
titanic = sns.load_dataset('titanic')
df = titanic.loc[:, ['age','fare']]

# 각 열의 NaN 찾기 - 데이터프레임 전달하면 데이터프레임을 반환
def missing_value(x):    
    return x.isnull()    

# 각 열의 NaN 개수 반환 - 데이터프레임 전달하면 시리즈 반환
def missing_count(x):
    return missing_value(x).sum()

# 데이터프레임의 총 NaN 개수 - 데이터프레임 전달하면 값을 반환
def totoal_number_missing(x):    
    return missing_count(x).sum()
    
# 데이터프레임에 pipe() 메소드로 함수 매핑
result_df = df.pipe(missing_value)   
print(result_df.head())
print(type(result_df))

result_series = df.pipe(missing_count)   
print(result_series)
print(type(result_series))

result_value = df.pipe(totoal_number_missing)   
print(result_value)
print(type(result_value))
```



## 2. 열 재구성

### 2-1 열 순서 변경

- 열 이름을 원하는 순서대로 정리해서 리스트로 만들고 데이터프레임에서 열을 다시 선택하는 방식으로 열 순서를 바꿀 수 있다.

```
데이터프레임의 열 순서 변경 : df[재구성한 열 이름의 리스트]
```

##### 예시

```python
# 예제 6-7
import seaborn as sns

# titanic 데이터셋의 부분을 선택하여 데이터프레임 만들기
titanic = sns.load_dataset('titanic')
df = titanic.loc[0:4, 'survived':'age']
print(df, '\n')

# 열 이름의 리스트 만들기
columns = list(df.columns.values)   #기존 열 이름
print(columns, '\n')

# 열 이름을 알파벳 순으로 정렬하기
columns_sorted = sorted(columns)    #알파벳 순으로 정렬
df_sorted = df[columns_sorted]
print(df_sorted, '\n')

# 열 이름을 기존 순서의 정반대 역순으로 정렬하기
columns_reversed = list(reversed(columns))  
df_reversed = df[columns_reversed]
print(df_reversed, '\n')

# 열 이름을 사용자가 정의한 임의의 순서로 재배치하기
columns_customed = ['pclass', 'sex', 'age', 'survived']  
df_customed = df[columns_customed]
print(df_customed)
```



### 2-2 열 분리

- 문자열 분리를 이용하여 열 분리
  - `split()`

##### 예시

```python
# 예제 6-8
import pandas as pd

# 데이터셋 가져오기
df = pd.read_excel('./data/주가데이터.xlsx')
print(df.head(), '\n')
print(df.dtypes, '\n')

# 연, 월, 일 데이터 분리하기
df['연월일'] = df['연월일'].astype('str')   # 문자열 메소드 사용을 자료형 변경
print(df.head(), '\n')
dates = df['연월일'].str.split('-')        # 문자열을 split() 메서드로 분리
print(dates.head(), '\n')

# 분리된 정보를 각각 새로운 열에 담아서 df에 추가하기
df['연'] = dates.str.get(0)     # dates 변수의 원소 리스트의 0번째 인덱스 값
df['월'] = dates.str.get(1)     # dates 변수의 원소 리스트의 1번째 인덱스 값 
df['일'] = dates.str.get(2)     # dates 변수의 원소 리스트의 2번째 인덱스 값
print(df.head())
```

- `sr.srt.get(인덱스)` : 시리즈 객체의 문자열 리스트 인덱싱



## 3. 필터링

> 데이터 중 특정 조건식을 만족하는 원소만 따로 추출하는 개념

### 3-1 불린 인덱싱

- 시리즈, 데이터프레임의 열에 어떤 조건식을 적용하면 참/거짓을 판별하여 불린(참/거짓) 값으로 구성된 시리즈 리턴

```
데이터프레임의 불린 인덱싱 : df[불린 시리즈]
```

##### 예시

```python
# 예제 6-9
import seaborn as sns

# titanic 데이터셋 로딩
titanic = sns.load_dataset('titanic')

# 나이가 10대(10~19세)인 승객만 따로 선택
mask1 = (titanic.age >= 10) & (titanic.age < 20)
df_teenage = titanic.loc[mask1, :]
print(df_teenage.head())
print('\n')

# 나이가 10세 미만(0~9세)이고 여성인 승객만 따로 선택
mask2 = (titanic.age < 10) & (titanic.sex == 'female')
df_female_under10 = titanic.loc[mask2, :]
print(df_female_under10.head())
print('\n')

# 나이가 10세 미만(0~9세) 또는 60세 이상인 승객의 age, sex, alone 열만 선택
mask3 = (titanic.age < 10) | (titanic.age >= 60)
df_under10_morethan60 = titanic.loc[mask3, ['age', 'sex', 'alone']]
print(df_under10_morethan60.head())
```



### 3-2 isin() 메소드 활용

- isin() 메소드를 통해 특정 값을 가진 행들을 따로 추출
- isin() 메소드에 데이터프레임의 열에서 추출한 값들로 만든 리스트를 전달

```
isin() 메소드를 활용한 필터링 : df의 열 객체.isin(추출 값의 리스트)
```

##### 예시

```python
# 예제 6-10
import seaborn as sns
import pandas as pd

# titanic 데이터셋 로딩
titanic = sns.load_dataset('titanic')

# IPyhton 디스플레이 설정 변경 - 출력할 최대 열의 개수
pd.set_option('display.max_columns', 10)  
    
# 함께 탑승한 형제 또는 배우자의 수가 3, 4, 5인 승객만 따로 추출 - 불린 인덱싱
mask3 = titanic['sibsp'] == 3
mask4 = titanic['sibsp'] == 4
mask5 = titanic['sibsp'] == 5
df_boolean = titanic[mask3 | mask4 | mask5]
print(df_boolean.head())
print('\n')

# isin() 메서드 활용하여 동일한 조건으로 추출
isin_filter = titanic['sibsp'].isin([3, 4, 5])
df_isin = titanic[isin_filter]
print(df_isin.head())
```



### exam9.ipynp `filter`부분 살펴보기!!



## 4. 데이터프레임 합치기

> concat(), merge(), join() 등

### 4-1 데이터프레임 연결

- `pd.concat(데이터프레임의 리스트)` : 서로 다른 데이터프레임을 행 또는 열 방향으로 이어붙임
  - 구성형태와 속성이 동일해야함

- **axis=0**(기본 옵션) : 행으로(위 아래로) 연결
- **join='outer'**(기본 옵션) : 데이터프레임들을 합연산 한 것과 동일
  - 'inner' : 교집합 기준
  - 'left' : 왼쪽 데이터프레임의 키 열에 속하는 데이터 값을 기준
  - 'right' : 오른쪽 데이터프레임의 키 열에 속하는 데이터 값을 기준
- **ignore_index=True** : 기존 행 인덱스를 무시하고 새롭게 설정



### 4-2 데이터프레임 병합

- `pd.merge(df_left, df_right, how='inner', on=None)` : sql의 join과 유사
  - 병합의 기준이 되는 열이나 인덱스를 키라고 함
- 키는 반드시 양쪽 데이터프레임에 있어야 함
- **on** 옵션 : 병합의 기준이 될 열을 설정
  - 기본값은 None : 양쪽의 공통으로 존재하는 모든 열을 기준
- how='inner' or 'outer'
  - inner : 양쪽 데이터프레임의 교집합일 경우 추출
  - outer : 기준이 되는 on옵션에 따라 기준 데이터가 데이터프레임 중 어느 한쪽에만 속하더라도 포함
    - 데이터가 없는 경우에는 NaN



### 4-3 데이터프레임 결합

- `join()` 메소드 사용
  - merge() 함수를 기반으로 만들어져 기본 작동 방식이 비슷
- join() 메소드는 두 데이터프레이므이 행 인덱스를 기준으로 결합하는 점에서 merge()와 다름
- 하지만 **on=keys** 옵션으로 행 인덱스가 아닌 열을 기준으로 결합할 수 있다.

- **how=left** 옵션이 기본값
  - right, inner, outer



## 5. 그룹 연산

> 복잡한 데이터는 어떤 기준에 따라 여러 그룹으로 나워서 관찰하는 것도 좋은 방법이다.

### 5-1 그룹 객체 만들기(분할 단계)

- `groupby(기준 열)` : 열을 기준으로 데이터프레임을 분할하여 그룹 객체를 반환
  - 기준 열은 1개도 가능하고, 여러 열을 리스트로 입력할 수 있다.

```python
import pandas as pd
import numpy as np
df = pd.DataFrame({
    'city': ['부산', '부산', '부산', '부산', '서울', '서울', '서울'],
    'fruits': ['apple', 'orange', 'banana', 'banana', 'apple', 'apple', 'banana'],
    'price': [100, 200, 250, 300, 150, 200, 400],
    'quantity': [1, 2, 3, 4, 5, 6, 7]
})
# 부산과 서울로 나위어 연산
df.groupby('city')
df.groupby('city').mean()
df.groupby('city').agg('mean')
df.groupby('city').transform('mean') # 부산에 속하면 부산의 평균이 행마다 출력
df.groupby('city').agg(['mean', 'max', 'min'])

df.groupby(['city', 'fruits']).mean()
df.groupby(['fruits', 'city']).mean()
df.groupby('city').get_group('부산')
df.groupby(['city', 'fruits']).get_group(('부산', 'orange'))

df.groupby('city').size()
df.groupby('city').size()['부산']
df.groupby('city').count()

len(df.groupby('city')) # 2
len(df.groupby(['city', 'fruits'])) # 5
```



### 5-2 그룹 연산 메소드(적용-결합 단계)

- `group.std()` : 각 그룹의 표준편차 집계
  - mean(), max(), min(), sum(), count(), size(), var(), std(), describe(), info(), first(), last() 등 기본 집계 합수

- `group.agg(매핑 함수)` : 사용자 정의 함수를 그룹 객체에 적용

- `group.agg([함수1, 함수2, 함수3, ...])` : 모든 열에 여러 함수 매핑

- `group.agg({'열1' : 함수1, '열2' : 함수2, ...})` : 각 열마다 다른 함수 매핑

- `group.transform(매핑 함수)` : 그룹별로 구분하여 각 원소에 함수를 적용하지만 그룹별 집계가 아닌 각 원소의 본래 행 인덱스와 열 이름을 기준으로 연산 결과 리턴

- `group.filter(조건식 함수)` : 조건식을 만족하는 그룹만 남김

- `group.apply(매핑 함수)` : 객체의 개별 원소를 특정 함수에 일대일로 매핑



## 6. 멀티 인덱스

> 그룹 객체를 만들 때 이미 봤었음

- groupby() 메소드에 여러 열을 리스트 형태로 전달하면 각 열들이 다중으로 행 인덱스를 구성

```python
# 예제 6-19
import pandas as pd
import seaborn as sns

# titanic 데이터셋에서 age, sex 등 5개 열을 선택하여 데이터프레임 만들기
titanic = sns.load_dataset('titanic')
df = titanic.loc[:, ['age','sex', 'class', 'fare', 'survived']]

# class 열, sex 열을 기준으로 분할
grouped = df.groupby(['class', 'sex']) 
print(type(grouped)) # 10-26추가함

# 그룹 객체에 연산 메서드 적용
gdf = grouped.mean()
print(gdf)
print(type(gdf))
print(gdf.index)

# class 값이 First인 행을 선택하여 출력
print(gdf.loc['First'])

# class 값이 First이고, sex 값이 female인 행을 선택하여 출력
print(gdf.loc[('First', 'female')])

# sex 값이 male인 행을 선택하여 출력
print(gdf.xs('male', level='sex'))
```



## 7. 피벗

- `pivot_table()` 함수는 엑셀에서 사용하는 피벗테이블과 비슷한 기능을 처리한다.
- 피벗테이블을 구성하는 4가지 요소(**행 인덱스, 열 인덱스, 데이터 값, 데이터 집계 함수**)에 적용할 데이터프레임의 열을 각각 지정하여 함수의 인자로 전달

```python
# 예제 6-20
# 라이브러리 불러오기
import pandas as pd
import seaborn as sns

# IPyhton 디스플레이 설정 변경 
pd.set_option('display.max_columns', 10)    # 출력할 최대 열의 개수
pd.set_option('display.max_colwidth', 20)    # 출력할 열의 너비

# titanic 데이터셋에서 age, sex 등 5개 열을 선택하여 데이터프레임 만들기
titanic = sns.load_dataset('titanic')
df = titanic.loc[:, ['age','sex', 'class', 'fare', 'survived']]
print(df.head())
print('\n')

# 행, 열, 값, 집계에 사용할 열을 1개씩 지정 - 평균 집계
pdf1 = pd.pivot_table(df,              # 피벗할 데이터프레임
                     index='class',    # 행 위치에 들어갈 열
                     columns='sex',    # 열 위치에 들어갈 열
                     values='age',     # 데이터로 사용할 열
                     aggfunc='mean')   # 데이터 집계 함수

print(pdf1.head())
print('\n')

# 행, 열, 값에 사용할 열을 2개 이상 지정 가능 - 평균 나이, 최대 요금 집계
pdf3 = pd.pivot_table(df,                       # 피벗할 데이터프레임
                     index=['class', 'sex'],    # 행 위치에 들어갈 열
                     columns='survived',        # 열 위치에 들어갈 열
                     values=['age', 'fare'],    # 데이터로 사용할 열
                     aggfunc=['mean', 'max'])   # 데이터 집계 함수

# IPython Console 디스플레이 옵션 설정
pd.set_option('display.max_columns', 10)        # 출력할 열의 개수 한도
print(pdf3.head())
print('\n')

# 행, 열 구조 살펴보기
print(pdf3.index)
print(pdf3.columns)
print('\n')

# xs 인덱서 사용 - 행 선택(default: axis=0)
print(pdf3.xs('First'))              # 행 인덱스가 First인 행을 선택 
print('\n')
print(pdf3.xs(('First', 'female')))   # 행 인덱스가 ('First', 'female')인 행을 선택
print('\n')
print(pdf3.xs('male', level='sex'))  # 행 인덱스의 sex 레벨이 male인 행을 선택
print('\n')
print(pdf3.xs(('Second', 'male'), level=[0, 'sex']))  # Second, male인 행을 선택
print('\n')

# xs 인덱서 사용 - 열 선택(axis=1 설정)
print(pdf3.xs('mean', axis=1))        # 열 인덱스가 mean인 데이터를 선택 
print('\n')
print(pdf3.xs(('mean', 'age'), axis=1))   # 열 인덱스가 ('mean', 'age')인 데이터 선택
print('\n')
print(pdf3.xs(1, level='survived', axis=1))  # survived 레벨이 1인 데이터 선택
print('\n')
print(pdf3.xs(('max', 'fare', 0), 
              level=[0, 1, 2], axis=1))  # max, fare, survived=0인 데이터 선택
```



### seaborn 라이브러리를 이용한 시각화

> heatmap

```python
sns.heatmap(pdf1, annot=True) # annot=annotation
sns.heatmap(pdf2, annot=True, cmap="PuRd") # cmap = colormap
sns.heatmap(pdf3, annot=True, fmt='.1f') # fmt = format
```

- annot=True : 각 cell의 값 표기 유무
- cmap="PuRd" : 색을 설정
- fmt='.1f' : 값의 데이터 타입 설정(소수점 1자리까지 표현)