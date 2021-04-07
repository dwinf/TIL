# Open API

- **Application Programming Interface**
- 특정 프로그램을 만들기 위해 제공되는 모듈 (함수 등)

### Open API

- 공개 API
- 누구나 사용할 수 있도록 공개된 API
- 주로 Rest API기술을 많이 사용

### Rest API

- **Representational State Transfer API**
- HTTP 프로토콜을 통해서 정보를 제공하는 함수
- 실질적인 API 사용은 **정해진 구조의 URL 문자열 사용**



일반적으로 **XML**, **JSON** 형태로 응답 출력



### 실시간 버스 위치

```python
from bs4 import BeautifulSoup
import urllib.request as req

busNum = '360'
key = '%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D'
url1 = 'http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?serviceKey='+key+'&strSrch='+busNum
res = req.urlopen(url1)

soup = BeautifulSoup(res.read().decode('utf-8'), features="xml")

busRouteId = None
for itemList in soup.find_all('itemList') :
    busRouteId = itemList.find('busRouteId').string
    busRouteNm = itemList.find('busRouteNm').string
    if busRouteNm == busNum :
        break

url2 = 'http://ws.bus.go.kr/api/rest/busRouteInfo/getStaionByRoute?ServiceKey='+key+'&busRouteId='+busRouteId
print(url2)
res = req.urlopen(url2)
soup = BeautifulSoup(res.read().decode('utf-8'), features="xml")

busPos = []
for itemList in soup.find_all('itemList') :
    gpsY = itemList.find('gpsY').string
    gpsX = itemList.find('gpsX').string

    busPos.append((gpsY, gpsX))

print('[ ' + busNum + '번 버스의 운행 위치 ]')
if len(busPos) != 0 :
    print(busNum + '번 버스 ' + str(len(busPos)) + '대 운행중...')
    for lat,lng in busPos :
        print(lat+','+lng)
else :
    print('현재 운행중인 ' + busNum + '번 버스가 없어요...')
```



### 지하철 역별 승하차 인원 정보

```python
from bs4 import BeautifulSoup
import urllib.request as req
import io

key = '796143536a756e69313134667752417a'
contentType = 'xml'
startIndex = '1'
endIndex = '100'
date = '20201010'

url = 'http://openapi.seoul.go.kr:8088/'+key+'/'+contentType+'/CardSubwayStatsNew/'+startIndex+'/'+endIndex+'/'+date+'/'
print(url)
savename = 'output/subway.xml'
req.urlretrieve(url, savename)

xml = open(savename, 'r', encoding='utf-8').read()
soup = BeautifulSoup(xml, 'xml')

subwayList = []
for itemList in soup.find_all('row') :
    line_num = itemList.find('LINE_NUM').string
    sub_sta_nm = itemList.find('SUB_STA_NM').string
    ride_pasgr_num = itemList.find('RIDE_PASGR_NUM').string
    alight_pasgr_num = itemList.find('ALIGHT_PASGR_NUM').string
    subwayList.append((line_num, sub_sta_nm, ride_pasgr_num, alight_pasgr_num))

print('[ 서울시 지하철호선별 역별 승하차 인원 정보 ]')
for line_num, sub_sta_nm, ride_pasgr_num, alight_pasgr_num in subwayList :
    print(line_num+','+sub_sta_nm+','+ride_pasgr_num+','+alight_pasgr_num)
```



### 100대 통계 정보

```python
from bs4 import BeautifulSoup
import urllib.request as req
import io

key = '4WQ7X833TXC370SUTDX4'
contentType = 'xml'
startIndex = '1'
endIndex = '100'

url = 'http://ecos.bok.or.kr/api/KeyStatisticList/'+key+'/'+contentType+'/kr/'+startIndex+'/'+endIndex+'/'
res = req.urlopen(url)
print(url)
soup = BeautifulSoup(res.read().decode('utf-8'), 'xml')
ecoList = []
for itemList in soup.find_all('row') :
    class_name = itemList.find('CLASS_NAME').string
    class_name = '없음' if class_name is None else class_name
    keystat_name = itemList.find('KEYSTAT_NAME').string
    keystat_name = '없음' if keystat_name is None else keystat_name
    data_value = itemList.find('DATA_VALUE').string
    data_value = '없음' if data_value is None else data_value
    cycle = itemList.find('CYCLE').string
    cycle = '없음' if cycle is None else cycle
    unit_name = itemList.find('UNIT_NAME').string
    unit_name = '없음' if unit_name is None else unit_name
    ecoList.append((class_name, keystat_name, data_value, cycle, unit_name))

print('[ 100대 통계 지표 ]')
for class_name, keystat_name, data_value, cycle, unit_name in ecoList :
    print(class_name+','+keystat_name+','+data_value+','+cycle+','+unit_name)
```



