# Pandas 데이터프레임의 다양한 응용

> part 6



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



### exam9.ipynp filter부분 살펴보기!!



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







## 5. 그룹 연산

### 5-1 그룹 객체 만들기(분할 단계)



### 5-2 그룹 연산 메소드(적용-결합 단계)





## 6. 멀티 인덱스





## 7. 피벗