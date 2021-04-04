# Pandas 시각화 도구

## 1. Matplotlib 

> 기본 그래프 도구

- 기본적으로 한글폰트를 제공하지 않기 때문에 한글을 쓰기 위해서는 폰트를 등록해야함

```python
from matplotlib import font_manager, rc
font_path = "data/THEdog.ttf"   #폰트파일의 위치
font_name = font_manager.FontProperties(fname=font_path).get_name()
print(font_name) # THEGaeideuk
rc('font', family=font_name)
```

- 실행 시 전역적으로 적용됨

```python
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
# %matplotlib inline 
# %config InlineBackend.figure_format='retina'
```

- `%matplotlib inline` : 현재 셀 아래에 그래프를 그림
  - 디폴트이기 때문에 굳이 수행하지 않아도 됨
- `%config InlineBackend.figure_format='retina'` : 해상도가 더 좋은 그래프를 그리기 위한 명령어
  - jupyter lab에서는 큰 차이 없음



### 1-1 그래프 작성

> plt.plot(*args, scalex=True, scaley=True, data=None, **kwargs)
>
> 기본은 선 그래프로 작성됨

#### 마커 모양

| character | description           | character | description      | character | description         |
| --------- | --------------------- | --------- | ---------------- | --------- | ------------------- |
| `'.'`     | point marker          | ``'2'``   | tri_up marker    | ``'+'``   | plus marker         |
| ``','``   | pixel marker          | ``'3'``   | tri_left marker  | ``'x'``   | x marker            |
| ``'o'``   | circle marker         | ``'4'``   | tri_right marker | ``'D'``   | diamond marker      |
| ``'v'``   | triangle_down marker  | ``'s'``   | square marker    | ``'d'``   | thin_diamond marker |
| ``'^'``   | triangle_up marker    | ``'p'``   | pentagon marker  | ``'|'``   | vline marker        |
| ``'<'``   | triangle_left marker  | ``'*'``   | star marker      | ``'_'``   | hline marker        |
| ``'>'``   | triangle_right marker | ``'h'``   | hexagon1 marker  |           |                     |
| ``'1'``   | tri_down marker       | ``'H'``   | hexagon2 marker  |           |                     |



#### 선 모양

| character | description         | character | description       |
| --------- | ------------------- | --------- | ----------------- |
| ``'-'``   | solid line style    | ``'--'``  | dashed line style |
| ``'-.'``  | dash-dot line style | ``':'``   | dotted line style |

```
Example format strings::

    'b'    # blue markers with default shape
    'or'   # red circles
    '-g'   # green solid line
    '--'   # dashed line with default color
    '^k:'  # black triangle_up markers connected by a dotted line
```



#### 색상

| character | description | character | description |
| --------- | ----------- | --------- | ----------- |
| ``'b'``   | blue        | ``'m'``   | magenta     |
| ``'g'``   | green       | ``'y'``   | yellow      |
| ``'r'``   | red         | ``'k'``   | black       |
| ``'c'``   | cyan        | ``'w'``   | white       |

- 색 이름이나 16진수 코드로도 지정 가능
  - ``'green'`` 또는 `'#008000'`



```python
plt.style.use('ggplot')
```

- 그래프를 ggplot 스타일로 생성
- 다양한 스타일로 생성 가능
- `'Solarize_Light2'`, `'_classic_test_patch'`, `'bmh'`, `'classic'`, `'dark_background'`, `'fast'`, `'fivethirtyeight'`, `'ggplot'`, `'grayscale'`, `'seaborn'`, `'seaborn-bright'`, `'seaborn-colorblind'`, `'seaborn-dark'`, `'seaborn-dark-palette'`, `'seaborn-darkgrid'`, `'seaborn-deep'`, `'seaborn-muted'`, `'seaborn-notebook'`, `'seaborn-paper'`, `'seaborn-pastel'`, `'seaborn-poster'`, `'seaborn-talk'`, `'seaborn-ticks'`, `'seaborn-white'`, `'seaborn-whitegrid'`, `'tableau-colorblind10'`



