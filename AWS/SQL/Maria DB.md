# Maria DB 

> DBMS : DataBase Management System

- Define, record, query, update, manage data 기능
- Oracle, mySQL 등 무료 버전을 학습용으로 사용
  - 현재는 무료지만 유료가 되는 경우도 있음
- DBMS 종류
  - Relational DB, Hierarchical DB, Flat File DB, Objects DB
  - 주로 사용되는 것이 Relational DB



### DB 테이블 구성

>  데이터가 저장되는 방식(2차원 테이블 구조)

- Tuple(or record) : 열
- Attribute(행) : 행
- Schema(도메인과 유사) : 행의 속성
- Instance : 테이블을 구성하는 데이터들



### DBMS의 주요 기능[CRUD]

> **Create**, **Read**, **Update**, **Delete**

- 이러한 기능을 위한 언어가 **SQL**(Structured Query Language)
- IBM에서 만들어 ANSI에서 표준으로 지정

- **C** : insert into 테이블명 [(컬럼명 리스트, ...)] values (데이터값 리스트, ...)
- **U** : update 테이블명 set 컬럼명=컬럼값, ...[where 조건식] 
- **D** : delete [from] 테이블명 [where 조건식]
- **R** : select 컬럼명, ... from 테이블명 [where 조건식] [group by 그룹핑 기준 컬럼] [having 그룹의 조건] [order by 정렬 기준 컬럼, ...]



### select절 활용

> 우리 커리큘럼에서는 select기능을 가장 많이 사용

- sql에서는 등가연산은 `=` 이다.(`==`이 아니다.)

```sql
select * from t where empno = 100
select * from t where empno != 100
```

- 문자열 데이터값은 단일 인용부호(`''`)만 사용한다.

```sql
select * from t where ename = 'King'
```

- where 절에 복수의 조건을 주고자 할 경우

```sql
select * from t where ename = 'King' or ename = 'Kang' or ename = 'kong'
select * from t where ename in ('King', 'Kang', 'kong')
select * from t where ename like 'K%'
```

- and/or 조건에서는 and 연산이 우선적으로 적용된다.

- = 연산자를 사용할 경우 ename이 K%인 직원을 찾는 결과
- `%` : 0개 이상의 임의의 문자
- `_` : 임의의 한 문자

- VIEW - 가상 테이블
  - 원하는 조건(혹은 자주 사용하는 컬럼, 행)에 맞는 가상의 테이블을 만들어 저장



#### 논리 연산자

- AND : 조건이 모두 참일 경우
- OR : 조건이 하나라도 참일 경우
- NOT : 조건 결과의 반대값

#### 비교 연산자

| Operator             | Mean                     | Operator       | Mean                               |
| -------------------- | ------------------------ | -------------- | ---------------------------------- |
| =                    | 같다                     | >, <           | 크다, 작다                         |
| >=, <=               | 크거나 같다, 작거나 같다 | <>, !=, ^=     | 같지 않다                          |
| BETWEEN AND          | 특정 범위에 포함되는지   | LIKE/ NOT LIKE | 문자 패턴을 비교                   |
| IS NULL/ IS NOT NULL | NULL 여부 비교           | IN             | 비교값 목록에 포함되는지 여부 비교 |



# pymysql을 이용한 MariaDB 연동

- `connect()` 함수를 이용하면 MySQL(mairaDB) host내 DB와 직접 연결할 수 있다.
- **user**: user name
- **passwd**: 설정한 패스워드
- **host**: DB가 존재하는 host
- **db**: 연결할 데이터베이스 이름
- **charset**: 인코딩 설정



### 1. DB 연동

```python
import pymysql
conn = pymysql.connect(host='database-big-a.cljkqcsbb9ok.ap-northeast-2.rds.amazonaws.com',port=3306,user='edu14',passwd='multi1234!', db='edu14db')
print(conn)
```



### 2. Cursor 객체 생성
- 연결한 DB와 상호작용하기 위해 cursor 객체를 생성해주어야 한다.
- 다양한 커서의 종류가 있지만, 데이터 분석가에게 익숙한 데이터프레임 형태로 결과를 쉽게 변환할 수 있도록 **딕셔너리** 형태로 결과를 반환해주는 **DictCursor**객체를 주로 사용한다.
- 일반 **Cursor**객체를 사용하면 결과가 일반적으로는 **튜플** 형태로 리턴된다.

- SELECT 명령을 위해 SQL 문을 따로 변수에 넣어주고 `cursor.execute(sql)` 을 사용해 SQL를 실행한다.

- 실행한 결과를 fetchall(), fetchone() 등으로 받아 온다.
  - `fetchall()` - 모든 데이터를 한 번에 가져올 때 사용
  - `fetchone()` - 한 번 호출에 하나의 행만 가져올 때 사용
  - `fetchmany(n)` - n개만큼의 데이터를 가져올 때 사용