### 네이버 블로그

```python
import urllib.request
import json
client_key = 'izGsqP2exeThwwEUVU3x'
client_secret = 'WrwbQ1l6ZI'
query = '수능'
encText = urllib.parse.quote_plus(query) # quote를 써도됨 공백이 없기 때문에  
num = 100
naver_url = 'https://openapi.naver.com/v1/search/blog.json?query=' + encText + '&display=' + str(num)

request = urllib.request.Request(naver_url)
request.add_header("X-Naver-Client-Id",client_key)
request.add_header("X-Naver-Client-Secret",client_secret)
response = urllib.request.urlopen(request)
rescode = response.getcode()
if(rescode == 200):
    response_body = response.read()
    dataList = json.loads(response_body)
    count = 1
    print('[' + query + '에 대한 네이버 블로그 글 ]')
    for data in dataList['items'] :
        print (str(count) + ' : ' + data['title'])
        print ('[' + data['description'] + ']')
        count += 1
else:
    print('오류 코드 : ' + rescode)
```



### 트위터

```python
import tweepy

api_key = "RvnZeIl8ra88reu8fm23m0bST"
api_secret = "wTRylK94GK2KmhZUnqXonDaIszwAsS6VPvpSsIo6EX5GQLtzQo"
access_token = "959614462004117506-dkWyZaO8Bz3ZXh73rspWfc1sQz0EnDU"
access_token_secret = "rxDWfg7uz1yXMTDwijz0x90yWhDAnmOM15R6IgC8kmtTe"

auth = tweepy.OAuthHandler(api_key, api_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)

keyword = '치맥'   
search = []   

cnt = 1
while(cnt <= 10):   
    tweets = api.search(q=keyword, count=100)
    for tweet in tweets :
        search.append(tweet)
    cnt += 1

data = {}   
i = 1   
print('[' + keyword + '에 대한 트윗 글 ]')    
for tweet in search:
    data['text'] = tweet.text   
    print(i, " : ", data)   
    i += 1
```



### 실습

```python
from bs4 import BeautifulSoup
import urllib.request
import io
import json

client_id = 'izGsqP2exeThwwEUVU3x'
client_secret = 'WrwbQ1l6ZI'

def naver_search(keyword, callType='JSON'):
    base = 'https://openapi.naver.com/v1/search/local.'
    if callType == 'JSON':
        callType = 'json'
    else:
        callType = 'xml'
    query = urllib.parse.quote(keyword)
    
    parameters = '?query=%s&display=5' % query
    url = base + callType + parameters

    req = urllib.request.Request(url)
    req.add_header("X-Naver-Client-Id", client_id)
    req.add_header("X-Naver-Client-Secret", client_secret)
    response = urllib.request.urlopen(req)
    rescode = response.getcode()
    
    if callType == 'json':
        response_body = response.read()
        dataList = json.loads(response_body)
        count = 1
        print("[" + keyword + "집에 대한 네이버 지역 정보(" + callType.upper() + ")]")
        for data in dataList['items'] :
            print (str(count) + ' : ' + data['title'] + ', ' + data['address'])
            count += 1
    else:
        soup = BeautifulSoup(response.read().decode('utf-8'), 'xml')
        count = 1
        print("[" + keyword + "집에 대한 네이버 지역 정보(" + callType.upper() + ")]")
        for item in soup.find_all('item'):
            title = item.find('title').text
            address = item.find('address').string
            print(str(count) + ' : ' + title + ', ' + address)
            count += 1
            
naver_search('짜장면', 'XML')
naver_search('쌀국수')
```