#### (1) 그래프 크기

```python
plt.figure(figsize=(10,6))
```

- 기본값은 (6, 4) inch
- 그래프를 그리기 전에 미리 설정해야 함



#### (2) 타이틀 작성

```python
plt.title("시리즈 데이터로 그리는 그래프")

plt.title('Sample graph', loc='right', pad=20)

title_font = {
    'fontsize': 16,
    'fontweight': 'bold'
}
plt.title('Sample graph', fontdict=title_font, loc='left', pad=20)
```

- 제목의 폰트 사이즈, 위치, 여백 등 지정 가능



#### (3) 축(label) 제목

```python
plt.ylabel('갯수')
plt.xlabel('학생이름')
```



#### (4) 축(label) 꾸미기

```python
ax = plt.gca()
ax.tick_params(axis='x', colors='blue')
ax.tick_params(axis='y', colors='red')
# 또는
plt.tick_params(axis='x', colors='blue')
plt.tick_params(axis='y', colors='red')
# 또는
plt.tick_params(axis='x', direction='in', length=3, pad=6, labelsize=14, labelcolor='green', top=True)
plt.tick_params(axis='y', direction='inout', length=10, pad=15, labelsize=12, width=2, color='r')
# 또는
plt.tick_params(axis='both', direction='in', length=3, pad=6, labelsize=14)
```



#### (5) 축 이름

```python
plt.xticks([0, 1, 2])
plt.yticks(np.arange(1, 6))
# 또는
plt.xticks(np.arange(0, 2.1, 0.2), labels=['Jan', '', 'Feb', '', 'Mar', '', 'May', '', 'June', '', 'July'])
plt.yticks(np.arange(0, 7), ('0', '1GB', '2GB', '3GB', '4GB', '5GB', '6GB'))
plt.xticks(rotation='vertical')
```

- x축과 y축이 만나는 지점이 0이 아님
- 축 범위까지 지정 가능
- `lotation` 옵션으로 글씨를 회전시킬 수 있다.
  - `vertical` : 수직
  - 각도를 나타내는 숫자를 입력해도 됨(`lotation=90`)



#### (6) 축 범위

```python
plt.ylim(-1.2, 1.2)
plt.xlim(0, np.pi)
```



#### (7) 범례(legend) 표시

```python
plt.legend(["a", "a**2", "a**3"], loc='upper center')
```

- `loc` 를 통해 출력될 위치 지정
  
- `upper` : 상단, `center` : 중앙, `right` : 우측, `left` : 좌측,  `lower` : 하단
  - `best` : 최적의 위치
  - 
  
- 그래프의 label이 지정되어 있지 않다면 출력되지 않음(축 제목X)

  - ```python
    plt.plot(t, np.sin(t), label='sin')
    plt.plot(t, np.cos(t), label='cos')
    plt.legend()
    plt.show()
    ```



#### (8) 그리드 표시

```python
plt.grid()
plt.grid(True, axis='y') # y축 그리드만 표시
plt.grid(True, axis='y', color='red', alpha=0.5, linestyle='--') # 선 모양과 색 변경
```



#### (9) 보조선 표시

```python
plt.axhline(1, 0, 0.55, color='gray', linestyle='--', linewidth='1')
plt.axvline(1, 0, 0.16, color='lightgray', linestyle=':', linewidth='2')

plt.axhline(5.83, 0, 0.95, color='gray', linestyle='--', linewidth='1')
plt.axvline(1.8, 0, 0.95, color='lightgray', linestyle=':', linewidth='2')
```



#### (10) 그래프 작성

