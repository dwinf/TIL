# Hadoop & Spark

- 빅데이터 엔지니어 : 데이터를 보관하고 유지보수하는 시스템을 설치 및 운용
  - 시스템적인 이해도(리눅스)가 필요
  - 하드웨어적 지식(cpu, 메모리)



## 1. Hadoop

> 분산 저장, 분산 처리 시스템

- 하둡 이전에는 대용량 데이터를 한꺼번에 처리할 방법이 없었음
  - 컴퓨터가 처리할 수 있는 용량보다 데이터가 더 크기 때문
  - 따라서 데이터의 일부만 활용
  - 하둡 이후에 빅데이터가 생겨났다
- **HDFS** : A file system to manage the storage of data
  - storage
- **MapReduce** : A framework to process data cross multiple servers
  - computation
- **클러스터** : 여러 대의 컴퓨터들이 연결되어 하나의 시스템처럼 동작하는 컴퓨터들의 집합
- **분산 컴퓨팅 시스템** 



#### Hadoop HDFS 명령어

>  https://hadoop.apache.org/docs/r2.7.7/hadoop-project-dist/hadoop-common/FileSystemShell.html

- hdfs dfs -ls /[디렉토리명 또는 파일명]
  - 지정된 디렉토리의 파일리스트 또는 지정된 파일의 정보를 보여준다.

- hdfs dfs -ls -R /[디렉토리명]
  - 지정된 디렉토리의 파일리스트 및 서브디렉토리들의 파일 리스트도 보여준다.

- hdfs dfs -mkdir /디렉토리명
  - 지정된 디렉토리를 생성한다.

- hdfs dfs -cat /[디렉토리/]파일
  - 지정된 파일의 내용을 화면에 출력한다.

- hdfs dfs -put 사용자계정로컬파일 HDFS디렉터리[/파일]
  - 지정된 사용자계정 로컬 파일시스템의 파일을 HDFS 상 디렉터리의 파일로 복사한다.

- hdfs dfs -get HDFS디렉터리의파일 사용자계정로컬 디렉터리[/파일]
  - 지정된 HDFS상의 파일을 사용자계정 로컬 파일시스템의 디렉터리나 파일로 복사한다.

- hdfs dfs -rm /[디렉토리]/파일
  - 지정된 파일을 삭제한다.

- hdfs dfs -rm -r /디렉토리
  - 지정된 디렉터리를 삭제. 비어 있지않은 디렉터리도 삭제하며 서브 디렉토리도 삭제한다.

- hdfs dfs -tail /[디렉토리]/파일
  - 지정된 파일의 마지막 1kb 내용을 화면에 출력한다.

- hdfs dfs -chmod 사용자허가모드 /[디렉토리명 또는 파일명]
  - 지정된 디렉토리 또는 파일의 사용자 허가 모드를 변경한다. 

- hdfs dfs -mv /[디렉토리]/old파일 /[디렉토리]/new파일
  - 지정된 디렉토리의 파일을 다른 이름으로 변경하거나 다른 폴더로 이동한다.



#### MapReduce 정리

- MapReduce는 데이터를 개별로 가공 및 필터링하거나, 어떤 키값에 기반해 데이터를 분류하거나, 분류한 데이터로 통계치를 계산하는 등, 수많은 데이터 처리에서 사용되고 있는 기법들을 일반화 하고 있다. map() 함수와 reduce() 함수는 한 번에 처리할 수 있는 데이터와 데이터 전달 방법 등이 다르다.

- `map()` 함수는 처리 대상 데이터 전체를 하나씩, 하나씩 처리한다. 처리대상 데이터간에 의존관계가 없고 독립적으로 실행 가능하며 처리나 순서를 고려하지 않아도 되는 처리에 적합하다.(전처리)

- `reduce()` 함수에는 키와 연관된 복수의 데이터가 전달된다. 또한 reduce() 함수에 전달되는 데이터는 키값으로 정렬되어 있다. 그룹화된 복수의 데이터를 필요로 하는 처리 또는 순서를 고려해야 하는 처리에 적합하다.(그룹별 합계)

**map : (K1, V1) -> list(K2, V2)**

**reduce : (K2, list(V2)) -> list(K3, V3)**



## Apache Spark

> 메모리 내 처리를 지원하여 빅데이터를 분석하는 애플리케이션의 성능을 향상시키는 오픈 소스 병렬 처리 프레임워크

- Spark는 대량의 데이터를 고속 병렬 분산 처리한다. 
- 데이터소스로부터 데이터를 읽어 들인 뒤 스토리지 I/O와 네트워크 I/O를 최소화하도록 처리한다. 
- 따라서 Spark는 동일한 데이터에 대한 변환처리가 연속으로 이루어지는 경우와 머신러닝처럼 결과셋을 여러 번 반복해 처리하는 경우에 적합하다



### Spark의 데이터 처리 단위 : RDD 

> RDD (Resilient Distributed Dataset: 내결함성 분산 데이터셋)

- 데이터셋을 추상적으로 다루기 위한 데이터셋
- RDD가 제공하는 API로 변환과 액션 기능을 구현한다.
- Spark 에서 처리되는 데이터는 RDD 객체로 생성하여 처리한다.

​    

#### RDD 객체 생성

