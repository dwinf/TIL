- HDFS의 대용량 데이터를 **SQL**로 다룰 수 있도록 하는 패키지
- 오픈소스

### 장점
- HDFS 를 대상으로 SQL을 사용할 수 있다.
- Thrift, ODBC, **JDBC** 등 다양한 client 프로토콜을 지원한다.
- 대상 파일의 위치로 다양한 **외부 저장소**를 선택할 수 있다. (HDFS, S3, Azure storage, RDBMS)
- 실행 엔진을 선택할 수 있다. (Mapreduce 또는 **Tez**)
- 다양한 언어의 클라이언트 라이브러리가 나와있다. (Java, Python, C++, Ruby, Javascript 등)

### 단점
- 실행엔진의 종류, 동작방식, 상태에 따라 성능이 정해짐
- 트랜잭션 지원 x
- 쿼리가 상대적으로 느림 -> 실시간에 적합하지 않음

# Hive Architecture

## 1 Hive Client
Python, Java, C++, Ruby 등 다양한 언어로 만들어진 Hive client driver 는 JDBC, ODBC, Thrift driver를 이용해서 hive server 에 쿼리할 수 있다.
- Thrift 는 hive server 1

## 2 Hive Service
Hive service 는 client 로부터 온 요청을 처리한다. 다양한 구성요소로 구성되어있다.

### 1. Hive Server 2
Client의 query를 받아주는 서버이다. JDBC, ODBC, Thrift 프로토콜로 온 요청을 처리할 수 있다. Hive server 1 에서는 하나의 요청밖에 처리하지 못했지만, Hive server 2에서는 동시에 여러 요청을 처리할 수 있게되었다.

### 2. Hive Driver
Driver 에서 HiveQL을 받아준다. 또한 user 의 세션을 관리한다.

### 3. Metastore
테이블, 파티션, 컬럼, HDFS 파일 위치, ser/de 등의 테이블을 읽기 위한 메타데이터를 관리한다.
메타스토어는 내부에 구성할 수도 있고, 외부의 데이터베이스(RDBMS 종류)를 이용할 수도 있다. 클러스터가 HA구성되어 있거나, 데이터나 유저의 양이 많다면 외부 데이터베이스를 메타스토어로 구성하는 것이 좋다.

### 4. Compiler(paser)
Driver로 온 요청에 대해 parsing, semantic analysis, type check 등을 한다.
문제가 없다면 실행 계획(execution plan)을 세운다.
실행 계획은 DAG(directed acyclic graph)형태가 된다.
- DAG 의 각 step 은 map 또는 reduce 작업에 매핑된다.

### 5. Execution Engine
compiler의 결과에 다라서 execution plan 을 진행한다. execution engine 은 선택할 수 있다.
기본은 mapreduce 이다.

### 6. Beeline
JDBC를 이용해서 바로 hive driver 로 연결하는 커맨드라인 클라이언트이다.

## 3. Processing and Resource Management
Hive 는 실행 계획으로 구성된 DAG를 수행할 engine을 선택할 수 있다.
기본으로 MapReduce 프레임워크가 동작한다. 또 다른 쓸만한 선택지로는 Apache Tez 가 있다.

## 4. Distributed Storage
결국 Hive 가 바라보는 파일은 분산 스토리지이다.
쿼리의 실행 전, 과정, 결과로 분산 파일 시스템을 조작하게 된다.

# Hive Query Client
hive shell, workbench나 Datagrip 등 hive를 이용하기 위한 도구들이 있다.
실습에서는 hive beeline을 이용

### Hive shell
- nn에서 hive 명령어로 사용 가능
- 현재는 beeline이 대체

### Hive beeline
- shell 접속
	- `beeline -u jdbc:hive2://localhost:10000/default -n hive`
	- `-n` : username
	- `-p` : password

# Hive Table

## internal/external/temporary table