```python
plt.bar(x=s.index, height=s, color=['skyblue', 'red', 'green', 'orange', 'yellow'])
plt.plot([1,2,3,4,5,6],[100,200,300,400,500,800], 'r+') # 빨간 '+' 마커로 된 점 그래프
plt.plot([1,2,3,4,5,6],[1,2,3,4,5,6], 'r--', [1,2,3,4,5,6],[3,4,5,6,7,8], 'gv-', [1,2,3,4,5,6],[5,6,7,8,9,10], 'm-.')
plt.plot(a, a, 'bo') # 파란색 원형 점 그래프
plt.plot(a, a**2, color='#e35f62', marker='*', linewidth=2)
plt.plot(a, a**3, color='springgreen', marker='^', markersize=9)
```

- x축, y축 데이터 지정
- 막대의 색상 지정



#### (11)그래프 주석

- `annotate()` 함수를 이용

```python
# 예제 4-7
import pandas as pd
import matplotlib.pyplot as plt

# Excel 데이터를 데이터프레임 변환 
df = pd.read_excel('data/시도별 전출입 인구수.xlsx', header=0)

# 전출지별에서 누락값(NaN)을 앞 데이터로 채움 (엑셀 양식 병합 부분)
df = df.fillna(method='ffill')

# 서울에서 다른 지역으로 이동한 데이터만 추출하여 정리
mask = (df['전출지별'] == '서울특별시') & (df['전입지별'] != '서울특별시') 
df_seoul = df[mask]
df_seoul = df_seoul.drop(['전출지별'], axis=1)
df_seoul.rename({'전입지별':'전입지'}, axis=1, inplace=True)
df_seoul.set_index('전입지', inplace=True)

# 서울에서 경기도로 이동한 인구 데이터 값만 선택
sr_one = df_seoul.loc['경기도']

# 스타일 서식 지정
plt.style.use('ggplot') 

# 그림 사이즈 늘리기
plt.figure(figsize=(14, 5))

# x축 눈금 라벨 회전하기
plt.xticks(size=10, rotation='vertical')

# x, y축 데이터를 plot 함수에 입력 
plt.plot(sr_one.index, sr_one.values, marker='o', markersize=10)  # 마커 표시 추가

plt.title('서울 -> 경기 인구 이동', size=30)  #차트 제목
plt.xlabel('기간', size=20)                  #x축 이름
plt.ylabel('이동 인구수', size=20)           #y축 이름

#범례 표시
plt.legend(labels=['서울 -> 경기'], loc='best', fontsize=15)

# y축 범위 지정 (최소값, 최대값)
plt.ylim(50000, 800000)

# 주석 표시 - 화살표
plt.annotate('',
             xy=(20, 620000),       #화살표의 머리 부분(끝점)
             xytext=(2, 290000),    #화살표의 꼬리 부분(시작점)
             xycoords='data',       #좌표체계
             arrowprops=dict(arrowstyle='->', color='skyblue', lw=5), #화살표 서식
             )

plt.annotate('',
             xy=(47, 450000),       #화살표의 머리 부분(끝점)
             xytext=(30, 580000),   #화살표의 꼬리 부분(시작점)
             xycoords='data',       #좌표체계
             arrowprops=dict(arrowstyle='->', color='olive', lw=5),  #화살표 서식
             )

# 주석 표시 - 텍스트
plt.annotate('인구이동 증가(1970-1995)',  #텍스트 입력
             xy=(10, 550000),            #텍스트 위치 기준점
             rotation=25,                #텍스트 회전각도
             va='baseline',              #텍스트 상하 정렬
             ha='center',                #텍스트 좌우 정렬
             fontsize=15,                #텍스트 크기
             )

plt.annotate('인구이동 감소(1995-2017)',  #텍스트 입력
             xy=(40, 560000),            #텍스트 위치 기준점
             rotation=-11,               #텍스트 회전각도
             va='baseline',              #텍스트 상하 정렬
             ha='center',                #텍스트 좌우 정렬
             fontsize=15,                #텍스트 크기
             )

plt.show()  # 변경사항 저장하고 그래프 출력
```





#### (12) 그래프 저장

```python
plt.savefig("test.png") 
```

- 반드시 show() 함수를 호출하기 전에 해야함



#### (13) 그래프 출력

```python
plt.show()
```