```python
cur = conn.cursor()
print(type(cur))
print("-----------------------")
sql = 'SELECT * FROM emp'
cur.execute(sql)
result = cur.fetchall()
print(type(result))
print(result)  
#conn.close()
```

- 데이터를 가져온 후 연결을 종료해 줘야 함

### 가져온 데이터

```python
try:
    cur = conn.cursor()
    print(type(cur)) # <class 'pymysql.cursors.Cursor'>
    print("-----------------------")
    sql = 'SELECT * FROM emp'
    cur.execute(sql)
    result = cur.fetchall()
    print(type(result)) # <class 'tuple'>
    print(result) # 튜플로 출력
    print("----------------------------------------------")
    print(type(result[0]))
    print(result[0])
    print("----------------------------------------------")
    print(len(result)) # 14, 데이터 수
    print(len(result[0])) # 8, 1개 데이터 안의 변수
    print("----------------------------------------------")
    for row in result:        
        print(f'{row[0]} {row[1]} {row[2]} {row[3]} {row[4]} {row[5]} {row[6]} {row[7]}')
finally:
    conn.close()
```

#### DictCursor 객체 이용

```python
import pymysql
conn = pymysql.connect(host='database-big-a.cljkqcsbb9ok.ap-northeast-2.rds.amazonaws.com',port=3306,
                       user='edu14',passwd='multi1234!', db='edu14db', cursorclass=pymysql.cursors.DictCursor)
try:
    cur = conn.cursor()
    sql = 'SELECT * FROM emp'
    cur.execute(sql)
    result = cur.fetchone()
    print(type(result))
    print(result)
    print("----------------------------------------------")
    result = cur.fetchone()
    print(type(result))
    print(result)
    print("----------------------------------------------")
    result = cur.fetchmany(3)
    print(type(result))
    print(result)
    print("----------------------------------------------")
    result = cur.fetchall()
    print(type(result))
    print(result)
    print("----------------------------------------------")
    result = cur.fetchone() # 더 없슈!!
    print(result)
finally:
    conn.close()
```

- DictCursor를 이용하면 column명을 지정해주지 않아도 DB 테이블에서 키:값 쌍으로 가져와주기 때문에 column명이 적용된다.



```python
try:
    cur = conn.cursor()
    sql = 'SELECT * FROM emp'
    cur.execute(sql)
    result = cur.fetchone()
    print(result)
    print("----------------------------------------------")
    result = cur.fetchone()
    print(result)
    print("----------------------------------------------")
    result = cur.fetchmany(3)
    print(result)
    print("----------------------------------------------")
    result = cur.fetchall()
    print(result)
    print("----------------------------------------------")
    result = cur.fetchone() # 더 없슈!!
    print(result)
finally:
    conn.close()
```

- fetch를 통해 가져온 데이터는 한번 쓰고 사라지기 때문에 같은 데이터를 가져오기 위해서는 `cur.execute(sql)`를 다시 수행해야함



#### pymysql을 통해 테이블을 생성해 데이터 입력

```python
import pymysql

dbServerName    = "database-big-a.cljkqcsbb9ok.ap-northeast-2.rds.amazonaws.com"
dbUser          = "edu14"
dbPassword      = "multi1234!"
dbName          = "edu14db"
charSet         = "utf8"
cusrorType      = pymysql.cursors.DictCursor

connectionObject   = pymysql.connect(host=dbServerName, user=dbUser, password=dbPassword,
                                     db=dbName, charset=charSet,cursorclass=cusrorType)

try:
    cursorObject = connectionObject.cursor()                                     
    sqlQuery = "CREATE TABLE IF NOT EXISTS friend(id int, LastName varchar(32), FirstName varchar(32), DepartmentCode int)"   
    cursorObject.execute(sqlQuery)
    sqlQuery = "show tables"   
    cursorObject.execute(sqlQuery)
    rows = cursorObject.fetchall()
    for row in rows:
        print(row)

    insertStatement = "INSERT INTO friend (id, LastName, FirstName, DepartmentCode) VALUES (1,'KIM','DAECHAN',10)"   
    cursorObject.execute(insertStatement)
    insertStatement = "INSERT INTO friend (id, LastName, FirstName, DepartmentCode) VALUES (1,'GO','GILDONG',10)"   
    cursorObject.execute(insertStatement)
    insertStatement = "INSERT INTO friend (id, LastName, FirstName, DepartmentCode) VALUES (3,'GO','HEEDONG',20)"   
    cursorObject.execute(insertStatement)
    connectionObject.commit()

    sqlQuery = "select * from friend"   
    cursorObject.execute(sqlQuery)
    rows = cursorObject.fetchall()

    for row in rows:
        print(row)

except Exception as e:
    print("Exeception occured:{}".format(e))
finally:    
    connectionObject.close()
```

