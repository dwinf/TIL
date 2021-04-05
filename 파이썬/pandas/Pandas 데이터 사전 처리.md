# Pandas 데이터 사전 처리

[TOC]

## 1. 누락 데이터 처리

> 결측치 처리

- 데이터를 파일로 입력할때 빠트리거나 파일 형식을 변환하는 과정에서 데이터 값이 소실되는 경우
  - 일반적으로 누락 데이터를 NaN(Not a Number)으로 표시
- 머신러닝 분석 모형에 데이터를 입력하기 전에 반드시 누락 데이터를 제거하거나 적절한 값으로 대체해야 함
  - 누락 데이터가 많으면 데이터의 품질이 떨어지고, 머신러닝 분석 알고리즘을 왜곡
- 결측치가 너무 많은 변수(컬럼)은 제거하는 것이 좋을 수 있다.



### 누락 데이터 확인

> seaborn 라이브러리의 'titanic' 데이터셋을 사용

```python
# 예제 5-1
import seaborn as sns

# titanic 데이터셋 가져오기
df = sns.load_dataset('titanic')
```



##### (1) info()

- `info()` 메소드로 데이터프레임의 요약 정보를 출력하면 각 열의 데이터 중에서 유효한 값의 개수를 보여줌
  - NaN 제외
  - 각 데이터의 데이터 타입도 알려줌
- **전체 데이터 개수 중 유효한 데이터 수를 파악하여 누락 데이터를 확인**
  - 유효한 값 = non null

```python
df.info()
# 15개 변수의 891개의 데이터 중 11번째 변수인 deck의 누락 데이터는 688(891-203)개

# RangeIndex: 891 entries, 0 to 890
# Data columns (total 15 columns):
# 11  deck         203 non-null    category
```



##### (2) value_counts()

- `value_counts()` 메소드는 유일한 값별 개수를 파악
- **dropna=False** 옵션을 사용해야 NaN 값의 개수를 파악할 수 있음
  - 기본적으로 유효한 데이터의 개수만 구하기 때문

```python
nan_deck = df['deck'].value_counts(dropna=False) 
print(nan_deck)
# NaN    688
# C       59
# B       47
# ...
# Name: deck, dtype: int64
```



##### (3) 누락 데이터를 직접 탐색

- `isnull()` : 누락 데이터면 True 리턴, 유효한 데이터가 존재하면 False 리턴
- `notnull()` : 누락 데이터면 False 리턴, 유효한 데이터가 존재하면 True 리턴

```python
print(df.isnull())
print(df.notnull())
```

- 누락데이터의 개수 확인
  - sum 함수를 통해 True의 개수 파악

```python
# isnull() 메서드로 누락 데이터 개수 구하기
print(df.isnull().sum(axis=0))
```



### 누락 데이터 제거

- 열을 삭제하면 분석 대상이 갖는 특성(변수)를 제거
- 행을 삭제하면 분석 대상의 관측값(레코드)을 제거

![dropna](https://user-images.githubusercontent.com/73389275/113508279-1e38da80-958a-11eb-9081-d5f15473d155.jpg)

- `dropna()` : 누락 데이터(결측치)가 있는 행 또는 열 제거
  - **axis를** 통해 행인지, 열인지 결정
  - **thresh** 옵션을 통행 n개 이상의 누락 데이터를 가진 데이터만 제거
    - thresh=500 : 누락 데이터가 500개 이상일 때 제거
  - **how** 옵션을 삭제할 조건 부여
    - how='any' : 누락 데이터가 하나라도 존재한다면 삭제
    - how='all' : 모든 데이터가 누락 데이터라면 삭제
  - **subset**을 통해 원하는 변수의 누락 데이터만 제거할 수 있음
    - 지정된 열이 데이터 분석에 중요하다면 누락 데이터가 있는 행의 모든 데이터를 제거하는 것이 좋음



#### 1. 누락 데이터 확인

```python
# 예제 5-2
import seaborn as sns

# titanic 데이터셋 가져오기
df = sns.load_dataset('titanic')

# for 반복문으로 각 열의 NaN 개수 계산하기
missing_df = df.isnull()
print(missing_df)

for col in missing_df.columns:
    missing_count = missing_df[col].value_counts()    # 각 열의 NaN 개수 파악
    try: 
        print(col, ': ', missing_count[True])   # NaN 값이 있으면 개수를 출력
    except:
        print(col, ': ', 0)                     # NaN 값이 없으면 0개 출력
```

#### 2. 누락 데이터 제거

```python
# NaN 값이 500개 이상인 열을 모두 삭제 - deck 열(891개 중 688개의 NaN 값)
df_thresh = df.dropna(axis=1, thresh=500)  
print(df_thresh.columns)

# age 열에 나이 데이터가 없는 모든 행을 삭제 - age 열(891개 중 177개의 NaN 값)
df_age = df.dropna(subset=['age'], how='any', axis=0)  
print(len(df_age)) # 714
```



### 누락 데이터 치환

- 누락된 데이터가 존재하는 행을 제거하지 않고 다른 데이터로 치환
  - ex) 평균값, 최빈값, 이전 행의 값, 최소값 등