- 안해도 출력이 되지만, 객체 정보도 함께 출력하게 됨



### 1-0 한 셀에서 여러 그래프를 그릴 경우

```python
plt.title('matplotliab 그래프(5)')
plt.plot([1,2,3,4,5,6],[10,3,7,4,6,3])
plt.title('matplotliab 그래프(6)')
plt.plot([1,2,3,4,5,6],[10,3,7,4,6,3], 'r--', lw=7)
plt.show()
```

- 그래프5 위로 그래프 6이 덮어쓰기 됨



```python
plt.figure()
plt.title('matplotliab 그래프(5)')
plt.plot([1,2,3,4,5,6],[10,3,7,4,6,3])
plt.figure()
plt.title('matplotliab 그래프(6)')
plt.plot([1,2,3,4,5,6],[10,3,7,4,6,3], 'r--', lw=7)
plt.show()
```

- figure를 새로 만들어 여러 그래프를 그림



```python
plt.subplot(2,1,1)
plt.title('matplotliab 그래프(5)')
plt.plot([1,2,3,4,5,6],[10,3,7,4,6,3])
plt.subplot(2,1,2) # AxesSubplot 객체 리턴
plt.subplots_adjust(hspace=1) 
plt.title('matplotliab 그래프(6)')
plt.plot([1,2,3,4,5,6],[10,3,7,4,6,3], 'r--', lw=7)
plt.show()
```

- 그래프 사이에 여백



```python
plt.figure(figsize=(10,6))
# (10,6)의 공간을 2행 2열로 나눔
plt.subplot(2,2,1)
plt.subplot(2,2,2)
plt.subplot(2,2,3)
plt.subplot(2,2,4)
plt.show()
# , 구분을 안해도 무관
plt.subplot(221)
plt.subplot(222)
plt.subplot(223)
plt.subplot(224)
```

```python
fig, ax = plt.subplots(2, 2)

ax[0, 0].plot(x, y1)
ax[0, 1].plot(x, y2)
ax[1, 0].plot(x, y3)
ax[1, 1].plot(x,y4)

ax[0, 0].set_title("Sine function")
ax[0, 1].set_title("Cosine function")
ax[1, 0].set_title("Sigmoid function")
ax[1, 1].set_title("Exponential function")

plt.subplots_adjust(left=0.125,
                    bottom=0.1, 
                    right=0.9, 
                    top=0.9, 
                    wspace=0.2, 
                    hspace=0.9)

plt.show()
```



### 1-1 선 그래프

- 선 그래프는 연속하는 데이터 값들을 직선 또는 곡선으로 연결하여 데이터 값 사이의 관계를 나타냄
- 시계열 데이터와 같이 연속적인 값의 변화와 패턴을 파악하는데 적합하다.

#### 기본 사용법

```python
# 예제 4-1
import pandas as pd
import matplotlib.pyplot as plt

# Excel 데이터를 데이터프레임 변환 
df = pd.read_excel('data/시도별 전출입 인구수.xlsx', header=0)
#df.fillna(0, inplace=True)

# 누락값(NaN)을 앞 데이터로 채움 (엑셀 양식 병합 부분)
df = df.fillna(method='ffill')

# 서울에서 다른 지역으로 이동한 데이터만 추출하여 정리
mask = (df['전출지별'] == '서울특별시') & (df['전입지별'] != '서울특별시') 
df_seoul = df[mask]
df_seoul = df_seoul.drop(['전출지별'], axis=1)
df_seoul.rename({'전입지별':'전입지'}, axis=1, inplace=True)
df_seoul.set_index('전입지', inplace=True)

# 서울에서 경기도로 이동한 인구 데이터 값만 선택 
sr_one = df_seoul.loc['경기도']

# x, y축 데이터를 plot 함수에 입력
plt.plot(sr_one.index, sr_one.values)

# 판다스 객체를 plot 함수에 입력
plt.plot(sr_one)
```

- `fillna()` : 누락 데이터를 원하는 데이터값으로 대체
  - `method='ffill'` 옵션을 사용하면 우낙 데이터의 바로 앞 행의 데이터 값으로 채움

