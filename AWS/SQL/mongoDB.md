# mongoDB

> **NoSQL**로 분류되는 **크로스 플랫폼 도큐먼트 지향** 데이터베이스 시스템

- MySQL 처럼 전통적인 테이블-관계 기반의 RDBMS가 아니며 SQL을 사용하지 않는다. 

- mongo는 humongous를 줄인 표현

  - 즉 '**겁나 큰 DB**' 라는 뜻이다.

- MySQL(MariaDB)의 테이블과 같이 스키마가 고정된 구조 대신 JSON 형태의 동적 스키마형 문서를 사용

  - MongoDB 에서는 **BSON**이라고 부른다

  

| RDBMS(SQL)       | NoSQL              |
| ---------------- | ------------------ |
| 데이터베이스(DB) | 데이터베이스(DB)   |
| 테이블(table)    | 콜렉션(collection) |
| 로우(row)        | 도큐먼트(Document) |

- **똑같은 조건으로 설계되었을 시 NoSQL 이 기존 RDBMS 보다 속도가 굉장히 빠르다**
- 데이터 consistency가 거의 필요 없고 조인 연산을 embed로 대체할 수 있는 경우에는 MongoDB 사용
- 저장되는 데이터가 은행 데이터 같이 consistency가 매우 중요한 작업에는 MongoDB를 쓰지 않는다.



## NoSQL

- SQL과 서로 반대의 개념도, 경쟁상대도 아니다. 
- 많은 회사들이 두 타입 모두 동시에 사용
- 데이터가 급격하게 늘어나는 형태라면 NoSQL이 도움이 될 수 있다.



### SQL

- 시스템이 커져가면서 **Scale-Up**의 형태로 DB를 증설
  - 관계를 가지는 테이블들이 **수평적**으로 더 커진다
- 기존에 사용하던 DB시스템보다 고성능의 DB시스템이 필요할 수 있고, 굉장히 덩치가 큰 DB 시스템이 된다
- 비용도 많이 증가될 뿐만 아니라 관리가 어려워질 수 있다.



### NoSQL

> 'NoSQL이 스케일링에 좋다고 하던데요'

- 시스템이 커져가면서 **Scale-Out**의 형태로 증설
  - 고성능의 DB를 갖추는 게 아니라 여러 DB 시스템으로 추가
- Scale-Up이 무제한적으로 늘려갈 수 없는 것과 비교해 장점



## AWS의 MongoDB 접속

> 파이썬 환경에서 MongoDB를 사용하기 위해선 pymongo가 설치되어 있어야 한다.

#### AWS 서버의 MongoDB 접속

```python
from pymongo import MongoClient 
my_client = MongoClient("mongodb://팀서버IP주소:27017/") # 팀단위 IP 주소로 수정 부탁해요
```



#### book 컬렉션의 도큐먼트 추출

```python
my_doc = my_client['testdb_리눅스개인계정']['book'].find()
for x in my_doc: 
   print(x)
```



### 데이터베이스 생성/추출

```python
mydb = my_client['리눅스개인계정db']   # 본인 계정명(labXXdb)으로 수정할것
mycol = mydb['customers'] 
```

- `insert_one()` : 데이터베이스에 도큐먼트 삽입



#### 해당 컬렉션(테이블)에 데이터 삽입하기

```python
x = mycol.insert_one({"name":"dooly", "address":"SSangmun-dong, Seoul"}) 

my_dict = [{"name":"ddochi", "address":"Seocho-dong, Seoul"}, 
                  {"name":"dounar", "address":"Samsung-dong, Seoul"}, 
                  {"name":"heedong", "address":"SSangmun-dong, Seoul"}] 
x = mycol.insert_many(my_dict) 
```



#### 해당 컬렉션(테이블) 데이터 출력하기

```python
x = mycol.find_one() # 하나만

my_doc = mycol.find() # 모든 데이터
for x in my_doc: 
   print(x)
```



#### 열 기준 정렬해 출력하기

```python
my_doc = mycol.find().sort("name") # 오름차순
for x in my_doc: 
my_doc = mycol.find().sort("name", -1) # 내림차순
for x in my_doc: 
    print(x)
```



#### 검색

```python
my_query = {"address":"SSangmun-dong, Seoul"} 
my_doc = mycol.find(my_query) 
for x in my_doc: 
    print(x)
```



#### 연결 종료

```python
my_client.close()
```