- `fillna()` 메소드를 통해 누락 데이터 치환
  - 메소드의 결과로 새로운 객체를 반환하기 때문에 원본을 변경하려면 **inplace=True** 옵션 추가
  - `method='ffill'` : NaN이 있는 행의 직전 행에 있는 값으로 치환
  - `method='bfill'` : NaN이 있는 행의 다음 행에 있는 값으로 치환

#### 평균으로 치환

```python
# 예제 5-3
import seaborn as sns

# titanic 데이터셋 가져오기
df = sns.load_dataset('titanic')

# age 열의 첫 10개 데이터 출력 (5 행에 NaN 값)
print(df['age'].head(10))
print('\n')

# age 열의 NaN값을 다른 나이 데이터의 평균으로 변경하기
mean_age = df['age'].mean(axis=0)   # age 열의 평균 계산 (NaN 값 제외)
df['age'].fillna(mean_age, inplace=True)

# age 열의 첫 10개 데이터 출력 (5 행에 NaN 값이 평균으로 대체)
print(df['age'].head(10))
```

#### 최빈값으로 치환

```python
# 예제 5-4
import seaborn as sns

# titanic 데이터셋 가져오기
df = sns.load_dataset('titanic')

# embark_town 열의 829행의 NaN 데이터 출력
print(df['embark_town'][825:830])

df['embark_town'].value_counts(dropna=True)

# embark_town 열의 NaN값을 승선도시 중에서 가장 많이 출현한 값으로 치환하기
most_freq = df['embark_town'].value_counts(dropna=True).idxmax()   
print(most_freq)

df['embark_town'].fillna(most_freq, inplace=True)

# embark_town 열 829행의 NaN 데이터 출력 (NaN 값이 most_freq 값으로 대체)
print(df['embark_town'][825:830])
```

- **idxmax()** : 가장 값이 큰 인덱스 명을 리턴

#### 이웃하고 있는 값으로 치환

```python
# 예제 5-5
import seaborn as sns

# titanic 데이터셋 가져오기
df = sns.load_dataset('titanic')

# embark_town 열의 829행의 NaN 데이터 출력
print(df['embark_town'][825:830])

# embark_town 열의 NaN값을 바로 앞에 있는 828행의 값으로 변경하기
df['embark_town'].fillna(method='ffill', inplace=True)
print(df['embark_town'][825:830])
```

#### 

## 2. 중복 데이터 처리

### 중복 데이터 확인

- `duplicated()` 함수 이용
- 전에 나온 행들과 비교하여 **중복이면 True** 아니면 False 리턴
  - 처음 나오는 행은 무조건 False

#### Ex

```python
# 예제 5-6
import pandas as pd

# 중복 데이터를 갖는 데이터프레임 만들기
df = pd.DataFrame({'c1':['a', 'a', 'b', 'a', 'b'],
                  'c2':[1, 1, 1, 2, 2],
                  'c3':[1, 1, 2, 2, 2]})
print(df)

# 데이터프레임 전체 행 데이터 중에서 중복값 찾기
df_dup = df.duplicated()
print(df_dup)

# 데이터프레임의 특정 열 데이터에서 중복값 찾기
col_dup = df['c2'].duplicated()
print(col_dup)
```



### 중복 데이터 제거

- `drop_duplicates()` 함수 이용
- 중복되는 행을 제거해 고유한 값을 가진 행만 남김
- 새로운 객체를 리턴하기 때문에 inplace=True 사용

#### Ex

```python
# 예제 5-7
import pandas as pd

# 중복 데이터를 갖는 데이터프레임 만들기
df = pd.DataFrame({'c1':['a', 'a', 'b', 'a', 'b'],
                  'c2':[1, 1, 1, 2, 2],
                  'c3':[1, 1, 2, 2, 2]})
print(df)

# 데이터프레임에서 중복 행을 제거
df2 = df.drop_duplicates()
print(df2)

# c2, c3열을 기준으로 중복 행을 제거
df3 = df.drop_duplicates(subset=['c2', 'c3'])
print(df3)
```



## 3. 데이터 변환

- 단위 선택, 대소문자 구분, 약칭 등 다양한 형태로 표현
- 동일한 대상을 다르게 표현할 경우 분석의 정확도가 떨어질 수 있기 때문에 변환해줄 필요가 있다.