#### 다양한 형태의 선 그래프

```python
plt.plot([1,2,3,4,5,6,7,8,9,8,7,6,5,4,3,2,1,0], 'o') # 점
plt.plot([1,2,3,4,5,6,7,8,8,8,7,6,5,4,3,2,1,0], 'ro') # 빨간색 점
plt.plot([5,3,4,1,7,1,4,5,3,5,4,8,9,6,2,4,5,1], 'b--') # 파란색 -- 선
```



#### 선 굵기 조절

```python
plt.plot(t, np.sin(t), lw=3, label='싸인')
plt.plot(t, np.cos(t), 'r', lw=5, label='코싸인') # 빨간색 선
```

- `lw` : line weight

```python
t = np.arange(0, 5, 0.5)
print(t)
plt.figure(figsize=(10,6))
plt.plot(t, t**2, 'bs')

plt.figure(figsize=(10,6))
plt.plot(t, t**3, 'g^')
```

- 선의 모양이나 점의 모양 등 다양한 선택 가능

```python
plt.plot(t, y, color='green', linestyle='dashed', marker='o', markerfacecolor = 'blue', markersize=12)
```

- 초록색 -- 선, 파란색 원형 마커, 마커사이즈 12



### 1-2 면적 그래프

- `plot(kind='area')`
- 각 열의 데이터를 선 그래프로 표현하는데, 선 그래프와 x축 사이의 공간에 색이 입혀진 그래프
- `alpha` 옵션에 따라 투명도 결정(0 ~ 1)
- stacked=False 옵션을 주면 그래프가 겹쳐지게 그려짐
  - True는 누적되어 그려짐

```python
# 예제 4-15
# 라이브러리 불러오기
import pandas as pd
import matplotlib.pyplot as plt

# matplotlib 한글 폰트 오류 문제 해결
from matplotlib import font_manager, rc
font_path = "data/malgun.ttf"   #폰트파일의 위치
font_name = font_manager.FontProperties(fname=font_path).get_name()
rc('font', family=font_name)

# Excel 데이터를 데이터프레임 변환 
df = pd.read_excel('data/시도별 전출입 인구수.xlsx', header=0)

# 전출지별에서 누락값(NaN)을 앞 데이터로 채움 (엑셀 양식 병합 부분)
df = df.fillna(method='ffill')

# 서울에서 다른 지역으로 이동한 데이터만 추출하여 정리
mask = (df['전출지별'] == '서울특별시') & (df['전입지별'] != '서울특별시') 
df_seoul = df[mask]
df_seoul = df_seoul.drop(['전출지별'], axis=1)
df_seoul.rename({'전입지별':'전입지'}, axis=1, inplace=True)
df_seoul.set_index('전입지', inplace=True)

# 서울에서 '충청남도','경상북도', '강원도', '전라남도'로 이동한 인구 데이터 값만 선택
col_years = list(map(str, range(1970, 2018)))
df_4 = df_seoul.loc[['충청남도','경상북도', '강원도', '전라남도'], col_years]
df_4 = df_4.transpose()

# 스타일 서식 지정
plt.style.use('ggplot') 

# 데이터프레임의 인덱스를 정수형으로 변경 (x축 눈금 라벨 표시)
df_4.index = df_4.index.map(int)

# 면적 그래프 axe 객체 생성
ax = df_4.plot(kind='area', stacked=True, alpha=0.2, figsize=(20, 10))
print(type(ax))

# axe 객체 설정 변경
ax.set_title('서울 -> 타시도 인구 이동', size=30, color='brown', weight='bold')
ax.set_ylabel('이동 인구 수', size=20, color='blue')
ax.set_xlabel('기간', size=20, color='blue')
ax.legend(loc='best', fontsize=15)

plt.show()
```



### 1-3 막대 그래프

- `plot(kind='bar')`
  - `kind='barh'` : 가로형 막대 그래프
