# Pandas 데이터 입출력

[TOC]

## 1. 외부 파일 읽어오기

> 판다스는 다양한 형태의 외부 파일을 읽어와서 데이터프레임으로 변환하는 함수를 제공한다.

- 외부파일을 데이터프레임으로 변환하면 판다스의 모든 함수와 기능을 자유롭게 사용

### 판다스 데이터 입출력 도구

| File Format     | Reader | Writer |
| --------------- | ------ | ------ |
| CSV             | read_  | to_    |
| JSON            | read_  | to_    |
| HTML            | read_  | to_    |
| Local clipboard | read_  | to_    |
| MS Excel        | read_  | to_    |
| HDF5 Format     | read_  | to_    |
| SQL             | read_  | to_    |



### 1-1 CSV 파일

- 데이터 값을 쉼표(`,`)로 구분하고 있다는 의미로 CSV(comma-separated values)라고 부르는 첵스트 파일
- 쉼표로 열을 구분하고 줄바꿈으로 행을 구분
- `read_csv()` 함수에 확장자(. csv)를 포함하여 파일 경로를 입력하면 파일을 읽어와 데이터프레임으로 변환

```python
CSV 파일 -> 데이터프레임 : pandas.read_csv("파일 경로(이름)")
```

#### read_csv() 함수의 옵션

- **header** 옵션 : 열 이름이 될 행을 지정(기본값 = 0)
  - `read_csv(file, header=n)`
    - n번째 행을 열 이름으로 하고 n+1번째 행부터 읽옴
  - `read_csv(file, header=None)`
    - header를 주지 않으면 열 이름을 디폴트(0~n)로 주고 모든 내용을 행으로 가져옴

- **index_col** 옵션 : 행 인덱스가 되는 열 지정

##### 예시

```python
# 예제 2-1
import pandas as pd

file_path = './data/read_csv_sample.csv'

# read_csv() 함수로 데이터프레임 변환. 변수 df1에 저장
df1 = pd.read_csv(file_path)
print(df1)
display(df1)

# read_csv() 함수로 데이터프레임 변환. 변수 df2에 저장. header=None 옵션
df2 = pd.read_csv(file_path, header=None)
print(df2)
display(df2)

# read_csv() 함수로 데이터프레임 변환. 변수 df3에 저장. index_col=None 옵션
df3 = pd.read_csv(file_path, index_col=None)
print(df3)
display(df3)

# read_csv() 함수로 데이터프레임 변환. 변수 df4에 저장. index_col='c0' 옵션
df4 = pd.read_csv(file_path, index_col='c0')
print(df4)
display(df4)
```



### 1-2 Excel 파일

- Excel 파일의 행과 열은 데이터프레임의 행, 열로 일대일 대응
- read_csv()와 비슷
- header, index_col 등 대부분의 옵션을 그대로 사용 가능
- `read_excel()` 함수를 사용하여 데이터프레임으로 변환

```python
Excel 파일 -> 데이터프레임 : pandas.read_excel("파일 경로(이름)")
```

##### 예시

```python
# 예제 2-2
import pandas as pd

# read_excel() 함수로 데이터프레임 변환 
df1 = pd.read_excel('./data/남북한발전전력량.xlsx')            # header=0 (default 옵션)
df2 = pd.read_excel('./data/남북한발전전력량.xlsx', header=None)  # header=None 옵션

# 데이터프레임 출력
print(df1)
display(df1)
print(df2)
display(df2)
pd.get_option('display.max_columns')

pd.set_option('display.max_columns', 100)

import pandas as pd

# read_excel() 함수로 데이터프레임 변환 
df1 = pd.read_excel('./data/남북한발전전력량.xlsx')            # header=0 (default 옵션)
df2 = pd.read_excel('./data/남북한발전전력량.xlsx', header=None)  # header=None 옵션

# 데이터프레임 출력
display(df1)
display(df2)

pd.reset_option("^display")
```



### 1-3 JSON 파일

- JavaScript에서 유래한 데이터 공유를 목적으로 개발된 특수한 파일 형식
- 파이썬 딕셔너리와 비슷하게 `key:value` 구조를 갖는다.
- `read_json()` 함수를 사용하여 데이터프레임으로 변환

```python
Excel 파일 -> 데이터프레임 : pandas.read_excel("파일 경로(이름)")
```

##### 예시