- auto-mpg.csv를 통해 알아봄



### 3-1 단위 환산

- mpg의 경우 mile per gallon으로 한국에서는 쓰지 않는 단위
  - 한국에서 쓰는 단위로 바꿔줄 필요가 있음(km/L)



### 3-2 자료형 변환

- housepower의 경우 엔진 출력의 크기를 나타내기 때문에 숫자형이 적절
  - 데이터 중간 '? '값 때문에 문자열로 인식됨
  - **np.nan**으로 누락 데이터를 nan으로 변경
  - **astype()**으로 타입 변환

```python
import numpy as np
df['horsepower'].replace('?', np.nan, inplace=True)      # '?'을 np.nan으로 변경
df.dropna(subset=['horsepower'], axis=0, inplace=True)   # 누락데이터 행을 삭제
df['horsepower'] = df['horsepower'].astype('float')      # 문자열을 실수형으로 변환
```

- origin의 경우 국가를 나타내지만 1, 2, 3으로 정수형 데이터로 이루어짐
  - 국가 이름으로 바꿔주는 것이 적절
  - 3개의 국가을 고유값으로 반복하기 때문에 문자열보다 범주형(category)이 적절

```python
# origin 열의 고유값 확인
print(df['origin'].unique())
# 정수형 데이터를 문자형 데이터로 변환 
df['origin'].replace({1:'USA', 2:'EU', 3:'JAPAN'}, inplace=True)

# origin 열의 고유값과 자료형 확인
print(df['origin'].unique())
print(df['origin'].dtypes) 
print('\n')
```



## 4. 범주형(카테고리) 데이터 처리

### 4-1 구간 분할

- 데이터 분석 알고리즘에 따라서 연속 데이터를 그대로 사용하기 보다는 일정한 구간으로 나눠서 분석하는 것이 효율적인 경우가 있음
- **구간 분할** : 연속 변수를 일정한 구간으로 나누고, 각 구간을 범주형 이산 변수로 변환하는 과정
- 판다스 함수 `cut()`을 이용해 연속 데이터를 여러 구간으로 나누고 범주형 데이터로 변환 가능

```python
bin_drivers = np.histogram(df['열 이름'], bins=3)
bin_names = ['범주1', '범주2', '범주3'] # 원하는 이름으로 지정
df['새로운 열'] = pd.cut(x=df['열 이름'], # 데이터 배열
				   bins=bin_drivers, # 경계값 리스트
				   labels=bin_names, # bin 이름
				   include_lowest=True) # 첫 경계값 포함
```



### 4-2 더미 변수

- 카테고리를 나타내는 범주형 데이터를 회귀분석 등 머신러닝 알고리즘에 바로 사용할 수 없을 수 있음
- 컴퓨터가 인식 가능한 입력값으로 변환해야 함
- 이럴 때 숫자 0 또는 1로 표현되는 **더미 변수**를 사용함.
  - 0과 1은 어떤 특성이 있는지 없는지 여부만을 표시함
- `get_dummies()` 함수 사용
  - 범주형 변수의 모든 고유값을 각각 새로운 더미 변수로 변환
  - 각 더미 변수가 본래 속해 있던 행에는 `1`, 속하지 않았던 다른 행에는 `0`이 입력됨

```python
bin_drivers = np.histogram(df['열이름'], bins=3)
bin_names = ['범주1', '범주2', '범주3'] # 원하는 이름으로 지정
df['새로추가열'] = pd.cut(x=df['열이름'], # 데이터 배열
				   bins=bin_drivers, # 경계값 리스트
				   labels=bin_names, # bin 이름
				   include_lowest=True) # 첫 경계값 포함
dummis = pd.gt_dummies(df['새로추가열'])
```



## 5. 정규화

- 각 변수에 들어있는 숫자 데이터의 상대적 크기 차이 때문에 머신러닝 분석 결과가 달라질 수 있음
  - 상대적으로 큰 값을 가지는 변수가 더 큰 영향력을 가진다.
- 따라서 숫자 데이터의 상재덕인 크기 차이를 제거할 필요가 있음
- **정규화** : 각 열(변수)에 속하는 데이터 값을 동일한 크기 기준으로 나눈 비율로 나타내는 것
  - **0~1** 또는 **-1 ~ 1**

#### 정규화 방법 1

- 각 열의 데이터를 해당 열의 최대값으로 나누는 방법
  - 0 이상 1 이하

```python
# horsepower 열의 최대값의 절대값으로 모든 데이터를 나눠서 저장
f.horsepower = df.horsepower / abs(df.horsepower.max()) 
```

#### 정규화 방법 2