### 1. internal table
- Hive 가 자신의 데이터를 소유하는 형태
- table의 default값
	- create table 할 때 external table 로 선언해야 external table로 생성됨
- hive 의 전용 경로 하위에 자동으로 생성된다. 
	- /user/hive/warehouse/
	- location 옵션으로 따로 지정
- table 이나 partition을 drop 하면, 해당 경로의 **HDFS 파일 또한 지워진다**.

### 2. external table
- `create external table if not exists [external-table-name]...` 
- 원본 데이터를 hive 가 관리하지 않는다.
- Hive 의 영역 외에도 테이블을 사용하고 싶을 때 사용
	- 웬만하면 사용하게 됨
- HDFS의 경로 뿐만 아니라 **외부의 경로**로도 지정할 수 있다.
	- Federation 된 다른 하둡 클러스터
	- Webhdfs 로 접근가능한 다른 클러스터의 경로
	- Amazon S3, Azure storage 등의 클라우드 스토리지
- partition이나 table 을 drop 하면, **hive 상의 메타데이터에서만 삭제**되고 원본데이터는 영향 없음

### 3. external table 의 단점
- hive 를 통하지 않고 파일을 저장했다면, 해당 파일의 정보를 알 수 있도록 메타정보를 업데이트 해야 함
- 주로 파티션 단위로 데이터를 추가, 삭제하고 메타데이터를 업데이트 한다.
- 새롭게 데이터가 추가되거나 삭제된 경우, alter table 로 할 수 있다.
```sql
-- 추가
alter table table_name add partition (partition1=x, partition2=2, ..)
-- 삭제
alter table table_name drop partition (partition1=x, ...)
```

또한 **msck** 로도 한번에 메타데이터 업데이트가 가능하다.
```sql
MSCK [REPAIR] TABLE table_name [ADD/DROP/SYNC PARTITIONS];
```
- 단, 데이터가 많은 경우 MSCK 가 오래 걸려서 timeout 에 걸리거나 OOM이 날 수 있다.
- **hive.msck.repair.batch.size** 로 내부적인 배치사이즈를 조정해서 OOM을 방지할 수 있다.

### 4. temporary table

해당 hive **session에서만 유지**되는 테이블이다.

보통 select 의 결과를 **임시 테이블**로 만들어서, 새로운 쿼리에서 **참조할 때** 쓰려고 사용한다.

### 5. command

다음 명령어로 internal/external 을 구분할 수 있다.
```sql
DESCRIBE FORMATTED table_name;
show create table table_name;
```

## Format
주로 데이터를 저장하는 쪽은 Hive 를 통하지 않고, 다이렉트로 파일로 쓰는 경우가 많다. 
데이터를 쓰기 전에 스키마만 Hive 를 통해서 조회하는 식이다. (external table)

즉 Hive가 데이터를 저장하려면 저장하는 쪽에서 어떤 형식으로 저장했는지를 알아야, 테이블 정의 스키마에 맞기 파일을 읽을 수 있다. 따라서 **Hive의 테이블 속성에는 무조건 데이터를 어떤 형식으로rp 다루어야 하는지 정보가 필요**하다.

### 하둡에서 자주 사용하는 데이터 포멧
- 기계가 읽을 수 있는 형식
- 여러 디스크에 나눠져 있을 수 있어서 확장 가능한 형식을 가짐
- 파일 자체가 형식을 가짐
	- 별도의 스키마가 없어도 형식에 맞게 읽음
- 대량의 데이터를 읽는데 부하가 적다

### 1. Avro
- row 기반의 바이너리 storage 포맷
	- 데이터의 스키마의 정의는 json
- 데이터 serialization capacity 가 좋다.
- schema evolution 이 가능하고, 유연하다.(테이블 형식의 변화)

### 2. Parqeut
- 빅데이터에 이상적인 columnar storage
	- 데이터 필터링(**map**), aggregation(**reduce**) 의 작업에서 빠르다.
	- 압축 효율이 좋다.