```python
# 예제 2-3
import pandas as pd

# read_json() 함수로 데이터프레임 변환 
df = pd.read_json('./data/read_json_sample.json')  
print(df)
print(df.index)
```



## 2. 웹(Web)에서 가져오기

### 2-1 HTML 웹 페이지에서 표 속성 가져오기

- `read_html()` 함수는 HTML 웹 페이지에 있는 **`<table>` 태그에서 표 형식의 데이터**를 모두 찾아서 데이터프레임으로 변환

```python
HTML 표 속성 읽기 : pandas.read_html("웹 주소(URL)" 또는 "HTML 파일 경로(이름)")
```

##### 예시

```python
# 예제 2-4
import pandas as pd

# HTML 웹페이지의 표(table)를 가져와서 데이터프레임으로 변환 
tables = pd.read_html('./data/sample.html')

# 표(table)의 개수 확인
print(len(tables))

# tables 리스트의 원소를 iteration하면서 각각 화면 출력
for i in range(len(tables)):
    print("tables[%s]" % i)
    print(tables[i])

# 파이썬 패키지 정보가 들어 있는 두 번째 데이터프레임을 선택하여 df 변수에 저장
df = tables[1] 

# 'name' 열을 인덱스로 지정
df.set_index(['name'], inplace=True)
print(df)
```



### 2-2 웹 스크래핑

- BeautifulSoup 등 웹 스크래핑 도구로 수집한 내용을 파이썬 리스트, 딕셔너리 등으로 정리
- DataFrame() 함수에 리스트/딕셔너리 형태로 전달하여 변환

```python
HTML 표 속성 읽기 : pandas.read_html("웹 주소(URL)" 또는 "HTML 파일 경로(이름)")
```

##### 예시(테스트는 불가하기 때문에 알고만 있자)

```python
# 예제 2-5
from bs4 import BeautifulSoup
import requests
import re
import pandas as pd

url = "https://en.wikipedia.org/wiki/List_of_American_exchange-traded_funds"
resp = requests.get(url)
soup = BeautifulSoup(resp.text, 'lxml')
rows = soup.select('div > ul > li')

etfs = {}
for row in rows:
    try:
        etf_name = re.findall('^(.*) \(NYSE', row.text)
        etf_market = re.findall('\((.*)\|', row.text)
        etf_ticker = re.findall('NYSE Arca\|(.*)\)', row.text)
        
        if (len(etf_ticker) > 0) & (len(etf_market) > 0) & (len(etf_name) > 0):
            etfs[etf_ticker[0]] = [etf_market[0], etf_name[0]]
                                    
    except AttributeError as err:
        pass
                                    
print(etfs)

df = pd.DataFrame(etfs)
print(df)
```



## 3. API 활용하여 데이터 수집하기

> 인터넷 업체가 제공하는 API를 통해서 수집한 데이터를, 판다스 자료구조로 변환하는 방법

### 3-1 Google 지오코딩 API

- 구글 지오코딩이란 장소 이름 또는 주소를 입력하면 위도와 경도 좌표 정보를 변환해 주는 서비스
- 서비스를 이용하기 위해서는 사용자 인증 후 API 키를 발급받아야 함
  - https://cloud.google.com/maps-platform/places/?hl-ko 참고



#### Googlemaps 라이브러리 설치

- 아나콘다 프롬프트를 통해 설치
  - 이미 설치함

##### 지오코딩 API를 사용하여 "해운대해수욕장" 위치정보 확인

```python
## google 지오코딩 API 통해 위도, 경도 데이터 가져오기 
# 예제 2-6
import googlemaps
import pandas as pd

my_key = "AIzaSyDy81EbO46BRSnX1DOgg_F84bhsdbku2z4"

# 구글맵스 객체 생성하기
maps = googlemaps.Client(key=my_key)  # my key값 입력

lat = []  #위도
lng = []  #경도

# 장소(또는 주소) 리스트
places = ["서울시청", "국립국악원", "해운대해수욕장"]

i=0
for place in places:   
    i = i + 1
    try:
        print(i, place)
        # 지오코딩 API 결과값 호출하여 geo_location 변수에 저장        
        geo_location = maps.geocode(place)[0].get('geometry')
        lat.append(geo_location['location']['lat'])
        lng.append(geo_location['location']['lng'])
    except:
        lat.append('')
        lng.append('')
        print(i)

# 데이터프레임으로 변환하기
df = pd.DataFrame({'위도':lat, '경도':lng}, index=places)
print('\n')
print(df)
```





