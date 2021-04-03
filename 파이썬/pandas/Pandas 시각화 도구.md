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

#### (1) 타이틀 작성

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



#### (2) 축(label) 제목

```python
plt.ylabel('갯수')
plt.xlabel('학생이름')
```



#### (3) 축(label) 꾸미기

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



#### (4) 축 이름

```python
plt.xticks([0, 1, 2])
plt.yticks(np.arange(1, 6))
# 또는
plt.xticks(np.arange(0, 2.1, 0.2), labels=['Jan', '', 'Feb', '', 'Mar', '', 'May', '', 'June', '', 'July'])
plt.yticks(np.arange(0, 7), ('0', '1GB', '2GB', '3GB', '4GB', '5GB', '6GB'))
```

- x축과 y축이 만나는 지점이 0이 아님
- 축 범위까지 지정 가능



#### (5) 축 범위

```python
plt.ylim(-1.2, 1.2)
plt.xlim(0, np.pi)
```



#### (6) 범례(legend) 표시

```python
plt.legend(["a", "a**2", "a**3"], loc='upper center')
```

- `loc` 를 통해 출력될 위치 지정
  - `upper` : 위, `center` : 중앙, `right` : 우측, `left` : 좌측, 

- 그래프의 label이 지정되어 있지 않다면 출력되지 않음(축 제목X)

  - ```python
    plt.plot(t, np.sin(t), label='sin')
    plt.plot(t, np.cos(t), label='cos')
    plt.legend()
    plt.show()
    ```



#### (7) 그리드 표시

```python
plt.grid()
plt.grid(True, axis='y') # y축 그리드만 표시
plt.grid(True, axis='y', color='red', alpha=0.5, linestyle='--') # 선 모양과 색 변경
```



#### (8) 보조선 표시

```python
plt.axhline(1, 0, 0.55, color='gray', linestyle='--', linewidth='1')
plt.axvline(1, 0, 0.16, color='lightgray', linestyle=':', linewidth='2')

plt.axhline(5.83, 0, 0.95, color='gray', linestyle='--', linewidth='1')
plt.axvline(1.8, 0, 0.95, color='lightgray', linestyle=':', linewidth='2')
```



#### (9) 그래프 작성

```python
plt.bar(x=s.index, height=s, color=['skyblue', 'red', 'green', 'orange', 'yellow'])
plt.plot([1,2,3,4,5,6],[100,200,300,400,500,800], 'r+') # 선 그래프
plt.plot([1,2,3,4,5,6],[1,2,3,4,5,6], 'r--', [1,2,3,4,5,6],[3,4,5,6,7,8], 'gv-', [1,2,3,4,5,6],[5,6,7,8,9,10], 'm-.')
plt.plot(a, a, 'bo')
plt.plot(a, a**2, color='#e35f62', marker='*', linewidth=2)
plt.plot(a, a**3, color='springgreen', marker='^', markersize=9)
```

- x축, y축 데이터 지정
- 막대의 색상 지정



#### (10) 그래프 저장

```python
plt.savefig("test.png") 
```

- 반드시 show() 함수를 호출하기 전에 해야함



#### (11) 그래프 출력

```python
plt.show()
```

- 안해도 출력이 되지만, 객체 정보도 함께 출력하게 됨



#### () 그래프 크기

```python
plt.figure(figsize=(10,6))
```

- 기본값은 (6, 4) inch
- 그래프를 그리기 전에 미리 설정해야 함



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
df.head()
```



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
plt.legend()
plt.xlabel('time')
plt.ylabel('Amplitude')
plt.title('Example of sinewave')
plt.show()
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



### 1-2 막대 그래프

- 선 그래프는 연속하는 데이터 값들을 직선 또는 곡선으로 연결하여 데이터 값 사이의 관계를 나타냄
- 시계열 데이터와 같이 연속적인 값의 변화와 패턴을 파악하는데 적합하다.



### 1-3 선 그래프

- 선 그래프는 연속하는 데이터 값들을 직선 또는 곡선으로 연결하여 데이터 값 사이의 관계를 나타냄
- 시계열 데이터와 같이 연속적인 값의 변화와 패턴을 파악하는데 적합하다.



### 1-4 선 그래프

- 선 그래프는 연속하는 데이터 값들을 직선 또는 곡선으로 연결하여 데이터 값 사이의 관계를 나타냄
- 시계열 데이터와 같이 연속적인 값의 변화와 패턴을 파악하는데 적합하다.



### 1-5 선 그래프

- 선 그래프는 연속하는 데이터 값들을 직선 또는 곡선으로 연결하여 데이터 값 사이의 관계를 나타냄
- 시계열 데이터와 같이 연속적인 값의 변화와 패턴을 파악하는데 적합하다.



### 1-6 선 그래프

- 선 그래프는 연속하는 데이터 값들을 직선 또는 곡선으로 연결하여 데이터 값 사이의 관계를 나타냄
- 시계열 데이터와 같이 연속적인 값의 변화와 패턴을 파악하는데 적합하다.



### 1-7 선 그래프

- 선 그래프는 연속하는 데이터 값들을 직선 또는 곡선으로 연결하여 데이터 값 사이의 관계를 나타냄
- 시계열 데이터와 같이 연속적인 값의 변화와 패턴을 파악하는데 적합하다.



## 2. Seaborn 라이브러리

> 고급 그래프 도구



## 3. Folium 라이브러리

> 지도 활용