- nested data 구조를 표현할 수 있는 columnar 포맷
	- 성능이 저하될 수 있어서 지양되기도 함

### 3. ORC
- **O**ptimized **R**ow **Columnar** file format을 지향
- 파일 형식 자체에 index 정보가 있어 성능이 좋음
- index 때문에 **스키마의 순서**가 중요

## Partition
하둡을 저장소로 사용하기 때문에 파티션을 필수적으로 사용하게 됨

### hive partition
- Partition을 설정하면, 파티션 필드=값 의 이름으로 디렉토리가 생성
	- external table인 경우 디렉토리 이름이 이와 같아야 한다
- Partition의 순서대로 디렉토리 구조가 hierarchy 로 결정

**EX** : `PARTITIONED BY year, month, day`
```sql
table_path
   L year=2022
       L month=202201
           L day=20220101
```
파티션은 hadoop의 디렉토리 구조로 hierarchy 를 가지기 때문에 사실상 위계관계인 데이터 구조를 partition으로 설정해야 한다. (연> 월> 일)

### 파티션 기준
기본적으론 연, 월, 일 기준. 서비스에 맞게 연, 월, 일 사이 또는 하위에 추가적인 파티션을 추가
파티션은 거의 모든 **쿼리에 조건으로 들어갈 대상**으로 지정.
파티션의 물리적 위치가 계층이 있는디렉토리 구조를 따르기 때문에 **파티션 필드의 순서가 계층구조와 잘 맞아야** 성능이 잘 나옴
하둡은 WORM 에 적합하기 때문에 **어떻게 읽을 지**를 기준으로 파티션을 설정

### 파티션 선언
create table 시에 column 리스트 다음에 다음과 같이 추가
```sql
partitioned by (col_name data_type, col_name2 data_type2, ..)
```

## Bucketing
hive table data model의 마지막 레벨
	- table > partition > bucket

### 특징
파티션 디렉토리 하위에 특정 필드가 같은 값들이 **하나의 파일로 모이도록 hashing**해서 파일로 만드는 작업
선언할 때 어떤 컬럼을 기준으로 hash할 것인지, 총 몇개의 bucket을 만들 것인지 설정

### 장점
- bucketing 한 필드로 필터링하면 locality가 높아짐
	- 같은 값을 가진 필드가 같은 파일에 위치하기 때문
- **파티션의 모든 데이터파일을 접근하지 않아도 된다.**
- 파티션으로 인해 너무 많은 디렉토리가 생기는 것을 방지할 수 있다.
- 데이터 조회시 로드하는 파일의 수가 줄어드므로 부하가 적어진다.

### 주의사항
조회하는 조건이 bucket 에서 사용하는 컬럼보다 다양한 경우, bucket의 효용성이 떨어진다. (random access 가 다양한 쿼리에서 성능의 median 은 더 좋을 수 있다.)

### Bucketing 선언
Create table 시에 partitioned by 다음에 다음과 같이 추가한다.
```sql
CLUSTERED BY (column1, column2, ...) INTO $number BUCKETS
```