- 데이터 값의 크기에 비례하여 높이를 갖는 직사각형 막대로 표현

```python
# 예제 4-16
# 라이브러리 불러오기
import pandas as pd
import matplotlib.pyplot as plt

# matplotlib 한글 폰트 오류 문제 해결
from matplotlib import font_manager, rc
font_path = "data/malgun.ttf"   #폰트파일의 위치
font_name = font_manager.FontProperties(fname=font_path).get_name()
rc('font', family=font_name)

# Excel 데이터를 데이터프레임 변환 
df = pd.read_excel('data/시도별 전출입 인구수.xlsx', header=0)

# 전출지별에서 누락값(NaN)을 앞 데이터로 채움 (엑셀 양식 병합 부분)
df = df.fillna(method='ffill')

# 서울에서 다른 지역으로 이동한 데이터만 추출하여 정리
mask = (df['전출지별'] == '서울특별시') & (df['전입지별'] != '서울특별시') 
df_seoul = df[mask]
df_seoul = df_seoul.drop(['전출지별'], axis=1)
df_seoul.rename({'전입지별':'전입지'}, axis=1, inplace=True)
df_seoul.set_index('전입지', inplace=True)

# 서울에서 '충청남도','경상북도', '강원도', '전라남도'로 이동한 인구 데이터 값만 선택
col_years = list(map(str, range(2010, 2018)))     
df_4 = df_seoul.loc[['충청남도','경상북도', '강원도', '전라남도'], col_years]
df_4 = df_4.transpose()
display(df_4)
# 스타일 서식 지정
plt.style.use('ggplot') 

# 데이터프레임의 인덱스를 정수형으로 변경 (x축 눈금 라벨 표시)
df_4.index = df_4.index.map(int)

# 막대 그래프 그리기
df_4.plot(kind='bar', figsize=(20, 10), width=0.7,
          color=['orange', 'green', 'skyblue', 'blue'])

plt.title('서울 -> 타시도 인구 이동', size=30)
plt.ylabel('이동 인구 수', size=20)
plt.xlabel('기간', size=20)
plt.ylim(5000, 30000)
plt.legend(loc='best', fontsize=15)

plt.show()
```





### 1-4 히스토그램

- `plot(kind='hist')`
- 변수가 하나인 단변수 데이터의 빈도수를 그래프로 표현

```python
# 예제 4-19
# 라이브러리 불러오기
import pandas as pd
import matplotlib.pyplot as plt

plt.style.use('classic')   # 스타일 서식 지정

# read_csv() 함수로 df 생성
df = pd.read_csv('data/auto-mpg.csv', header=None)

# 열 이름을 지정
df.columns = ['mpg','cylinders','displacement','horsepower','weight',
              'acceleration','model year','origin','name']

# 연비(mpg) 열에 대한 히스토그램 그리기
df['mpg'].plot(kind='hist', bins=10, color='coral', figsize=(10, 5))

# 그래프 꾸미기
plt.title('Histogram')
plt.xlabel('mpg')
plt.show()
```



### 1-5 산점도

- `plot(kind='scatter')`
- 서로 다른 두 변수 사이의 관계를 나타냄

```python
t = np.array([0,1,2,3,4,5,6,7,8,9])
y = np.array([9,8,7,9,8,3,2,4,3,4])

plt.figure(figsize=(10,6))
plt.scatter(t,y, s = 50, c = t, marker='>')
plt.colorbar()
plt.show()
```

- c = t : 색 지정
- marker : 점 모양
- colorbar() : 그래프 우측에 색에 따른 레벨 표시

```python
# 예제 4-21
# 라이브러리 불러오기
import pandas as pd
import matplotlib.pyplot as plt

plt.style.use('default')   # 스타일 서식 지정

# read_csv() 함수로 df 생성
df = pd.read_csv('data/auto-mpg.csv', header=None)

# 열 이름을 지정
df.columns = ['mpg','cylinders','displacement','horsepower','weight',
              'acceleration','model year','origin','name']

# cylinders 개수의 상대적 비율을 계산하여 시리즈 생성
cylinders_size = df.cylinders / df.cylinders.max() * 300

# 3개의 변수로 산점도 그리기 
df.plot(kind='scatter', x='weight', y='mpg', c='coral', figsize=(10, 5),
        s=cylinders_size, alpha=0.3)
plt.title('Scatter Plot: mpg-weight-cylinders')
plt.show()
```

