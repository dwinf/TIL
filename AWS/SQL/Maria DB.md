# Maria DB 

> DBMS : DataBase Management System

- Define, record, query, update, manage data 기능
- Oracle, mySQL 등 무료 버전을 학습용으로 사용
  - 현재는 무료지만 유료가 되는 경우도 있음
- DBMS 종류
  - Relational DB, Hierarchical DB, Flat File DB, Objects DB
  - 주로 사용되는 것이 Relational DB



### DB 구성

- 테이블 : 데이터가 저장되는 방식(2차원 테이블 구조)
  - Tuple(or record) : 열
  - Attribute(행) : 행
  - Schema(도메인과 유사) : 행의 속성
  - Instance() : 



### DBMS의 주요 기능[CRUD]

> **Create**, **Read**, **Update**, **Delete**

- 이러한 기능을 위한 언어가 **SQL**(Structured Query Language)
- IBM에서 만들어 ANSI에서 표준으로 지정

- **C** : insert into 테이블명 [(컬럼명 리스트, ...)] values (데이터값 리스트, ...)
- **U** : update 테이블명 set 컬럼명=컬럼값, ...[where 조건식] 
- **D** : delete [from] 테이블명 [where 조건식]
- **R** : select 컬럼명, ... from 테이블명 [where 조건식] [group by 그룹핑 기준 컬럼] [having 그룹의 조건] [order by 정렬 기준 컬럼, ...]



#### 기타

- sql에서는 등가연산은 **=** 이다.

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