# HiveQL
- ANSI SQL과 많이 호환되지만, RDBMS와는 차이가 크다. [공식문서](https://cwiki.apache.org/confluence/display/Hive/LanguageManual) 참고
	- HiveQL은 **PK 가 없음** 

## Create table
### 1. Syntax
```sql
CREATE [TEMPORARY] [EXTERNAL] TABLE [IF NOT EXISTS] [db_name.] table_name
[(col_name data_type [column_constraint] [COMMENT col_comment], ...)]
[PARTITIONED BY (col_name data_type [COMMENT 'col_comment'], ...)] -- partition 필수
[CLUSTERED BY (col_name, col_name,.......] -- bucket
[COMMENT table_comment]
[ROW FORMAT row_format] -- 필수
[FIELDS TERMINATED BY char]
[LINES TERMINATED BY char]
[LOCATION 'hdfs_path'] -- 필수
[STORED AS file_format] -- 필수
```

### EX) airline table
```java
create external table airline
(
Year	int
,Month	int
,DayofMonth	int
,DayOfWeek	int
,DepTime	int
,CRSDepTime	int
,ArrTime	int
,CRSArrTime	int
,UniqueCarrier	string
,FlightNum	int
,TailNum	int
,ActualElapsedTime	int
,CRSElapsedTime	int
,AirTime	int
,ArrDelay	int
,DepDelay	int
,Origin	string
,Dest	string
,Distance	int
,TaxiIn	int
,TaxiOut	int
,Cancelled	boolean
,CancellationCode	char(1)
,Diverted	boolean
,CarrierDelay	int
,WeatherDelay	int
,NASDelay	int
,SecurityDelay	int
,LateAircraftDelay	int
)
ROW FORMAT SERDE'org.apache.hadoop.hive.serde2.OpenCSVSerde' // CSV
STORED AS TEXTFILE
location "hdfs://ha-nn-uri/user/hive/warehouse/default.db/airline" /* same to "warehouse/default.db/airline" */
```
- location 에 namespace 를 포함한 full path 가 없다면, hive 에 로그인한 유저의 경로를 기본 path 로 해서 상대경로에 생성된다.
	- espace 는 core-site.xml, hdfs-site.xml 에서 확인(예시에서는 ha-nn-uri)
	- `hive` user 인 경우 `/user/hive` 가 기본경로
	```sql
show create table airline;
```

## Insert
```sql
INSERT INTO TABLE tablename1 [PARTITION (partcol1=val1, partcol2=val2 ...)] select_statement1 FROM from_statement;
```
- PK가 없으므로 계속 데이터가 append 된다.
- 쿼리 결과를 넣는 용도로 가끔 사용
- 대량의 데이터는 주로 파일로 HDFS에 직접 쌓던가, load 명령어를 통해 넣음
- PK가 없으므로 metadata 를 추가하는 용도로 적합하지 않다.

### EX
```sql
create table emp (
    empno int
    ,user_name string
    ,age int
    ,dept string
);

insert into table emp values (1, "Paul", 24, "engineering");
insert into table emp values (2, "John", 25, "engineering");
insert into table emp values (3, "Nancy", 21, "marketing");
insert into table emp values (3, "Yarn", 29, "engineering");
select * from emp limit 4;
```
- PK가 없으므로 4개의 데이터가 모두 들어간다.


## Load data
HDFS 또는 다른 저장소에 있는 데이터를 table로 **copy**/**move**
```sql
LOAD DATA [LOCAL] INPATH 'filepath' [OVERWRITE] INTO TABLE tablename [PARTITION (partcol1=val1, partcol2=val2 ...)] [INPUTFORMAT 'inputformat' SERDE 'serde'] (3.0 or later)
```
- `load data` 커맨드는 hive 의 table 의 경로로 데이터를 copy/move 하는 것이므로 주의한다.
- inpath 가 같은 hdfs 라면 원본 데이터를 move

### EX
```sql
LOAD DATA INPATH '/data/input' INTO TABLE airline INPUTFORMAT 'textfile' SERDE'org.apache.hadoop.hive.serde2.OpenCSVSerde';
```
- 조회
```sql
select year, month, dayofmonth as day, origin, deptime, dest, arrtime, distance, ActualElapsedTime as elapsed_t
from airline
limit 3;
```
이후 실습을 위해 원본을 복원
```bash
#!/bin/bash
from="/user/hive/warehouse/default.db/airline/*.csv"
to="/data/input"
hdfs dfs -cp $from $to/
```

## Select

Select 는 일반 SQL과 사용법이 유사하다.  [매뉴얼](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+Select) 
```sql
[WITH CommonTableExpression (, CommonTableExpression)*]    (Note: Only available starting with Hive 0.13.0)
SELECT [ALL | DISTINCT] select_expr, select_expr, ...
  FROM table_reference
  [WHERE where_condition]
  [GROUP BY col_list]
  [ORDER BY col_list]
  [CLUSTER BY col_list
    | [DISTRIBUTE BY col_list] [SORT BY col_list]
  ]
 [LIMIT [offset,] rows]
```
- 단, 정렬되어있지 않은 데이터를 조회하면 데이터 조회가 오래 걸린다.
- **execution engine** 과 관련된 설정이 성능에 큰 영향을 미친다.
	- Mapreduce / Tez
- **즉각적인 응답**을 요하는 작업에는 적합하지 않다.
- 대량의 데이터가 저장되어있기 때문에 **LIMIT** 을 사용하는 것을 권장

### EX
```sql
select DepDelay, year, month, dayofmonth as day, origin, deptime, dest, arrtime, distance 
from airline 
where Year=2008 
and DepDelay > 0 
order by DepDelay desc 
limit 10;
```

## Update, Delete
```sql
UPDATE tablename SET column = value [, column = value ...] [WHERE expression]
```
- where 조건에 맞는 대상을 모두 업데이트/삭제 하므로, where 조건을 주의해야 한다.
- hive 에는 unique key 가 없으므로 **단일 row의 update/delete 는 불가능**하다.
- Partitioning, Bucketing 컬럼은 업데이트/삭제 할 수 없다.
	- add/drop partition 을 써야한다.
- hive transaction 과 ACID를 지원하는 경우에만 사용할 수 있다.
	- 사실상 사용할 수 없다.


## Alter Table
- Alter table 을 통해서 table 의 속성이나 schema, partition 정보 등을 변경할 수 있다.
- Alter table 은 **테이블의 속성을 변경**하는 것인만큼 주의해서 사용해야한다. [매뉴얼](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL#LanguageManualDDL-RenameTable) 
	- 대상 데이터가 과다할 경우 부하를 많이 주거나 실패할 수 있음

### rename table
```sql
ALTER TABLE table_name RENAME TO new_table_name;
```
```sql
ALTER TABLE emp RENAME TO emp_2;
show create table emp_2;
show create table emp;
```

### change column
- column의 이름 변경
```sql
ALTER TABLE table_name [PARTITION partition_spec] CHANGE [COLUMN] col_old_name col_new_name column_type
  [COMMENT col_comment] [FIRST|AFTER column_name] [CASCADE|RESTRICT];
```
- 타입변경은 replace column 을 해야한다.
```sql
alter table emp_2 change column empno emp_no int;
```

### add/replace column
```sql
ALTER TABLE table_name 
  [PARTITION partition_spec] -- (Note: Hive 0.14.0 and later)
  ADD|REPLACE COLUMNS (col_name data_type [COMMENT col_comment], ...)
  [CASCADE|RESTRICT] -- (Note: Hive 1.1.0 and later)
```
- replace columns 에서는 **모든 column 정보를 삭제 후 다시 만드는 작업**이다.
	- 따라서 모든 column의 정보를 입력해줘야 함
	- drop column 을 위해 사용하기도 한다.
	- column 의 타입 변경이 필요할 때 사용한다.

	```sql
alter table emp_2 add columns (adding string);
```
	```sql
alter table emp_2 replace columns (emp_no bigint, user_name string, age int, dept string);
```
	```sql
show create table emp_2;
select * from emp_2 limit 5;
```
	```sql
alter table emp_2 replace columns (emp_no bigint, user_name string, age int, dept string);
```
	```sql
show create table emp_2;
select * from emp_2 limit 5;
```

### add partition

다음 script 로 /data/input 에 있는 연도별 데이터를 파티션 디렉토리 구성에 맞게 copy한다.
```bash
#!/bin/bash
hdfs dfs -mkdir /user/hive/warehouse/default.db/airline_partition

for year in {1987..2008}
do
        hdfs dfs -mkdir /user/hive/warehouse/default.db/airline_partition/year=${year}
        hdfs dfs -cp /data/input/${year}.csv /user/hive/warehouse/default.db/airline_partition/year=${year}/${year}.csv
done
```
table 을 선언한다.
```sql
create external table airline_partition
(
Month	int
,DayofMonth	int
,DayOfWeek	int
,DepTime	int
,CRSDepTime	int
,ArrTime	int
,CRSArrTime	int
,UniqueCarrier	string
,FlightNum	int
,TailNum	int
,ActualElapsedTime	int
,CRSElapsedTime	int
,AirTime	int
,ArrDelay	int
,DepDelay	int
,Origin	string
,Dest	string
,Distance	int
,TaxiIn	int
,TaxiOut	int
,Cancelled	boolean
,CancellationCode	char(1)
,Diverted	boolean
,CarrierDelay	int
,WeatherDelay	int
,NASDelay	int
,SecurityDelay	int
,LateAircraftDelay	int
)
PARTITIONED BY (year int)-- 기존 airline 테이블과 다른 점
ROW FORMAT SERDE'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
location "hdfs://ha-nn-uri/user/hive/warehouse/default.db/airline_partition" /* same to "warehouse/default.db/airline" */
;
```

데이터를 조회해본다.
```sql
select year, month, dayofmonth as day, origin, deptime, dest, arrtime, distance, ActualElapsedTime as elapsed_t
from airline_partition
limit 3;
```

add partition
```sql
ALTER TABLE airline_partition ADD PARTITION (year='1987') location '/user/hive/warehouse/default.db/airline_partition/year=1987';
```
- external table의 경우 메타가 바뀌어도 hive가 알지 못하기 때문에 알도록 해줌
- 이 상태로는 1987 이외의 연도는 인식하지 못함
	- MSCK 사용

다시 조회해본다.
```sql
select year, month, dayofmonth as day, origin, deptime, dest, arrtime, distance, ActualElapsedTime as elapsed_t
from airline_partition
limit 3;
```

1987 이 아닌 다른 year 조건으로 조회해본다.
```sql
select year, month, dayofmonth as day, origin, deptime, dest, arrtime, distance, ActualElapsedTime as elapsed_t
from airline_partition
where year=2008
limit 3;
```

## MSCK
external table 인 경우, 데이터의 변경사항이 hive table 에 실시간으로 반영되지 않는다. 그동안 **업데이트된 데이터를 한 번에 hive 테이블에 반영**하고 싶을 때, MSCK를 쓴다.

주의할 점은, 데이터가 많으면 MSCK 작업이 오래걸릴 뿐만 아니라 **부하** 때문에 **OOM**으로 죽을 수도 있다.

이 경우 partition 별로 나누어서 수행하거나, batch.size 를 설정한다.
```sql
MSCK [REPAIR] TABLE table_name [ADD/DROP/SYNC PARTITIONS];
```

### batch.size
조회
```sql
set hive.msck.repair.batch.size;
```
- 0이라면 batch.size 가 없다.(무제한)

세팅
```sql
set hive.msck.repair.batch.size=$num;
```

### msck 수행

앞서서 추가하지 못한 남은 파티션을 msck 로 추가한다.
```bash
set hive.msck.repair.batch.size=3;
msck repair table airline_partition;
```

다시 조회해본다.
```sql
select year, month, dayofmonth as day, origin, deptime, dest, arrtime, distance, ActualElapsedTime as elapsed_t
from airline_partition
where year=2008
limit 3;
```
5.4.1 실습 쿼리를 다시 수행해보고, 조회 속도를 비교해본다.

## TEZ
- MR의 단점을 보완하여 map, reduce 작업을 더 빠르게 수행하는 엔진

### hive engine setting
```sql
set hive.execution.engine;
```
- hive 2.0 이후부터는 tez가 default

변경
```sql
set hive.execution.engine = mr;
set hive.execution.engine = tez;
set hive.execution.engine = spark;
```
