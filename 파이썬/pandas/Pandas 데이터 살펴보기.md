# Pandas 데이터 살펴보기

## 1. 데이터프레임의 구조

> 데이터프레임은 파이썬 클래스로 만들어진다. 데이터프레임 클래스에는 데이터프레임의 크기, 데이터 구성 항목, 자료형, 통계 수치 등 여러 정보를 확인할 수 있는 속성과 메소드가 포함된다.

### 1-1 데이터 내용 미리보기

- `head()` 메소드 인자로 정수 n을 전달하면 처음 n개의 행을 보여줌
  - 디폴트 : 5
- `tail()` 메소드 인자로 정수 n을 전달하면 마지막 n개의 행을 보여줌
  - 디폴트 : 5

```python
df.head(n)
df.tail(n)
```



### 1-2 데이터 요약 정보 확인하기

#### (1) 데이터프레임의 크기(행, 열)

- `shape()` : 데이터프레임의 행과 열을 투플 형태로 보여줌

- ```python
  print(df.shape()) # (n, m)
  ```



#### (2) 데이터프레임의 기본 정보

- `info()` : 데이터프레임에 관한 기본 정보를 출력

  - 클래스, 행 인덱스, 열 이름과 타입 등 정보 출력

- ```python
  print(df.info())
  ```



#### (3) 데이터프레임의 기술 통계 정보 요약

- `describe()` : 산술 데이터(int64, float64)를 갖는 열에 대한 주요 기술 통계 정보를 요약하려 출력

  - 평균, 표준편차, 최대값, 최소값, 중간값 등

- `include='all'` 옵션 : 문자열 데이터를 갖는 열의 unique(고유값 개수), top(최빈값), freq(빈도수) 정보 추가

- ```python
  print(df.describe())
  print(df.describe(include='all'))
  ```



### 1-3 데이터 개수 확인하기

#### (1) 각 열의 데이터 개수

- `count()` : 각 열이 가지는 데이터의 개수를 시리즈 객체로 반환

  - 유효한 값의 개수만 계산

- ```python
  print(df.count())
  ```



#### (2) 각 열의 고유값 개수

- `value_counts()` : 시리즈 객체의 고유값 개수를 세는 데 사용

  - dropna=True : NaN을 제외하고 개수를 계산(False가 기본값)

- ```python
  print(df.value_counts())
  ```



## 2. 통계 함수 적용

#### (1) 평균값

- `mean()` : 산술 데이터를 갖는 모든 열의 평균값을 계산하여 시리즈로 반환

- ```python
  print(df.mean())
  print(df['mpg'].mean())
  print(df.mpg.mean())
  print(df[['mpg', 'weight']].mean())
  ```



#### (2) 중간값

- `median()` : 산술 데이터를 갖는 모든 열의 중간값을 계산하여 시리즈로 반환

- ```python
  print(df.median())
  print(df['mpg'].median())
  ```



#### (3) 최대값

- `max()` : 각 열이 갖는 데이터 값 중 최대값을 계산하여 시리즈로 반환

  - 문자열은 ASCII 숫자로 변환하여 크고 작음을 비교

- ```python
  print(df.max())
  print(df['mpg'].max())
  ```



#### (4) 최소값

- `min()` : 각 열이 갖는 데이터 값 중 최소값을 계산하여 시리즈로 반환

  - 문자열은 ASCII 숫자로 변환하여 크고 작음을 비교

- ```python
  print(df.min())
  print(df['mpg'].min())
  ```



#### (5) 표준편차

- `std()` : 산술 데이터를 갖는 열의 표준편차를 계산하여 시리즈로 반환

- 산술 데이터를 갖는 모든 열에 대하여 2개씩 서로 짝을 짓고, 각각의 경우에 대하여 상관계수를 계산

- ```python
  print(df.std())
  print(df['mpg'].std())
  ```



#### (6) 상관계수

- `corr()` : 두 열 간의 상관계수를 계산

- 산술 데이터를 갖는 모든 열에 대하여 2개씩 서로 짝을 짓고, 각각의 경우에 대하여 상관계수를 계산

- ```python
  print(df.corr())
  print(df[['mpg', 'weri']].corr())
  ```



## 3. 판다스 내장 그래프 도구 활용

| kind 옵션 | 설명              | kind 옵션 | 설명                 |
| --------- | ----------------- | --------- | -------------------- |
| 'line'    | 선 그래프(기본값) | 'kde'     | 커널 밀도 그래프     |
| 'bar'     | 수직 막대 그래프  | 'area'    | 면적 그래프          |
| 'barh'    | 수평 막대 그래프  | 'pie'     | 파이 그래프          |
| 'his'     | 히스토그램        | 'scatter' | 산점도 그래프        |
| 'box'     | 박스 플롯         | 'hexbin'  | 고밀도 산점도 그래프 |

```python
df.plot() # kind='line' 옵션과 동일
df.plot(kind='line')
df.plot(kind='bar')
df.plot(kind='barh')
```