- cylinders_size를 통해 원의 크기를 조절하고, alpha를 통해 투병도를 조절하여 **버블 차트**를 그릴 수 있다.



### 1-6 파이 차트(원 그래프)

- `plot(kind='pie')`
- 데이터 값의 크기에 비례하여 원을 조각으로 나누어 표현

```python
# 예제 4-23
# 라이브러리 불러오기
import pandas as pd
import matplotlib.pyplot as plt

# read_csv() 함수로 df 생성
df = pd.read_csv('data/auto-mpg.csv', header=None)

plt.style.use('default')   # 스타일 서식 지정

# 열 이름을 지정
df.columns = ['mpg','cylinders','displacement','horsepower','weight',
              'acceleration','model year','origin','name']

# 데이터 개수 카운트를 위해 값 1을 가진 열을 추가
df['count'] = 1
df_origin = df.groupby('origin').sum()   # origin 열을 기준으로 그룹화, 합계 연산

# 제조국가(origin) 값을 실제 지역명으로 변경
df_origin.index = ['USA', 'EU', 'JAPAN']

# 제조국가(origin) 열에 대한 파이 차트 그리기 – count 열 데이터 사용
df_origin['count'].plot(kind='pie', 
                     figsize=(7, 5),
                     autopct='%1.1f%%',   # 퍼센트 % 표시
                     startangle=10,       # 파이 조각을 나누는 시작점(각도 표시)
                     colors=['chocolate', 'bisque', 'cadetblue']    # 색상 리스트
                     )

plt.title('Model Origin', size=20)
plt.axis('equal')    # 파이 차트의 비율을 같게 (원에 가깝게) 조정
plt.legend(labels=df_origin.index, loc='upper right')   # 범례 표시
plt.show()
```



### 1-7 박스 플롯

- `plot(kind='pie')`

```python
# 예제 4-24
# 라이브러리 불러오기
import pandas as pd
import matplotlib.pyplot as plt

# matplotlib 한글 폰트 오류 문제 해결
from matplotlib import font_manager, rc
font_path = "data/malgun.ttf"   #폰트파일의 위치
font_name = font_manager.FontProperties(fname=font_path).get_name()
rc('font', family=font_name)

plt.style.use('seaborn-poster')            # 스타일 서식 지정
plt.rcParams['axes.unicode_minus']=False   # 마이너스 부호 출력 설정

# read_csv() 함수로 df 생성
df = pd.read_csv('data/auto-mpg.csv', header=None)

# 열 이름을 지정
df.columns = ['mpg','cylinders','displacement','horsepower','weight',
              'acceleration','model year','origin','name']

# 그래프 객체 생성 (figure에 2개의 서브 플롯을 생성)
fig = plt.figure(figsize=(15, 5))   
ax1 = fig.add_subplot(1, 2, 1)
ax2 = fig.add_subplot(1, 2, 2)

# axe 객체에 boxplot 메서드로 그래프 출력
ax1.boxplot(x=[df[df['origin']==1]['mpg'],
               df[df['origin']==2]['mpg'],
               df[df['origin']==3]['mpg']], 
         labels=['USA', 'EU', 'JAPAN'])

ax2.boxplot(x=[df[df['origin']==1]['mpg'],
               df[df['origin']==2]['mpg'],
               df[df['origin']==3]['mpg']], 
         labels=['USA', 'EU', 'JAPAN'],
         vert=False)

ax1.set_title('제조국가별 연비 분포(수직 박스 플롯)')
ax2.set_title('제조국가별 연비 분포(수평 박스 플롯)')

plt.show()
```