​    1. Collection 객체를 만들어서

​    2. HDFS 의 파일을 읽어서

 

#### RDD 객체의 특징

> Read Only(immutable) 

- 1~n 개의 partition 으로 구성 가능
- 병렬적(분산) 처리가 가능하다.
- RDD의 연산은 Transformation 연산과 Action 연산으로 나뉜다.
- Transformation은 Lazy-execution을 지원한다.

- lineage를 통해서 fault tolerant(결함 내성)를 확보한다.



#### RDD를 제어하는 연산

- **Transformation** : RDD에서 데이터를 조작하여 새로운 RDD를 

​          생성하는 함수

- **Action** : RDD에서 RDD가 아닌 타입의 data로 변환하는 하는 함수

- operation의 순서를 기록해 DAG로 표현한 것을 **Lineage**라 부름



#### Transformation과 Action

##### 1. Transformation

- 연산의 수행 결과가 RDD 이면 Transformation

- Transformation 은 기존 RDD를 이용해 새로운 RDD를 생성하는 연산이다. 

 (변환, 필터링 등의 작업들 : 맵, 그룹화, 필터, 정렬...)

- Lineage를 만들어 가는 과정이다. 

##### 2. Action

- 연산의 수행 결과가 정수, 리스트, 맵 등 RDD 가 아닌 다른 타입이면 Action

(first(), count(), collect(), reduce()...)  

- Lineage를 실행하고 결과를 만든다.



### Lazy-execution

>  Action 연산이 실행되기 전에는 Tranformation 연산이 처리되지 않는 것

- Transformation 연산은 관련 메서드를 호출하여 연산을 요청해도 실제 수행은 되지 않고 연산 정보만 보관
  - **Transformation 연산 정보를 보관한 것을 Lineage**(리니지)라고 한다. 
- 보관만 하다가 **첫 번째 Action 연산이 수행될 때 모든 Lineage 에 보관된 Transformation 연산을 한 번에 처리**

- Lazy-execution과 Lineage를 활용함으로써 
  - 처리 효율을 높이고 
  - 클러스터 중 일부 고장으로 작업이 실패해도 Lineage를 통해 데이터를 복구



### 주요 함수

- `parallelize()` : 스칼라컬렉션 객체를 이용해서 RDD 객체를 생성한다.
- `count()` : RDD의 요소 개수를 리턴한다.
- `first()` : RDD 객체의 첫 번째 요소를 리턴한다.
- `collect()` : RDD 객체의 모든 요소를 배열로 리턴한다
- `map()` : 입력 RDD의 모든 요소에 f를 적용한 결과를 저장한 RDD를 반환한다. 
- `flatMap()` : 입력 RDD의 모든 요소에 f를 적용하고 모든 요소들을 하나로 묶어서 반환한다.
- `filter()` : 입력 RDD의 모든 요소에 f를 수행하고 참을 리턴하는 결과만 저장한 RDD를 반환한다.
- `reduce()` : 지정된 f를 수행시켜 입력 RDD의 개수를 축소시켜서 생성된 RDD를 반환한다.



## PySpark

> Apache Spark 기능을 사용하여 Python 애플리케이션을 실행하기 위해 Python으로 작성된 Spark 라이브러리

- Py4JPySpark 내에 통합된 Java 라이브러리
- Python이 JVM 개체와 동적으로 인터페이스 할 수 있음
  - PySpark를 실행하려면 Python과 개발 환경(JDK)도 설치되어 있어야 한다.

- 개발을 위해 Spyder IDE , Jupyter 노트북(랩)과 같은 많은 유용한 도구와 함께 제공되는 Anaconda 배포를 사용하여 PySpark 애플리케이션을 실행할 수 있다.

- PySpark는 대규모 데이터 세트를 효율적으로 처리
  - NumPy, Pandas, TensorFlow를 포함하여 Python으로 작성된 데이터 과학 라이브러리와 함께 많이 사용



### PySpark의 장점

- PySpark는 분산 방식으로 데이터를 효율적으로 처리 할 수 있는 범용 인 메모리 분산 처리 엔진이다.
- PySpark에서 실행되는 애플리케이션은 기존 시스템보다 100 배 빠르다.
- 데이터 수집 파이프 라인에 PySpark를 사용하면 큰 이점을 얻을 수 있다.
- PySpark를 사용하여 Hadoop HDFS, AWS S3 및 여러 파일 시스템의 데이터를 처리 할 수 있다.
- PySpark는 Streaming 및 Kafka를 사용하여 실시간 데이터를 처리하는데도 사용된다.
- PySpark 스트리밍을 사용하면 파일 시스템에서 파일을 스트리밍하고 소켓에서 스트리밍 할 수도 있다.
- PySpark에는 기본적으로 기계 학습 및 그래프 라이브러리가 있다



### PySpark 아키텍처

- Apache Spark는 마스터를 "드라이버"라 하고 슬레이브를 "작업자"라고 하는 마스터-슬레이브 아키텍처에서 작동
- Spark 애플리케이션을 실행하면 Spark Driver가 애플리케이션의 진입점인 컨텍스트를 생성하고 모든 작업 (변환 및 작업)이 작업자 노드에서 실행되고 리소스는 Cluster Manager에서 관리된다.