- 각 열의 데이터 중 최대값과 최소값을 뺀 값으로 나누는 방법

```python
# horsepower 열의 최대값의 절대값으로 모든 데이터를 나눠서 저장
min_x = df.horsepower - df.horsepower.min()
min_max = df.horsepower.max() - df.horsepower.min()
df.horsepower = min_x / min_max
```



## 6. 시계열 데이터 처리



### 6-1 다른 자료형을 시계열 객체로 변환



### 6-2 시계열 데이터 만들기

#### Timestamp 배열

- `date_range()` 함수를 사용해 여러 개의 날짜(Timestamp)가 들어 있는 배열 형태의 시계열 데이터 생성
- 파이썬의 `range()` 로 숫자 배열을 만드는 함수와 유사

```python
# 예제 5-17
import pandas as pd

# Timestamp의 배열 만들기 - 월 간격, 월의 시작일 기준
ts_ms = pd.date_range(start='2019-01-01',    # 날짜 범위의 시작
                   end=None,                 # 날짜 범위의 끝
                   periods=6,                # 생성할 Timestamp의 개수
                   freq='MS',                # 시간 간격 (MS: 월의 시작일)
                   tz='Asia/Seoul')          # 시간대(timezone)
print(ts_ms)
```

```python
freq='MS',                	# 시간 간격 (MS: 월의 시작일)
freq='M',              		# 시간 간격 (M: 월의 마지막 날)
freq='3M',            	 	# 시간 간격 (3M: 3개월)
freq='H'                   	# 기간의 길이 (H: 시간)
freq='2H'                  	# 기간의 길이 (H: 시간)
```

#### period 배열

- 



### 6-3 시계열 데이터 활용

#### 날짜 데이터 분리

- `to_datetime()` 함수를 사용해 Timestamp로 변환된 데이터프레임에서 연, 월, 일 정보 추출

```python
# 예제 5-19
import pandas as pd

# read_csv() 함수로 파일 읽어와서 df로 변환
df = pd.read_csv('data/stock-data.csv')

# 문자열인 날짜 데이터를 판다스 Timestamp로 변환
df['new_Date'] = pd.to_datetime(df['Date'])   #df에 새로운 열로 추가
print(df.head())

# dt 속성을 이용하여 new_Date 열의 년월일 정보를 년, 월, 일로 구분
df['Year'] = df['new_Date'].dt.year
df['Month'] = df['new_Date'].dt.month
df['Day'] = df['new_Date'].dt.day
print(df.head())
print(type(df['new_Date'][0]))
print(df['new_Date'].dt)


# Timestamp를 Period로 변환하여 년월일 표기 변경하기
df['Date_yr'] = df['new_Date'].dt.to_period(freq='A')
df['Date_m'] = df['new_Date'].dt.to_period(freq='M')
print(df.head())

# 원하는 열을 새로운 행 인덱스로 지정
df.set_index('Date_m', inplace=True)
print(df.head())
```

### 

#### 날짜 인덱스 활용

- Timestamp로 구성된 열을 행 인덱스로 지정하면 DatetimeIndex라는 고유 속성으로 변환
- Period로 구성된 열을 행 인덱스로 지정하면 PeriodIndex라는 고유 속성으로 변환



```python
# 예제 5-20
# 라이브러리 불러오기
import pandas as pd

# read_csv() 함수로 파일 읽어와서 df로 변환
df = pd.read_csv('data/stock-data.csv')

# 문자열인 날짜 데이터를 판다스 Timestamp로 변환
df['new_Date'] = pd.to_datetime(df['Date'])   # 새로운 열에 추가
df.set_index('new_Date', inplace=True)        # 행 인덱스로 지정

print(df.head())
print('\n')
print(df.index)
print('\n')

# 날짜 인덱스를 이용하여 데이터 선택하기
df_y = df.loc['2018']
print(df_y.head())
print('\n')
df_ym = df.loc['2018-07']    # loc 인덱서 활용
print(df_ym)
print('\n')
df_ym_cols = df.loc['2018-07-02', 'Start':'High']    # 열 범위 슬라이싱
print(df_ym_cols)
print('\n')
df_ymd = df.loc['2018-07-02']
print(df_ymd)
print('\n')
df_ymd_range = df['2018-06-25':'2018-06-20']    # 날짜 범위 지정
print(df_ymd_range)
print('\n')

# 시간 간격 계산. 최근 180일 ~ 189일 사이의 값들만 선택하기
today = pd.to_datetime('2018-12-25')            # 기준일 생성
df['time_delta'] = today - df.index             # 날짜 차이 계산
df.set_index('time_delta', inplace=True)        # 행 인덱스로 지정
df_180 = df['180 days':'189 days']
print(df_180)
```