## 4. 데이터 저장하기

### 4-1 CSV 파일로 저장

- `to_csv()` 메소드를 사용
- CSV 파일을 저장할 파일 경로와 파일명을 `""` 안에 입력

```python
CSV 파일로 저장 : df.to_csv("파일 이름(경로)")
```

##### 예시

```python
# 예제 2-7-1
import pandas as pd

# 판다스 DataFrame() 함수로 데이터프레임 변환. 변수 df에 저장 
data = {'name' : [ 'Jerry', 'Riah', 'Paul'],
        'algol' : [ "A", "A+", "B"],
        'basic' : [ "C", "B", "B+"],
        'c++' : [ "B+", "C", "C+"],
        }

df = pd.DataFrame(data)
#df.set_index('name', inplace=True)   #name 열을 인덱스로 지정
print(df)

# to_csv() 메소드를 사용하여 CSV 파일로 내보내기. 파열명은 df_sample.csv로 저장
df.to_csv("./output/df_sample1.csv")
df.to_csv("./output/df_sample2.csv", index=False)
```



### 4-2 JSON파일로 저장

- `to_json()` 메소드를 사용
- JSON 파일을 저장할 파일 경로와 파일명을 `""` 안에 입력

```python
JSON 파일로 저장 : df.to_json("파일 이름(경로)")
```

##### 예시

```python
# 예제 2-8
import pandas as pd

# 판다스 DataFrame() 함수로 데이터프레임 변환. 변수 df에 저장 
data = {'name' : [ 'Jerry', 'Riah', 'Paul'],
        'algol' : [ "A", "A+", "B"],
        'basic' : [ "C", "B", "B+"],
        'c++' : [ "B+", "C", "C+"],
        }

df = pd.DataFrame(data)
df.set_index('name', inplace=True)   #name 열을 인덱스로 지정
print(df)

# to_json() 메소드를 사용하여 JSON 파일로 내보내기. 파열명은 df_sample.json로 저장
df.to_json("./output/df_sample.json")
```



### 4-3 Excel 파일로 저장

- `to_excel()` 메소드를 사용
- Excel 파일을 저장할 파일 경로와 파일명을 `""` 안에 입력

```python
Excel 파일로 저장 : df.to_excel("파일 이름(경로)")
```

##### 예시

```python
# 예제 2-9
import pandas as pd

# 판다스 DataFrame() 함수로 데이터프레임 변환. 변수 df에 저장 
data = {'name' : [ 'Jerry', 'Riah', 'Paul'],
        'algol' : [ "A", "A+", "B"],
        'basic' : [ "C", "B", "B+"],
        'c++' : [ "B+", "C", "C+"],
        }

df = pd.DataFrame(data)
df.set_index('name', inplace=True)   #name 열을 인덱스로 지정
print(df)

# to_excel() 메소드를 사용하여 엑셀 파일로 내보내기. 파열명은 df_sample.xlsx로 저장
df.to_excel("./output/df_sample.xlsx")
```



### 4-4 여러 개의 데이터 프레임을 하나의 Excel 파일로 저장

```python
데이터 프레임 여러 개를 Excel 파일로 저장 : pandas.ExcelWriter("파일 이름(경로)")
```

##### 예시

```python
# 예제 2-10
import pandas as pd

# 판다스 DataFrame() 함수로 데이터프레임 변환. 변수 df1, df2에 저장 
data1 = {'name' : [ 'Jerry', 'Riah', 'Paul'],
         'algol' : [ "A", "A+", "B"],
         'basic' : [ "C", "B", "B+"],
          'c++' : [ "B+", "C", "C+"]}
data2 = {'c0':[1,2,3], 
         'c1':[4,5,6], 
         'c2':[7,8,9], 
         'c3':[10,11,12], 
         'c4':[13,14,15]}

df1 = pd.DataFrame(data1)
df1.set_index('name', inplace=True)      #name 열을 인덱스로 지정
print(df1)

df2 = pd.DataFrame(data2)
df2.set_index('c0', inplace=True)        #c0 열을 인덱스로 지정
print(df2)

# df1을 'sheet1'으로, df2를 'sheet2'로 저장 (엑셀파일명은 "df_excelwriter.xlsx")
writer = pd.ExcelWriter("./output/df_excelwriter.xlsx")
df1.to_excel(writer, sheet_name="sheet1")
df2.to_excel(writer, sheet_name="sheet2")
writer.save()
```

