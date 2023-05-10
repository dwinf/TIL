
# Hadoop
> Open Source

google, yahoo 등 웹 검색엔진의 개발이 활발하던 시기. 
어느정도 발달해서 너도나도 웹페이지를 가질 정도로 대중화되어 사용자 수가 폭증하며 데이터가 기하급수적으로 증가. 
데이터 활용을 위해 그 처리 기술이 필요. 
RDBMS 에 저장하기에는 데이터의 타입이 적절치 못함(비정형데이터, 웹 로그 등) + 데이터의 크기가 너무 큼 + RDBMS에 저장하기에는 대용량, 고스펙의 장비를 쓰기에는 비용적 문제.

하둡의 경우 고스펙의 장비가 필요X. 
x86 리눅스 서버면 장비의 수준과 무관하게 설치하여 운용 가능
commodity server : 누구나 쓸 수 있을만큼 값싼 장비
용량이 커져도 단순 스케일아웃으로 충분 + 재구성, 재설치 필요x
데이터의 복제본(3copy)라서 유실 및 장애에도 복구 가능

데이터가 여러 대의 서버에 저장되기 때문에 프로세싱을 분산된 서버에서 동시에 처리
**EX**
- 08년 뉴욕 타임즈의 130년 분량의 신문기사 1100만 페이지를 aws의 ec2, s3, hadoop을 이용해 **하루만에 pdf로** 변환 -> **200만원**
	- 당시 일반 서버에서 일반적인 병렬처리(멀티 스레딩)로는 14년 소요

## Hadoop의 특징
1.  _Scalable: Hadoop can reliably store and process petabytes._
2.  _Economical: It distributes the data and processing across clusters of commonly available computers. These clusters can number into the thousands of nodes._
3.  _Efficient: By distributing the data, Hadoop can process it in parallel on the nodes where the data is located. This makes it extremely rapid._
4.  _Reliable: Hadoop automatically maintains multiple copies of data and automatically redeploys computing tasks based on failures._

## Hadoop 생태계
hadoop1 : mr(RM + data processing) + hdfs
hadoop2 : mr + **yarn**(RM) + hdfs
![](https://user-images.githubusercontent.com/73389275/231315460-b4020669-61e8-4ab2-ab11-d85dfd58819e.png)

hadoop3
![](https://user-images.githubusercontent.com/60086878/111483142-de938580-8777-11eb-92c6-7527eeb4fdeb.png)
이 외에도 너무 많은 에코들이 만들어짐

### Yarn
mr + tez, flink, spark 분산처리를 위한 프레임워크나 도구들이 컴퓨팅 자원을 더 쉽게 이용할 수 있게 됨.
resource manager의 역할을 하기 때문에

### Winner Takes All
대용량 데이터를 다루는 것은 기술적인 난이도가 높을 뿐만 아니라, 하드웨어/소프트웨어와의 호환성 등으로 개발 공수가 크다. 또한 데이터가 많은 만큼 버그로 인한 사이드 이펙트 또한 커서, 안정적으로 사용하기 위해서는 **성숙에 드는 시간**이 필요하다. 하둡은 이 성숙의 과정을 거쳐오며 발전한 에코시스템인 만큼, 대용량 시스템에서 하둡을 대체할만한 대체자가 나오기 쉽지 않다. 이로 인해 새로운 대용량 분산시스템이 등장할 때에도 하둡 생태계를 지원하는 방향으로 기술 개발이 이루어지고 있다

# HDFS
## HDFS의 Design  Goal
### 1. Hardware Failure
하드디스크 오류로 데이터 저장 실패, 디스크 복구가 불가능해 데이터가 유실, 네트워크 장애가 생겨 특정 분산 서버에 네트워크 접근이 안되는 등 다양한 장애가 발생할 수 있음
hdfs는 장애를 빠른 시간에 감지하고 대처할 수 있도록 설계됨
데이터를 저장하면 복제본도 저장되어 유실을 방지하고, health check를 통해 장애를 빠르게 감지 및 대처

### 2. streaming data access
hdfs는 random access를 고려하지 않음. 배치 처리에 더 맞도록 디자인됨
대신 Straming 방식으로 데이터를 접근하도록 설계. hdfs명령어 혹은 api를 통해 연속된 흐름으로 데이터에 접근

### 3. large data sets
하나의 파일이 gb ~ tb 수준의 데이터 크기로 저장될 수 있게 설계.
높은 데이터 전송 대역폭을 지원하고 하나의 클러스터에 수백대의 노드를 구성 가능
하나의 인스턴스에 수백만개 이상의 파일을 지원

### 4. simple coherency model
데이터의 무결성은 데이터의 입력이나 변경을 제한해서 데이터의 안정성을 깨는 동작을 막는 것.
hdfs는 write once read many access model
한번 저장한 데이터는 수정할 수 없고 읽기만 가능토록 해서 무결성을 지킴
현제는 end of file 위치에 append는 가능

### 5. moving computation is cheaper than moving data
데이터가 있는 곳으로 computing 자원을 이동(Yarn)
이를 통해 비용을 감소시킴

### 6. Portability across heterogeneous hardware and software platforms
hw/sw 플랫폼을 옮길 수 있도록 디자인됨
자바로 구현되어 있기 때문에 환경에 독립적

## HDFS Architecture - Block based file system

### 2.2.1 Block based file system 이란?

HDFS는 블록 구조의 파일 시스템이다. HDFS에 저장되는 모든 파일은 일정 크기의 블록으로 나눠져서 여러 서버에 분산되어 저장된다. 블록 크기는 기본 128MB로 되어있고, 설정으로 변경이 가능하다. 블록단위로 분산해서 저장하기 때문에 로컬 디스크보다 큰 규모의 데이터를 저장할 수 있고, 저장할 수 있는 용량을 페타바이트 단위까지 확장할 수 있다.

### 2.2.2 파일과 Block

1.  하나의 파일은 하나 또는 복수의 block 에 저장된다. 이때 어떤 파일이 어느 블록에 저장되어있는지는 메타데이터로 **namenode**가 메모리에서 관리한다.
2.  **복수의 파일이 하나의 block에 저장될 수 없다.** 
3.  하나의 File의 사이즈가 block size 를 넘어가면, 여러개의 블록에 나누어 저장된다.
    1.  예 1) 하나의 파일 사이즈가 128MB+10bytes 라면, 128MB 블록 하나, 10bytes 블록 하나에 나뉘어 저장된다.
4.  하나의 File 사이즈 또는 하나의 블록 사이즈를 초과하는 크기의 하나의 파일이 블록 사이즈로 딱 나누어떨어지지 않아서 남은 사이즈가 하나의 블록 사이즈보다 작다면, 해당 블록은 그 크기만큼 점유한 블록으로 관리된다.
    1.  예 1) 하나의 파일이 1MB이고 블록사이즈가 128MB라면, 128MB 블록 하나에 할당되어 1MB만 저장된다.
    2.  예 2) 하나의 파일이 129MB이고 블록 사이즈가 128MB라면, 해당 파일은 128MB 블록 한개, 1MB 블록 한개에 구성된다.
5.  실제 디스크를 점유하는 공간은 블록 내에 파일이 차지하는 크기이다.
    1.  예) 블록 사이즈 128MB이고, 할당된 파일의 사이즈가 1MB 이라면, 실제 디스크 사용량은 1MB이다.

### 2.2.3 Block system의 장점

Block 크기를 적당한 수준(64MB, 128MB) 으로 고정해서 얻을 수 있는 장점은 다음과 같다.

1.  Disk Seek time 감소
    
    디스크 탐색 시간 = seek time (데이터의 위치) + search time (데이터의 섹터에 도달). 하둡 개발 당시의 일반적인 HDD의 disk seek time은 10ms, disk I/O bandwidth 는 100MB/s 였다. HDFS는 seek time 이 bandwidth 의 1% 사용하는 것을 목표로 했다. 따라서 100MB를 넘지않고 2^n 으로 가까운 64MB 를 선택했다. (Hadoop v1 은 64MB였다.)
    
2.  Metadata size 감소
    
    namenode 는 블록 위치, 파일명, 디렉토리 구조, 권한 정보 등의 메타데이터 정보를 메모리에서 관리한다. 예를 들어 블록 사이즈가 128MB이라면, 200MB의 파일에 대해 2개 블록에 해당하는 메타데이터만 저장하면 된다. 하지만 일반적인 파일시스템은 블록(page) 크기가 4k~8k이기 때문에 동일한 크기의 파일을 저장할 경우 훨씬 많은 메타데이터가 생성된다. 200MB의 파일에 대해서 만약 블록 크기가 4k 이라면, 5만개의 블록이 생성되고 메타데이터 또한 5만개 분을 하나의 namenode에서 관리해야한다. namenode는 모든 메타데이터를 관리하는 단일 서버이므로 이렇게 메타데이터의 양이 늘어나는 것은 성능과 HDFS 안정성에 심각한 영향을 미친다.
    
    -   namenode는 일반적으로 100만개 블록을 저장할 경우, 1GB의 heap memory를 사용한다.
3.  Communication cost between Client and NameNode
    
    클라이언트는 HDFS에 저장된 파일을 접근할 때, namenode에 먼저 해당 파일을 구성하는 데이터 블록의 위치를 조회한다. 데이터 블록이 작아서 그 갯수가 많다면, 이 조회에서 필요한 데이터가 많아지거나 조회 횟수가 증가할 것이다. 클라이언트는 스트리밍 방식으로 데이터를 읽고 쓰기 때문에 특별한 경우를 제외하면 namenode 와 통신할 필요가 없다.
    

## 2.3 HDFS Architecture - Name Node and Data Node

### 2.3.1 Overview

![image](https://user-images.githubusercontent.com/73389275/231320994-8f92394c-2da8-4c2b-b56a-88c7bca26eeb.png)

### 2.3.2 Name node

네임노드는 블록의 위치, 권한 등의 정보를 유지한다. 기본적으로는 모든 현재 정보는 메모리에 유지하고, 두 종류의 파일로도 기록한다.

-   **Fsimage:** File System Image 이다. name node 가 생성된 이후로부터의 HDFS의 namespace 정보를 모두 가지고 있다.
-   **Edit log:** Fsimage 로부터 현재까지의 변경사항 로그이다.

Name node 는 다음과 같은 기능과 역할을 한다.

1.  Metadata Management
    
    파일 시스템을 유지하기 위한 메타데이터를 관리한다. 메타데이터는 파일 시스템 이미지(file name, directory, size, access/auth control)와 파일에 대한 블록 매핑 정보로 구성된다. 클라이언트에게 빠르게 응답해야 하므로 메모리에서 데이터를 관리한다.
    
    File system namespace의 모든 변경사항을 관리한다.
    
2.  Data Node Management
    
    Data Node 의 리스트를 관리, 유지, 변경 한다. 명시적인 admin 명령 또는 Monitoring 결과에 따라 대상을 변경한다.
    
3.  Data Node Monitoring
    
    데이터노드는 네임 노드에게 3초마다 heart beak 를 전송한다. heart beat 는 데이터노드 상태 정보와 데이터노드에 저장되어있는 블록의 목록(block report)으로 구성된다. 네임노드는 heart beat 데이터를 기반으로 데이터노드의 실행 상태, 용량 등을 관린한다. 그리고 일정 기간동안 heat beat 를 전송하지 않는 데이터 노드는 장애가 발생한 서버로 판단한다.
    
4.  Block Management
    
    네임노드는 블록에 대한 정보를 관리한다. 장애가 발생한 데이터 노드를 발견하면, 해당 데이터 노드에 위치한 블록을 새로운 데이터 노드로 복제한다. 또한 용량이 부족한 데이터노드가 있다면, 용량의 여유가 있는 데이터 노드로 블록을 이동시킨다. 복제본의 수를 관리해서, 복제본의 수와 일치하지 않는 블록이 있다면 블록을 추가로 복제하거나 삭제한다.
    
5.  Client request
    
    클라이언트가 HDFS에 접근할 때 언제나 네임노드에 먼저 접속한다. 파일을 저장하는 경우, 기존 파일의 저장 여부, 권한 체크 등을 한다. 파일을 조회하는 경우 실제 블록의 위치정보를 반환한다.
    

### 2.3.3 Data Node

데이터노드는 클라이언트가 HDFS에 저장하는 파일을 디스크에 유지한다. 저장하는 파일은 크게 두 종류이다.

-   실제 데이터인 로우(raw) 데이터
-   chekcsum, created time 등 메타데이터가 설정된 파일

DataNode의 기능

1.  client 로부터 실제데이터의 read/write request 를 받아 처리한다.
2.  Name Node로부터 명령을 받아서 자신의 디스크에 있는 block을 생성, 복제, 삭제를 수행한다.
3.  HDFS 의 상태를 Name Node에게 heart beat 로 보낸다.
4.  자신이 가진 block들의 리스트와 상태를 Name Node 에게 보낸다.

## 2.4 HDFS Architecture - Replication

### 2.4.1 Block size 와 replication factor

HDFS는 여러대의 서버로 이루어진 클러스터에 큰 크기의 파일들을 신뢰성있게 저장하도록 디자인 되어있다. 각 파일의 내용은 여러개의 block의 리스트로 저장한다. 각 블록은 fault tolerance (고장 감내성)을 위해서 복제된다. 각 파일마다 block size 와 replication factor 가 지정된다.

하나의 파일의 모든 블록은 마지막 블록을 제외하고는 모두 같은 사이즈이다.(기본128MB) 단, 가변 길이 블록에 대한 지원이 append 와 hsync에 대해서는 가능해서 마지막 블록을 채우지 않고도 새 블록을 시작할 수 있다.

어플리케이션은 파일의 replica 수를 지정할 수 있다. 이것을 replication factor 라고 한다. replication factor 는 파일 생성 시점에 정해지고, 생성 이후에 변경할 수도 있다. HDFS의 파일들은 (append, truncate 를 제외하면) 한 순간에 하나의 writer 만 존재할 수 있다.

블록의 replication 에 대한 결정은 namenode 가 한다. namenode 는 주기적으로 datanode 로부터 heart beat 와 block report를 받는다. heart beat 는 datanode의 기능이 정상적으로 작동중인지를 알린다. blockreport 는 해당 데이터노드에 있는 모든 block 의 리스트 정보를 포함하고 있다.

### 2.4.2 The purpose of Replica Placement

replica 의 위치는 HDFS의 신뢰성(reliability)과 성능(performance)에 큰 영향을 미친다. replica 위치에 대한 최적화 규칙이 HDFS 와 기존의 다른 분산 파일시스템과의 가장 큰 차이점이기도 하다. 이 기능에 많은 경험과 튜닝이 녹아있다. replica placement와 관련된 모든 정책은 data reliability, availability, network bandwidth utilization 을 개선하는 방향으로 이루어진다. 그 중 가장 첫번째 대표적인 것이 rack-aware replica placement이다.

### 2.4.3 Rack-Awareness

![image](https://user-images.githubusercontent.com/73389275/231321052-9c3f75c1-1309-4341-8409-371eed3faa79.png)

[](https://data-flair.training/blogs/wp-content/uploads/sites/2/2020/02/hadoop-cluster.jpg)[https://data-flair.training/blogs/wp-content/uploads/sites/2/2020/02/hadoop-cluster.jpg](https://data-flair.training/blogs/wp-content/uploads/sites/2/2020/02/hadoop-cluster.jpg)

대용량 HDFS 클러스터에 존재하는 computing instance 들은 통상 많은 서버 랙(rack)에 위치한다. 서로 다른 두 개의 랙에 위치한 두 개의 서버는 랙마다 존재하는 switch 를 거쳐서 통신 하게 된다. 이 때, network bandwidth 는 같은 랙에 있는 다른 서버와 통신할 때보다 더 증가하게 된다.

Hadoop Rack Awareness 를 통해 namenode 는 각 datanode 의 rack id 를 알고 있다.

replica 를 위치시는 가장 간단한 정책은, 하나의 replica 는 unique rack 에 존재하도록 하는 것이다. 이것은 하나의 rack 이 통째로 장애가 났을때를 대비해서 데이터의 유실을 방지해준다. 또한 이 정책은 replica 들을 전체 랙에 골고루 분산하도록 유도하기 때문에 클러스터 전체의 부하를 분산(load balance)하는 효과도 쉽게 가져갈 수 있다. 하지만 이 정책은 write 시 여러개의 rack 걸쳐서 block 데이터를 전파해야 하므로 write operation의 비용(cost)를 증가시킨다.

### 2.4.4 Block Placement Policy Default

![image](https://user-images.githubusercontent.com/73389275/231321131-5d9a3edd-9bde-4903-a9b7-dfc8dafa8b93.png)

[](https://data-flair.training/blogs/wp-content/uploads/sites/2/2020/02/HDFS-rack-awareness.jpg)[https://data-flair.training/blogs/wp-content/uploads/sites/2/2020/02/HDFS-rack-awareness.jpg](https://data-flair.training/blogs/wp-content/uploads/sites/2/2020/02/HDFS-rack-awareness.jpg)

대부분의 경우 replication factor=3 이다. 이때의 HDFS 의 기본 placement policy(BlockPlacementPolicyDefault)는 다음과 같다.

1.  하나의 replication 은 가능한한 writer 와 같은 rack 에 있는 datanode에 저장하도록 한다.
    
    1-1. 만약 writer 가 하나의 데이터노드에서 동작한다면, 기본적으로 하나의 replica 는 해당 데이터노드의 local에 저장하도록 한다.
    
    1-2. 만약 writer 가 데이터노드에 있는 것이 아니라면, writer 가 동작하는 노드와 같은 rack 에 있는 datanode를 random 하게 선택해서 저장한다.
    
2.  나머지 두 개의 replica 는 writer와 다른 랙의 서로 다른 두 datanode 에 저장되도록 한다.
    
    따라서 총 unique rack 의 수는 2이다.
    

이 정책은 다음과 같은 장점이 있다.

1.  write 시 rack 들간에 발생하는 traffic을 줄여서 write 성능을 높인다.
2.  만약 node failure의 가능성보다 rack failure 의 가능성이 낮다면, 이 정책은 data reliability and availability guarantees 에 영향을 미치지 않는다.

다음과 같은 단점이 있다.

1.  총 network bandwidth을 줄이지는 못한다. (replica 별로 unique rack 에 위치시키는 것과 비교해서)
2.  데이터가 rack 들 사이에 골고루 분산되지 못한다. 1:2로 위치하므로

만약 replication factor 가 3보다 크다면 4번 째 replica 는 다음 정책을 따른다.

1.  다음 복제본은 랙당 복제본 수를 상한선 보다 낮게 유지하면서 무작위로 결정된다.
    1.  상한선 = (replicas - 1) / racks +2

namenode 는 기본적으로 하나의 datanode 가 같은 블록에 대해서 여러개의 replica 를 갖는것을 허용하지 않는다. 따라서 하나의 블록이 가질 수 있는 최대 replica 수는 총 datanode 수와 같다.

[Storage Types and Storage Policies](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/ArchivalStorage.html) 정책이 추가된 이후로, namenode 는 replica placement 규칙에 rack-awareness 에다가 추가적인 정책을 고려한다.

1.  rack awareness 를 1순위로해서 replica 가 위치할 노드를 고른다. - 후보 노드가 된다.
2.  후보 노드가 policy 에 의한 storage 를 필요로하는지 체크한다.
3.  후보 노드가 해당하는 storage type 을 가지고 있지 않다면, namenode는 다른 후보노드를 찾는다.
4.  위 과정으로 replica 가 위치할 노드를 찾지 못한다면, fallback storage type 을 가진 노드를 찾는다.

추가로 4 종류의 pluggable policies 가 있다.

-   [](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/HdfsBlockPlacementPolicies.html)[https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/HdfsBlockPlacementPolicies.html](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/HdfsBlockPlacementPolicies.html)

### 2.4.5 **Replica Selection - Read**

글로벌 bandwidth 소비를 줄이고, read latency 를 줄이기 위해서 HDFS는 read 요처에 대해서 reader 와 가까운 곳에 있는 replica 로부터 데이터를 읽도록 시도한다. reader node 와 같은 rack 에 replica 가 존재한다면, 해당 read 요청은 그 replica 에서 데이터를 읽는다. 만약 HDFS 클러스터가 여러 데이터센터에 걸쳐져 있다면, 같은 데이터센터에 있는 replica 를 읽는 것을 선호한다.

### 2.4.6 **Safemode**

namenode 가 최초로 기동될 때 namenode 는 `Safemode` 라는 특별한 상태에 들어간다. 이 Safemode 에서는 replication 이 발생하지 않는다.

Datanode 로부터 받은 blockreport 의 내용을 종합해서 모든 블럭에 대한 replication 이 일정 수준(%)을 넘어서 잘 구성되어있다면, 그 때 이 `Safemode` 에서 빠져나온다. 이 % 값은 변경이 가능하다. Safemode 에서 빠져나온 뒤에, 모자란 replication factor가 있는 블록이 있다면 복제를 수행한다.

## 2.5 HDFS Architecture - File Read/Write

### 2.5.1 Read Process

![image](https://user-images.githubusercontent.com/73389275/231321172-538e20c8-488b-4587-a25e-792c73f95d06.png)
[](https://bigdatapath.files.wordpress.com/2018/05/11.png)[https://bigdatapath.files.wordpress.com/2018/05/11.png](https://bigdatapath.files.wordpress.com/2018/05/11.png)

1.  클라이언트가 DistributedFileSystem object의 open() 메소드로 HDFS 파일을 읽겠다는 요청을 시작한다.
    
2.  DistributedFileSystem은 RPC로 namenode 에 연결한다. open 대상이 되는 파일의 메타데이터를 조회한다. 메타데이터 안에는 해당 파일이 저장되어있는 block의 location 정보 등이 있다. 한 번에 모든 블록정보를 리턴하지 않고 처음 몇개의 블록의 주소를 리턴한다.
    
3.  메타데이터 요청에 대한 응답으로 해당 블록(copy본 포함)을 가진 datanode 들의 주소가 리턴된다.
    
4.  받은 DataNode 주소정보로 FSDataInputStream 객체를 만들어 client에게 전달된다. FSDataInputStream는 DataNode 와 NameNode 와 상호작용할 수 있는 DFSInputStream을가지고 있다. client가 DFSInputStream에 대해 read() 메소드를 호출하고 대상 파일의 첫 번째 블록이 있는 datanode 와 connection 을 맺는다. 이때 연결하는 대상은 primary datanode로, 가장 가까운 데이터 노드를 찾는다.
    
    1.  예1 - Local Block First
        
        block A가 datanode 1 에 primary 버전이 있고 datanode 2,3 에 replica 버전이 있다고 했을때, datanode2 에 위치한 client 에서 block A 에 대해 read 요청이 온다면, 자신의 로컬인 datanode 2의 replica 버전에서 데이터를 읽는다.
        
    2.  예2 - Rack Awareness
        
        block A가 rack a에 위치한 datanode 1 에 primary 버전이 있고 rack b에 위치한 datanode 2, rack b에 위치한 datanode 3 에 replica 버전이 있다고 했을때, rack2 에 위치한 datanode 4에 있는 client 에서 block A 에 대해 read 요청이 온다면, 자신과 같은 rack2 에 위치한 datanode 2의 replica 버전에서 데이터를 읽는다.
        
5.  데이터는 read() 메소드를 반복해서 호출할때마다 stream 형태로 리턴된다. read과정은 end of block 에 도달할 때까지 지속된다.
    
6.  end of block 에 도달하면, DFSInputStream은 datanode 와의 연결을 끊고, 해당 파일의 다음 블록이 위치한 데이터 노드와 연결을 맺는다. 이 과정은 해당 파일의 모든 블록을 읽을 때까지 계속된다.
    
7.  read 과정이 끝나면 client 는 close() 로 모든 연결과 스트림을 닫고 끝낸다.
    

### 2.5.2 Write Process

![image](https://user-images.githubusercontent.com/73389275/231321200-15b14cca-c65d-4b9e-abc6-8dba61a8dea5.png)
[](https://bigdatapath.files.wordpress.com/2018/05/2.png)[https://bigdatapath.files.wordpress.com/2018/05/2.png](https://bigdatapath.files.wordpress.com/2018/05/2.png)

1.  새로운 파일 생성은 클라이언트가 DistributedFileSystem object 에서 create() 메소드 호출로 시작한다.
2.  DistributedFileSystem object 는 RPC로 namenode에 연결하고, 새로운 파일 생성을 시작한다. 이때 namenode 은 새로운 파일 생성 요청에 대한 verification을 진행한다. verification 은 파일이 이미 존재하는지, 해당 경로에 대한 권한 등을 확인한다. 이 때 verification 에서 실패하면 client에서는 IOException이 던져진다. verification에 성공하면 namenode 에서 해당 파일 record 가 생성된다.
3.  namenode 에서 파일 record 가 생성되면 클라이언트에 FSDataOutputStream object 가 리턴된다. FSDataOutputStream로 write 를 수행한다.
4.  FSDataOutputStream은 datanode 와 namenode 와 상호작용할는 DFSOutputStream 을 가지고 있다. DFSOutputStream은 클라이언트가 데이터를 write 하기 위한 packet을 만든다. 해당 packet 은 DataQueue 에 들어간다.
5.  DataStreamer는 또한 NameNode에 새 블록 할당을 요청하고, 복제에 사용할 바람직한 DataNode를 선택한다.
6.  복제 과정은 DataNode들로 파이프라인을 생성하면서 시작한다. 위 그림의 경우 복제 수준을 3으로 선택했기 때문에 파이프라인에 3개의 DataNode가 있다.
7.  DataStreamer 는 DataQueue 로부터 데이터를 consume 해서 파이프라인의 첫번째 datanode 에 저장할 패킷을 전송한다.
8.  하나의 파이프라인으로 묶인 모든 데이터노드는 저장을 위해 받은 packet 을 모두 저장하고, 이것을 파이프라인의 다음 데이터노드로 foward 한다.
9.  DFSOutputStream의 Ack Queue는 DataNodes로부터 acknowledgement 을 받으면 저장되는 queue이다.
10.  파이프라인의 모든 데이터노드로부터 ack 가 queue 에 들어오면, Ack Queue 는 삭제된다. 만약 하나의 datanode 라도 데이터 저장과 ack 전송에 실패하면, Ack Queue 에 받은 패킷정보를 보고 재시작을 할 수 있다.
11.  클라이언트의 write 작업이 끝나면, close() 메소드가 호출된다. close 는 모든 남은 data packet 을 flush 하고 ack 를 기다린다.
12.  마지막 ack가 도착하면 클라이언트는 namenode에 write 작업이 끝났음을 알린다.

# 3 Hadoop Name Node HA

## 3.1 HDFS Name Node HA가 필요한 이유

Hadoop v1.x 버전 까지는 namenode 는 SPOF(single point of failure)였다. Hadoop 의 기본 아키텍처는 namenode를 master, datanode 들을 slave 로 하는 master-slave 구조이다. 이 중 namenode 는 하나의 인스턴스, datanode 는 수평적 확장이 가능했으므로 namenode는 bottleneck 이 되기 쉬웠다. namenode 가 이용 불가능한 상태라면, datanode가 아무리 많더라도 클러스터 전체가 이용 불가능해진다. 초기 버전에서는 namenode의 데이터 유실을 방지하는 secondary namenode 가 있었지만 Availability 문제를 완전히 해결하지는 못했다. 이러한 상태라면 예상치 못한 장애 뿐만 아니라, 계획된 업그레이드나 업데이트를 위해서 downtime 이 발생할 수 밖에 없었다.

## 3.2 HDFS HA Architecture

![image](https://user-images.githubusercontent.com/73389275/231321245-e1bcf4a9-ddd0-4701-82d5-01d741227786.png)

### 3.2.1 HA Architecture 기본 구성요소

HA Architecture 는 namenode를 active/passive 상태인 namenode 를 각각 두어서 SPOF 문제를 해결했다. HA cluster 에서는 active namenode, standby(passive) namenode 가 running중이어야 한다.

active namenode 가 다운되면, 다른 passive namenode 가 namenode 역할을 가져가고, downtime 을 최소화 한다. standby namenode 는 Hadoop cluster 의 failover 기능을 통합하는 backup namenode 역할을 수행한다. standby namenode를 통해서 namenode 가 예상치 못한 장애에 자동화된 failover 를 수행할 수 있다. 또한 maintenance 작업에서 graceful failover 를 기대할 수 있다.

이러한 HA Cluster 에서 consistency 를 유지하기 위해서는 두 가지 이슈가 있다.

1.  Active Standby namenode 는 항상 서로 sync 되어야 한다.
2.  한 순간에 단 하나의 active namenode만 존재해야 한다. 만약 잠깐이라도 두 개의 active namenode 인 상태가 된다면, 서로 다른 active 데이터 상태를 가져서 데이터 충돌이 일어날 수 있다. (split-brain) 이것을 막기 위해서 Fencing 과정을 가진다.

### 3.2.2 HA Architecture 구현방법

Active Standby namenode 설정을 하는 방법으로 두 가지의 선택지가 있다.

1.  Quorum Journal Nodes 를 사용
2.  NFS를 이용한 shared storage 를 사용

## 3.3 Quorum Journal Nodes를 이용한 HA Architecture

![image](https://user-images.githubusercontent.com/73389275/231321278-5f3850a2-6a1e-4d6e-82b5-a910f4b105a8.png)

### 3.3.1 Sync mechanism on HA Architecture using Quorum Journal Nodes

-   Active, Standby namenode 는 Journal Nodes 라는 별도의 노드 그룹 (또는 데몬 프로세스) 으로 sync를 유지한다.
-   Journal Nodes 는 ring topology 라는 구성으로 서로 연결되어있다.
-   Journal 노드에 들어온 request 는 ring 구조를 따라 다른 노드로 copy 된다. 이로인해 특정 Journal node 에 failure 가 발생해도 Fault Tolerance 를 보장한다.
-   Active namenode 는 Journal Node 에 있는 EdigLogs 를 업데이트 한다.
-   Standby namenode 는 Journal Node 로부터 EditLogs 의 변경사항을 읽고 그것을 자신의 namespace 에 적용한다.
-   Failover 시에 Standby namenode 는 Active namnode가 되기전에 우선 자신이 가진 metadata 의 내용이 Journal Node에 있는 모든 업데이트를 반영한 상태인지 확인한다. Journal Node 의 모든 데이터가 싱크되었다면 그 때 Active Namenode가 된다.
-   모든 datanode 는 active namenode 와 StandbyNode 의 IP 주소를 모두 알고 있다. datanode 는 자신의 heart beat 와 block report 데이터를 두 namenode에게 보낸다. 이로인해 Standby는 active 가 되기 전에 이미 datanode 정보와 block location 정보를 모두 알고 있으므로 빠르게 failover 를 수행할 수 있다.

### 3.3.2 Fencing of NameNode using Quorum Journal Nodes

Quorum Journal Nodes를 이용한 Architecture에서 Split-brain을 방지하기 위한 방법

-   Journal node는 한 순간에 하나의 namenode 만 writer 가 되도록 한다.
-   Standby namenode 가 Journal nodes 에 대한 writing 권한을 받으면, 다른 namenode 가 active 상태가 되지 못하게 막는다.
-   이 과정이 모두 끝난 후에 active namenode 역할을 수행한다.

## 3.4 Shared Storage를 이용한 HA Architecture

![image](https://user-images.githubusercontent.com/73389275/231321305-cf2aa2ec-a6d1-4140-bc0f-3d90eee8c415.png)

### 3.4.1 Sync mechanism on HA Architecture using Shared Storage

-   Active, Standby namenode 는 shared storgae device 를 통해 sync를 유지한다.
-   Active namenode 는 변경사항을 shared storage 에 있는 EditLog 에 기록한다.
-   Standby namenode 는 변경사항을 shared storage에 있는 EditLog 를 읽어서 자신의 namespace 에 적용한다.
-   Failover 발생시에 Standby namenode 는 shared storage 에 있는 EditLog 의 변경사항을 모두 반영한 것을 확인한 뒤에 active namenode 가 된다.

### 3.4.2 Fencing of NameNode on HA Architecture using Shared

-   Split-brain을 방지하기 위해 관리자는 최소한 하나의 fencing 방법을 설정해야 한다.
-   다양한 fencing 메커니즘을 사용할 수 있다. 여기에는 namenode의 프로세스를 삭제하고 공유 스토리지 디렉토리에 대한 액세스를 취소하는 작업 등이 있을 수 있다.
-   마지막 수단으로, 우리는 이전에 active namenode 에 STONITH로 split brain을 방지할 수 있다. (STONITH “shoot the other node in the head") 특수 전원 공급 분배기롤 namenode 머신을 강제로 끄는 방법이다.

## 3.5 Automatic Failover

### 3.5.1 Failover 의 종류

Failover 는 시스템의 failure 나 fault 를 감지하고 secondary system 에대한 조작을 자동으로 수행하는 동작을 말한다.

Failover 에는 다음 두가지 방식이 있다.

**Graceful Failover:** 직접 failover 과정을 진행한다. 주로 유지보수 과정에서 필요한경우 계획하고 의도적으로 실행한다.

**Automatic Failover:** 예상치 못한 namenode장애에 의해 자동으로 수행된다.

### 3.5.2 Zookeeper 를 이용한 Hadoop Failover

zookeeper 를 이용해서 automatic failover 가 이루어지는 과정을 알아보자.

![image](https://user-images.githubusercontent.com/73389275/231321346-a1575b8b-d4e3-453b-aa23-34fcb0985328.png)

[https://data-flair.training/](https://data-flair.training/)

HDFS HA cluster 에서는 automatic failover 가 가능하게 하기 위해 Apache Zookeeper 를 사용한다. zookeeper 는 적은 양의 coordination data 를 유지하고, zookeeper 의 client 들에게 데이터의 변경을 알리고, failure 감지를 위해 client 들을 모니터링 한다. Zookeeper 는 namenode 에 session을 유지하고 있다. 만약 failure 가 발생하면 zookeeper 에 연결된 client session이 만료될 것이고 이때 zookeeper 는 다른 namenode 들에게 failover process가 시작되었음을 알린다. Active namenode 의 failure 가 발생하면 다른 standby(passive) namenode는 active namenode가 되기 위해 zookeeper 에 유지되고 있던 state 에 lock을 건다.

ZookeerFailoverController (ZKFC) 는 namenode의 상태 모니터링을 하는 zookeeper client 프로세스이다.

각 namenode는 ZKFC를 자신의 노드에 띄우고, ZKFC가 namenode를 주기적으로 health check 를 하도록 해야한다.

## 3.6 Observer Name Node (ONN) 으로 부하 분산하기
>ONN은 Hadoop 3.x 버전부터 사용할 수 있다.

### 3.6.1 Observer Name Node 의 필요성

위에서 배운 HDFS HA Architecture 에서 active namenode 는 client의 모든 요청을 받고, standby namenode 는 단순히 active namenode 와 같도록 sync 받는 일만 한다. HA는 달성했지만, 여전히 단일 active namenode가 병목이 되는 문제는 발생한다. 단일 active namenode에 부하가 심해진다면, HA를 이용해서 failover 가 되었더라도 또 다시 부하로 active namenode를 이용 못하는 상태가 연쇄적으로 발생할 수 있다.

Oserver NameNode 는 이러한 active namenode의 부하를 분산해주기 위해 만들어졌다. Observer NameNode 는 standby namenode와 마찬가지로 active namenode와 같은 상태를 유지한다. 여기에 더해 active namenode 처럼 consistent read 를 지원한다. HDFS를 사용하는 대부분의 use case 가 write-once-read-many access model을 따르기 때문에 read 의 부하를 분산해주는 것 만으로 active namenode 의 부하를 많이 낮출 수 있다.

### 3.6.2 State of namenode

Hadoop 3 버전부터는 HA Hadoop Cluster 에서 namenode 는 3가지의 state 를 가질 수 있다. active, standby, observer

State Transition은 다음과 같은 구성 사이에서 가능하다.

-   active - standby
-   standby - observer

active - observer 사이에서 직접 전환은 불가능하다.

### 3.6.3 Consistency in a client - read your own writes

하나의 클라이언트 내에서 read-after-write consistency 를 유지하기 위해서 state ID 가 RPC의 header 에서 사용된다. state ID는 namenode 의 transaction ID를 이용해서 구현된다.

Client. 가 active namenode 를 이용해서 write 를 수행하면, state ID를 namenode 의 latest transaction ID 를 이요해서 업데이트 한다. 이어지는 read operation에서 클라이언트는 state ID를 observer namenode 에 전달한다. 이때 observer namenode 는 자신이 가진 transaction ID 와 클라이언트로부터 받은 state ID로부터 도출한 transaction ID를 비교한다. 이렇게 확인된 transaction ID가 observer namenode 자기 자신이 가진 transaction ID와 같다면 observer namenode는 요청된 read 을 수행하고 결과를 리턴한다.

이 방식은 하나의 클라이언트에 대해 “read your own writes” semantics 을 보장한다.

-   여러 클라이언트에 대해 consistency 를 유지하는 방법은 아래 Maintaining Client Consistency 에서 다룬다.

### 3.6.4 Edit log tailing

observer namnode에게 Edit log tailing 은 아주 중요하다. active namenode 에 업데이트된 새로운 transaction에 대해서 observer namenode 가 반영하는 latency 에 영향을 주기 때문이다.

새로 도입된 Edit log tailing 방식은 “Edit Tailing Fast-Path” 은 latency를 줄일 수 있도록 디자인 되었다. 기존의 edit log tailing 기능에 더해,

-   HTTP 대신 RPC based tailing 을 사용한다.
-   Journal Node의 in-memory cache 를 사용한다.

### 3.6.5 Client-side proxy provider의 동작

새로운 client-side proxy provider 인 ObserverReadProxyProvider 는 기존에 Failover 에서 사용되는 ConfiguredFailoverProxyProvider 를 상속받는데, 이를 통해 observer namenode 에서 read 를 사용할 수 있도록 한다. 클라이언트가 read 요청을 하면 proxy provider 는 먼저 클러스터에서 사용할 수 있는 observer namenode 로 read 를 시도한다. 모든 observer namenode로부터의 읽기가 실패했을 때 active namenode로 요청을 보낸다.

### 3.6.6 Maintaining Client Consistency

위에서 설명한 read your own writes 에 의해서 클라이언트 ‘foo’가 active namenode에 a.txt 를 생성하는 write를 수행했다고 가정해보자.

-   이때, foo 가 observer namenode 로 요청하는 모든 read 는 a.txt 가 완료된것을 보장한 뒤에 read 에 응답한다.

이때, foo 가 write 를 보냄과 동시에 ‘bar’라는 out-of-band(HDFS가 아닌) 클라이언트에게 이 사실을 알렸고, bar client 가 HDFS 에 a.txt 를 조회한다고 해보자.

-   이 때, bar 는 a.txt 를 읽을 수 있을까?

이것은 보장되지 않는다.

따라서 여러 클라이언트들 사이에 이러한 inconsistent 한 동작을 방지하기 위해서 메타데이터를 동기화 하기위한 `msync()` 기능이 추가되었다. 어떤 클라이언트에서든 `msync()` 를 호출하면, active name node 에 대한 state ID를 업데이트해서 이후 요청하는 어떤 read 든지 `msync()` 지점까지 consistent 함을 보장할 수 있다.

-   위의 사례에서 bar 가 `msync()` 를 수행한 뒤에 a.txt 를 read 요청한다면 읽기를 보장할 수 있다.

`msync()`를 사용하기 위해 어플리케이션 코드를 변경할 필요는 없다. 클라이언트는 Observer에 대해 읽기를 수행하기 전에 자동으로 `msync()`를 호출하여 클라이언트 초기화 전에 수행된 쓰기를 볼 수 있다. 또한 `ObserverReadProxyProvider` 가 지원하는 자동 msync 모드가 있으며, 이 모드는 설정 가능한 간격으로 msync()를 자동으로 수행하여 클라이언트가 시간 제한보다 오래된 데이터를 볼 수 없도록 한다. 새로 고칠 때마다 Active NameNode에 대한 RPC가 필요하므로 오버헤드가 있다. 기본적으로 사용하지 않도록 설정되어 있다.

# 4 Hadoop 3 Eraser Coding

## 4.1 Hadoop 의 data fault tolerance

### 4.1.1 Software Data Tolerance

Hadoop 은 기본적으로 같은 data block 에 대해서 3개의 복제본을 유지한다. 이 data block 은 fault tolerance 를 위해 물리적으로 다른 위치에 위치시킨다. 다른 머신, 다른 rack, 다른 data center 단위로 분산해서 위치시켜서 물리적인 위치에 따른 fault 에 대해서도 데이터가 유실되지 않도록 한다.

복제본 정책은 데이터 유실에 대비하는 좋은 수단이 되지만, 이 때문에 발생하는 trade-off가 있다. 데이터를 3벌(혹은 그 이상) 저장해야 하기 때문에 write 작업에 시간이 더 오래 걸린다는 점과, 데이터 복제본 유지를 위해서 실제 데이터의 양보다 3배 이상의 데이터 공간이 필요한 것은 단점이다.

### 4.1.2 Hardware Data Tolerance

Hadoop Cluster 은 위처럼 소프트웨어로 유실을 방지할 수 있다. 하지만, 유실에 대한 대비(감내) 수준을 더 높이기 위해 HW 차원에서의 방법을 적용하기도 한다. HW RAID 구성을 통해서 소프트웨어의 변경 없이 데이터의 Fault Tolerance 수준을 높일 수 있다.

단, RAID 구성을 위해서는 추가적인 데이터 공간이 필요하고, 저장 과정이나 복구 과정에서 자원을 더 소모하므로 비용이 높아진다.

*실제로 하둡에 적용했을 때의 이득은 거의 없음. **3copy / rack awareness**를 적용하고 있어서 하드웨어적인 방식이 크게  유효하지 않을 것 같음*
*하지만 **NN**의 경우에는 **메타데이터의 손상을 방지**하고 가용성을 올려주는 등의 효과가 있어서 권장하긴 함(NN은 소중하니까...!)*

## 4.2 RAID

### 4.2.1 RAID란?

RAID는 Redundant Array of Inexpensive Disks의 약자이다.

RAID는 **하드 디스크를 여러개의 독립적인 드라이브의 배열로 가상화** 하는 방식이다. 이 방식을 통해서 performance, capacity, reliability 를 개선할 수 있다.

RAID는 이 기능을 위해 만들어진 컨트롤러인 RAID 하드웨어 컨트롤러를 사용하는 방식과, 운영체제 수준에서 소프트웨어 드라이브로 구현하는 방식 두 가지가 있다.

### 4.2.2 RAID 0

![image](https://user-images.githubusercontent.com/73389275/231321383-b32f8fd7-0ecf-4668-a570-ade333a84bbf.png)

[https://www.dataplugs.com/wp-content/uploads/2018/08/raid0-1.jpg.webp](https://www.dataplugs.com/wp-content/uploads/2018/08/raid0-1.jpg.webp)

RAID 0 은 데이터를 블록단위로 나누어서 전체 데이터 영역에 array로 분포하도록 나누는 방식이다. 드라이브의 수 만큼 동시에 read/write 가 가능하므로 속도가 빠르다. storage 의 용량을 모두 사용할 수 있고, 오버헤드 또한 없다.

RAID 0의 단점은 dedundant 하지 않다는 것이다. 하나의 드라이브가 고장나면 해당 드라이브에 위치한 모든 블록의 데이터가 유실된다. 데이터의 보관과 복구가 필요하다면 추천하지 않는다.

### 4.2.3 RAID 1

![image](https://user-images.githubusercontent.com/73389275/231321429-5fb5233a-e7f4-4f62-9b5b-d719d1ec37ab.png)

[https://www.dataplugs.com/wp-content/uploads/2018/08/raid1-1.jpg.webp](https://www.dataplugs.com/wp-content/uploads/2018/08/raid1-1.jpg.webp)

RAID 1은 같은 데이터에 대해서 최소한 두개의 드라이브를 사용하는 방식이다. 하나의 드라이브가 고장나도라도, 다른 하나로 인해 유실을 방지하고 지속적인 읽기 쓰기가 가능하다. RAID 1 은 두 개의 드라이브 중 어디서든 가까운 위치에서 읽으면 되므로 read의 성능 또한 좋다.

하지만 write 시 두 벌 이상 저장해야하므로 RAID 0보다 write 속도가 느리다. 또한 두 개의 드라이브를 준비했지만, 사실상 이용가능한 용량은 하나 분량이므로 capacity 가 전체 디스크 용량대비 50%로 줄어든다.

### 4.2.4 Parity

Computer Science 에서 활용되는 Parity bit 는 1개의 bit 를 추가해서 데이터의 위변조를 확인할 수 있도록 하는 데이터를 말한다.

다음은 parity bit의 역할이 even parity bit 인 경우, odd parity bit 인 경우에 추가되는 8번째 자리의 bit의 사례이다.

|7 bits of data|(count of 1-bits)|8 bits including parity(even)|8 bits including parity(odd)|
|---|---|---|---|
|0000000|0|0000000**0**|0000000**1**|
|1010001|3|1010001**1**|1010001**0**|
|1101001|4|1101001**0**|1101001**1**|
|1111111|7|1111111**1**|1111111**0**|

RAID에서 parity block 는 유실된 하나의 블록들의 데이터와 특별한 연산을 통해서 복구할 수 있는 bit로 구성된 블록을 의미한다.
****
아래 예제는 parity 연산이 xor 이고, 연산 결과가 0인 경우의 예이다.

예제 - 정상 상태
| |DISK 1|DISK 2|DISK 3|DISK 4|DISK 5|
|---|---|---|---|---|---|
|A block|0|0|0|0|Parity<br>0 ⊕ 0 ⊕ 0 ⊕ 0= 0|
|B block|0|1|0|Parity<br>0 ⊕ 1 ⊕ 0 ⊕ 1= 0|1|
|C block|0|1|Parity<br>0 ⊕ 1 ⊕ 1 ⊕ 0= 0|1|0|
|D block|1|Parity<br>1 ⊕ 0 ⊕ 0 ⊕ 1= 0|0|0|1|
|E block|Parity<br>1 ⊕ 0 ⊕ 0 ⊕ 0= 1|1|0|0|0|

DISK 3의 Failure 발생

|  | DISK 1 | DISK 2 | DISK 3 | DISK 4 | DISK 5 |
| --- | --- | --- | --- | --- | --- |
| A block | 0 | 0 | Failure | 0 | Parity<br>0 ⊕ 0 ⊕ 0 ⊕ 0= 0 |
| B block | 0 | 1 | Failure | Parity<br>0 ⊕ 1 ⊕ 0 ⊕ 1= 0 | 1 |
| C block | 0 | 1 | Parity Failure | 1 | 0 |
| D block | 1 | Parity<br>1 ⊕ 0 ⊕ 0 ⊕ 1= 0 | Failure | 0 | 1 |
| E block | Parity<br>1 ⊕ 0 ⊕ 1 ⊕ 0= 1 | 1 | Failure | 0 | 0 |

각 블록에 대해 장애가 나지 않은 디스크에 있는 블록들을 모두 xor 연산을 하면 DISK 4의 원본 bit를 복구할 수 있습니다.

### 4.2.5 RAID 5

![image](https://user-images.githubusercontent.com/73389275/231321472-92ea657e-da35-49bf-bba2-0933ee5d6567.png)

[](https://www.dataplugs.com/wp-content/uploads/2018/08/raid5-1.jpg.webp)[https://www.dataplugs.com/wp-content/uploads/2018/08/raid5-1.jpg.webp](https://www.dataplugs.com/wp-content/uploads/2018/08/raid5-1.jpg.webp)

RAID 5 는 최소한 3개 이상의 드라이브로 구성해야한다.

RAID 5는 하나의 데이터 블록이 여러개의 드라이브에 걸쳐 존재하도록 블록을 나눈다. 개별 블록에 대해 통째로 복제본을 유지하지 않는다. 다만, parity 라 불리는 블록을 추가로 다른 드라이브에 분산해서 저장한다.

하나의 드라이브에 장애가 발생하면, 해당 드라이브에 위치했던 블록의 데이터는 다른 드라이브에 있는 블록과 패리티 블록을 이용해서 복구할 수 있다. 단일 드라이브 장애에 대해 Zero downtime이 보장되고, read 는 빠르다.

RAID 5 는 전체 디스크 용량의 33%(num of drive = 3) 이하에 대항하는 분량만 패리티 블록을 위해 사용하므로, 데이터 복구는 보장하면서도 RAID 1과 비교하면 capacity 가 높다.

다만, 데이터 저장시에 parity 가 계산되어야 하므로 write 성능이 느리다. 또한 동시에 2개 이상의 드라이브에 장애가 발생하면 데이터는 복구 불가능하다.

가장 많이 활용되는 RAID 5 구성은 4개의 드라이브로 구성해서 25% 의 capacity loss 로 구성하는 것을 선호한다. 드라이브 수는 최대 16개 까지 구성가능하다.

데이터 드라이브 수가 제한된 파일 및 애플리케이션 서버에 적합하다.

### 4.2.6 RAID 6

![image](https://user-images.githubusercontent.com/73389275/231321579-1e400150-afb9-48b5-87d7-1cc7ee94535e.png)

[https://www.dataplugs.com/wp-content/uploads/2018/08/raid6-1.jpg.webp](https://www.dataplugs.com/wp-content/uploads/2018/08/raid6-1.jpg.webp)

RAID 6는 RAID5와 유사하지만, parity 가 두개의 드라이브에 나누어 쓰여진다. 또한 parity 연산이 XOR이 아니라 [Reed-Solomon](https://www.notion.so/P08-C01-Hadoop-a9ed5e217adc464e9e9cac25caf07c23) 부호로 패리티를 생성한다. 따라서 최소한 4개의 드라이브로 구성해야하고, 동시에 두개의 드라이브의 장애에 대해 복구할 수 있다. read 는 RAID 5 정도로 빠르지만, parity block 이 하나 더 추가되기 때문에 write 는 RAID 5보다 느리다.

RAID 6는 read 위주의 transaction 이 필요한 웹서버에 적합하다. write 가 heavy 한 데이터베이스 등에는 부적합하다.

### 4.2.7 RAID 10

![image](https://user-images.githubusercontent.com/73389275/231321525-47bcab55-ccd1-4cb6-961c-25b73e4cf461.png)

[https://www.dataplugs.com/wp-content/uploads/2018/08/raid10-1.jpg.webp](https://www.dataplugs.com/wp-content/uploads/2018/08/raid10-1.jpg.webp)

RAID 10 은 RAID 0 과 RAID 1 의 장점을 하나로 합친 시스템이다. 모든 데이터 블록에 대해서 복제본을 다른 드라이브에 유지하면서도, 전체 데이터 블록 array를 서로 두 개 의 드라이브에 나누어 분배하는 방식이다. 최소한 4개의 드라이브가 필요하다.

RAID 10은 RADI 0 수준의 속도와 RAID 1수준의 dedundancy 를 보장한다. 하나의 드라이브에 장애가 생겨도 복제본이 유지된 드라이브를 통해 복구가 가능하다. 다만

capacity 는 RAID 1과 동일하게 50%이다. RADI 5, 6에 비해 비싼 방법이다.

### 4.2.8 정리

| Features | RAID 0 | RAID 1 | RAID 5 | RAID 6 | RAID 10 |
| --- | --- | --- | --- | --- | --- |
| Minimum number of drives | 2 | 2 | 3 | 4 | 4 |
| Fault tolerance | None | Single-drive failure | Single-drive failure | Two-drive failure | Up to one disk failure in each sub-array |
| Read performance | High | Medium | Low | Low | High |
| Write Performance | High | Medium | Low | Low | Medium |
| Capacity utilization | 100% | 50% | 67% – 94% | 50% – 88% | 50% |
| Typical applications | High end workstations, data logging, real-time rendering, very transitory data | Operating systems, transaction databases | Data warehousing, web serving, archiving | Data archive, backup to disk, high availability solutions, servers with large capacity requirements | Fast databases, file servers, application servers |

### 4.2.9 어떤 RAID를 쓰나요?

fault tolerance 와 성능을 모두 고려한다면 RAID 5, 6, 10 중에 선택할 수 있다.

다 RAID 10 의 capacity loss 가 너무 크기 때문에, 현실적으로 RAID 5를 많이 선택한다.

## 4.3 Eraser Coding

### 4.3.1 Hardware RAID vs Software RAID

하드웨어 RAID

-   별도의 하드웨어인 RAID 컨트롤러 카드를 통해 RAID를 구현한다.
-   시스템에 부담없이 읽기/쓰기나 패리티 계산 등의 속도 빠르다.
-   RAID 컨트롤러 카드의 가격 비싸다.

소프트웨어 RAID

-   기존 컴퓨터 구조를 그대로 이용하면서 RAID를 이용한다.
-   RAID를 적용할 디스크만 있으면 별도의 하드웨어가 필요없어 비용 아낄 수 있다.
-   다른 작업들과 CPU 리소스를 공유하기 때문에 전반적인 작업 속도가 느려질 수 있다.

### 4.3.2 Eraser Coding

Hadoop 의 Eraser Coding(이하 EC) 은 RAID 방식을 소프트웨어로 구현한 것이다. RAID 5,6 과 같이 패리티를 이용해 복구한다. 차이점은 패리티를 계산하는 방법에 차이가 있다.

RAID 6 처럼 데이터를 조각으로 나눠 Reed-Solomon와 같은 알고리즘을 사용하여 데이터 패리티를 생성한다. 여기서 RAID와 차이점은 데이터 보호 수준을 유연하게 설정할 수 있다는 점이다.

n개의 블록 조각을 연산을 통해 k개의 패리티를 생성한다. 이 n+k개 중 최대 k개의 데이터가 손실되어도 n개의 데이터만 살아있으면 원본 데이터가 복구 가능하다.

-   N: 몇개의 chunk 로 나눌지
-   K: 몇개의 parity 로 구성할지
-   RS(N,K) 로 표현함.

![image](https://user-images.githubusercontent.com/73389275/231378337-87a0533c-9b20-4a2b-aada-38a7d83c5ee9.png)

[http://db-blog-multimedia.web.cern.ch/db-blog-multimedia/ekleszcz/erasure-coding-hdp3/2.png](http://db-blog-multimedia.web.cern.ch/db-blog-multimedia/ekleszcz/erasure-coding-hdp3/2.png)

![image](https://user-images.githubusercontent.com/73389275/231378402-67e23d69-0fd4-4f27-b282-9f0e0c1e1136.png)

[https://clouderablog.wpenginepowered.com/wp-content/uploads/2019/08/hdfs-erasure-f31.png](https://clouderablog.wpenginepowered.com/wp-content/uploads/2019/08/hdfs-erasure-f31.png)

위 그림은 EC가 적용되기 전의 Hadoop의 block을 기반으로 parity 를 구성하는 것과, stripping 후에 parity를 구성한 것의 차이를 나타내는 그림이다. Hadoop 의 논리적인 하나의 블록 사이즈는 여전히 동일하다.

contigous block 그림은 논리적 블록을 실제 스토리지 블록에 1대1로 매핑하는 것이다. 하나의 파일을 읽을 때 하나의 블록에 대해서 순차적으로 읽을 수 있다.

striped block 은 논리적 블록을 더 작은 단위인 셀(cell)로 쪼갠다. write 는 셀들의 stripes 을 여러개로 구성된 storage block의 셋에 round robin으로 돌면서 저장한다. read 또한 여러개의 storage block의 셋으로부터 cell들의 stripes 으로 읽어들인다.

이 방법을 통해서 논리적인 블록 1개에 대해서 병렬처리가 가능해진다.

### 4.3.3 Eraser Coding 장점

Eraser Coding 을 통해서 데이터의 복구 가능성은 높이면서 Storage 의 capacity loss 를 줄일 수 있다. N과 K를 어떻게 설정하느냐에 따라 그 효율은 달라지지만, 최소한 기존에 3개 replica 로 최소한 2배 이상의 storage 를 추가로 사용하는 것보다는 모든 경우에 좋다.

![image](https://user-images.githubusercontent.com/73389275/231378477-a91d29b4-8577-4f16-9c9a-9af8e80fb797.png)

또한 striped block 을 통해서 논리적인 블록 1개에 대한 병렬성이 높아지므로, read performance 는 오히려 기존보다 증가했다.

![image](https://user-images.githubusercontent.com/73389275/231378523-e9900deb-ffe3-4d55-8293-f8aa869bab49.png)

[http://db-blog-multimedia.web.cern.ch/db-blog-multimedia/ekleszcz/erasure-coding-hdp3/8.png](http://db-blog-multimedia.web.cern.ch/db-blog-multimedia/ekleszcz/erasure-coding-hdp3/8.png)

-   성능 지표 참고자료 : [https://db-blog.web.cern.ch/blog/emil-kleszcz/2019-10-evaluation-erasure-coding-hadoop-3](https://db-blog.web.cern.ch/blog/emil-kleszcz/2019-10-evaluation-erasure-coding-hadoop-3)

### 4.3.4 Eraser Coding 단점

RAID 에서 살펴본 것과 마찬가지로, Eraser Coding 은 단순 복사에 비해 encoding 과정이 추가되므로(복구시엔 decoding) write 시에 parity 계산 과정이 추가되므로 write 의 성능이 떨어질 수 밖에 없다.

다만, intel 이 제공하는 ISA-L encoder library 덕분에 이 단점이 어느정도 상쇄될 수 있었다. (약 30% 감소)

![image](https://user-images.githubusercontent.com/73389275/231378712-688cb3d6-8f59-4a36-975b-02cc5bc252a1.png)

[http://db-blog-multimedia.web.cern.ch/db-blog-multimedia/ekleszcz/erasure-coding-hdp3/7.png](http://db-blog-multimedia.web.cern.ch/db-blog-multimedia/ekleszcz/erasure-coding-hdp3/7.png)

-   성능 지표 참고자료 : [https://db-blog.web.cern.ch/blog/emil-kleszcz/2019-10-evaluation-erasure-coding-hadoop-3](https://db-blog.web.cern.ch/blog/emil-kleszcz/2019-10-evaluation-erasure-coding-hadoop-3)

# 5 Fair Call Queue

Fair Call Queue 는 Client의 요청을 담아놓는 Queue 이다. 특정 클라이언트의 요청때문에 전체 요청의 처리가 늦어지지 않도록 하기 위해 만들어졌다.

## 5.1 FIFO queue 의 단점

Fair Call Queue 가 도입되기 전에 Hadoop Node 에서 client 의 요청은 FIFO queue 에 담겨져서 먼저 요청이 온 순서대로 처리했다.

Client로 부터 요청이 오면 reader thread 는 단일 FIFO Queue 에 요청을 담고, Handler 가 처리할 작업이 없다면 FIFO에서 하나씩 요청을 꺼내서 처리하는 방식이었다.

![image](https://user-images.githubusercontent.com/73389275/231378815-7aae873b-8e0c-46c3-814f-112c8f230d2c.png)

[https://tech.ebayinc.com/assets/Uploads/Blog/2014/08/_resampled/ResizedImageWzYyMCwxNzZd/fifo_call_queue.png](https://tech.ebayinc.com/assets/Uploads/Blog/2014/08/_resampled/ResizedImageWzYyMCwxNzZd/fifo_call_queue.png)

단순 FIFO Queue 를 이용해서 Client 의 요청을 처리하는 방식은 heavy user 로 인해 빈번하게 Hadoop Node 의 응답을 느리게 만들었다. 특히 namenode 의 경우 단일 서버에서 모든 요청을 처리하기 때문에, 병목이나 부하에 민감한데, 수 ms 에서 수백 ms 까지도 응답이 느려지는 일이 잦았다. 기존에는 이런 작업들을 강제 종료시키는 방법으로 처리했다. 하지만 이런 방식은 생산적이지도 않을 뿐더러, 이미 처리된 작업에 대해서 이러한 작업을 수행할 때 오류 등이 발생해서 cluster 동작을 수시간 이용 못하는 경우 까지도 생겼다.

![image](https://user-images.githubusercontent.com/73389275/231378858-69144b30-ad6a-4a9c-92e7-026717c6c567.png)

[https://tech.ebayinc.com/assets/Uploads/Blog/2014/08/_resampled/ResizedImageWzYyMCwyMTld/heavy_users.png](https://tech.ebayinc.com/assets/Uploads/Blog/2014/08/_resampled/ResizedImageWzYyMCwyMTld/heavy_users.png)

위 자료는 각 유저별로 요청을 다른 색으로 표현한 것이다. 이러한 문제는 소수의 유저의 high load operation 에 의해서 발생하는 경우가 많았다. 그리고 이런 작업은 종종 유저의 잘못된 MapReduce 작업에 의해 발생했다.

바꿔서 말하면, 누구든 잘못된 MapReduce 작업으로 high load 를 발생시킨다면 분산 서비스에 대한 공격을 수행할 수 있다는 것이다. DDoS(distributed denial-of-service attack) 방식으로 공격이 가능해진다.

## 5.2 Fair Call Queue 의 도입

라우터에서 사용하는 QoS(Quality of service) capabilities의 기능에서 영감을 받아 FIFO Queue 를 Fair Call Queue 로 교체했다.

![image](https://user-images.githubusercontent.com/73389275/231378950-bfaf65e7-0e9a-4260-b6de-5d3f545e560d.png)

### 5.2.1 Fair Call Queue 구성요소

multiplexer 와 scheduler 는 multi-level queue 로 연결되어있다. Fair Call Queue 는 이 3가지의 구성요소 이루어져있다.

### 5.2.2 RPC Scheduler 의 역할

RPC 요청이 Listen Queue에 도착하면 여러개의 Reader thread 가 요청을 **RpcScheduler** 로 전달한다**.** RPC Scheduler 는 이 요청을 여러개의 queue 로 나누어서 넣는다. 각 queue는 priority queue 인데, queue에 넣기 전에 때 각 요청별로 우선순위를 지정한 후, 우선순위에 맞는 priority queue 에 요청을 넣는다.

Fair Call Queue에 있는 RPC Scheduler 는 구현체를 선택할 수 있도록 pluggable 하게 만들어져있다. default RPC Scheduler 는 **DecayRpcScheduler** 이다.

### 5.2.3 DecayRpcScheduler

DecayRpcScheduler는 각 user 별로 request 의 수(count)를 기억하고 있다. 이 count 는 시간이 지날수록 decay(부패) 정도를 고려한다. sweep period 마다 유저별 priority를 계산한다.

매 sweep period (default 5s) 마다 유저별 요청수는 decay factor(default 0.5) 에 곱해진다. 이것으로 유저별로 가중치(weighted)가 반영되고 rolling 된 평균 요청수를 구할 수 있다.

sweep이 매번 수행될때마다 모든 유저의 call count 는 ranking이 매겨진다. 이 랭킹에 따라서 각 유저는 priority 를 할당받는다. 기본으로 0-3 의 값을 가지고, 0이 가장 높은 우선순위(highest-priority)이다.

-   기본 우선순위 임계치(priority thresholds)는 0.125, 0.25, 0.5 이다.
    -   전체 요청에 비해 50% 이상의 요청을 호출한 유저는 lowest priority 를 가진다.
    -   25%~50% 의 요청을 호출한 유저는 2번째로 낮은 우선순위(2nd lowest priority) 를 가진다.
    -   12.5%~25% 는 두번째로 높은 우선순위 (2nd highest priority)를 가진다.
    -   그 외 나머지는 highest priority 를 가진다.

sweep 과정이 끝나면 모든 유저는 캐시된 priority 를 가진다. 이 값은 다음 sweep 때 사용된다. 만약 다음 sweep 이전에 들어온 새로운 유저의 요청이 있다면, 그 새로운 유저의 priority 는 on-the-fly 로 계산된다.

### 5.2.4 RPC Multiplexer

multiplexer 는 low-priority queue 와 high priority queue 를 비교해 penalty 를 컨트롤 한다. multiplexer 는 요청들을 weighted round-robin 방식으로 읽는데, high-priority queue 를 선호하고, lowest-priority queue 로부터 읽는 것의 빈도를 낮추는 방식이다. 이 규칙으로 high-priority 요청은 먼저 처리하고, low-priority 요청에 의한 starvation 을 방지한다.

Handler thread 가 call queue 에서 요청을 가져오려고 할때, 어떤 요청을 가져올지를 RpcMultiplexer 가 결정한다. 현재 Rpc Multiplexer 는 **WeightedRoundRobinMultiplexer**로 하드코딩 되어있다.

WRRM은 queue 로부터 요청을 weight를 고려해서 처리한다. WRRM은 기본으로 (8,4,2,1) 4개로 weight를 구분하는 priority level로 구성된다.

-   8개의 request 를 highest priority queue 에서 꺼내서 처리하고
-   4개를 2nd highest 에서
-   2개를 third highest 에서
-   마지막으로 1개를 lowest 에서 꺼내서 handler 에게 주는 방식이다.

### 5.2.5 Backoff

위에서 설명한 priority-weighting mechanism 에 더해서, backkoff 방법도 설정이 가능하다.

backoff는 요청을 처리하기보다 client 에게 exception을 throw 하는 방식이다. 이것은 client 에서 exponential backoff 등으로 retry 를 하도록 구현되어있을 것을 기대하고 동작하는 방식이다.

전형적인 경우의 backoff 는 request queue 가 가득 찼을때 발생한다.

이 뿐만 아니라 backkoff by response time 기능도 제공한다.

이것은 더 높은 우선순위 queue에 있는 요청의 처리가 너무 느리다면, 낮은 우선순위 queue의 요청을 backoff 하는 방식이다.

-   priority 1에 대한 response time threshold 가 10s 로 세팅되어있고 해당 queue 의 평균 response time 이 12s 라고 하면, priority level 2 이하로 들어오는 요청은 backoff exception 을 받는다. 반면에 priority 0과 1에 있는 요청들은 정상적으로 처리된다.

이 방식의 의도는 높은 우선수위를 가지는 클라이언트에게 까지 영향을 미치는 시스템의 부하가 생겼을 때는, heavy user 에게 backoff 를 강제하겠다는 것이다.

-   따라서 Hadoop Client를 사용하는 어플리케이션 개발자는 backoff 에 의한 exception 이 자주 발생한다면, 자신이 시스템에 부하를 줄 정도로 무거운 요청을 자주 전송하는지 점검해볼 필요가 있다.

### 5.2.6 **Identity Provider**

유저를 구분하는 방식은 identity provider 로 규칙을 정할 수 있다. default는 **UserIdentityProvider**로, 단순히 client의 username 으로 구분한다.

### 5.2.8 설정 방식

[매뉴얼](https://hadoop.apache.org/docs/r3.3.3/hadoop-project-dist/hadoop-common/FairCallQueue.html#Cost-based_Fair_Call_Queue) 의 \#Configuration 항목에서 어떻게 설정하는지 확인이 가능하다.

-   core-default.xml 에 설정한다.

## 5.3 테스트 결과

테스트 결과 DoS 공격에 대해서 일정 수준 이하의 낮은 latency를 보장할 수 있었다.

![image](https://user-images.githubusercontent.com/73389275/231379026-857a4c6e-f79f-4efc-aa77-4323c6a8dd04.png)

[https://tech.ebayinc.com/assets/Uploads/Blog/2014/08/_resampled/ResizedImageWzYyMCwyNDVd/latency_comparison.png](https://tech.ebayinc.com/assets/Uploads/Blog/2014/08/_resampled/ResizedImageWzYyMCwyNDVd/latency_comparison.png)

-   참고: [https://tech.ebayinc.com/engineering/quality-of-service-in-hadoop/](https://tech.ebayinc.com/engineering/quality-of-service-in-hadoop/)

## 5.4 Cost based Fair Call Queue

Fair Call Queue 자체만으로도 헤비 유저에 대한 영향을 줄이는데에 효과가 좋았다.

하지만 Fair Call Queue 에는 각 요청이 얼마나 비싼 작업인지에 대해서는 고려가 되지 않았다.

예를 들어서 namenode 에 대해 다음 요청을 한다면 어떤 요청이 가장 비싼 작업일까?

1.  1000개의 getFileInfo 요청
2.  1000개의 listStatus on very large directory 요청
3.  1000개의 mkdir

답: 1번과 2번이 거의 같고, 3번이 가장 비쌈. mkdir에는 exclusive lock 필요함.

따라서 유저의 요청에 우선순위를 매길 때, cost 까지 고려할 필요가 생겼다. Fair Call Queue에 cost-based extenstion을 적용하면, 우선순위를 매길 때 해당 유저의 요청을 수행했을 때 걸린 processing time을 집계해서 사용한다.

기본 설정으로는,

-   queue time (processing을 위해 기다린 시간) 은 cost 에 포함되지 않는다.
-   lock wait time (lock 을 얻기 위해 기다린 시간) 은 cost 에 포함되지 않는다.
-   lock 이 없이 수행된 processing time = x 1 weighted
-   shared lock 과 함께 수행된 processing time = x10 weighted
-   exclusive lock 과 함께 수행된 processing time = x100 weighted

cost based Fair Call Queue 를 활성화 하기 위해서는 다음 설정을 해야한다.

-   `costprovder.impl` = `org.apache.hadoop.ipc.WeightedTimeCostProvider`

---
---
---

# Hadoop in AWS
> 2챕터의 강의는 aws 매뉴얼을 번역한 것. 실제로 설치할 때는 공식 도큐먼트 확인

## 노드 유형
### 1. Primary
마스터 노드 또는 네임노드.

### 2, 코어 노드
마스터 노드에서 관리하는 데이터 노드.
실제로 데이터가 저장

### 3. 테스크 노드
클라우드 환경이기에 구성가능한 노드. 일반적인 하둡에는 없음
하둡의 일부로서의 동작보다는 단순 연산을 보조하기 위한 노드에 가까움


# 고가용성 클러스터에 대한 제약사항
이사람 설명을 너무 대충하면서 다 넘어간다..

## hdfs
두 개 이상의 개별노드. 네임노드는 1개만 active, 나머지는 standby여야 함

## yarn rm
`yarrn rmadmin -getAllServiceState` 를 통해 노드의 active/standby 상태 확인

hive, hue, oozie, prestoDB 등의 경우 고가용성을 위해서는 전용 외부 메타db가 필요함

hdfs 커맨드는 마스터 노드에서만 실행(A/S 상태 무관)

**자동 종료 방지** AWS는 과금이 되는 서비스이기 때문에 다양한 조건을 통해 자동으로 종료되도록 가능
하지만 HA를 사용할 경우 이 기능이 자동으로 비활성화되기 때문에 별도의 설정을 통해 자동 종료를 활성화할 수 있음

이 외에는 강의자료 및 매뉴얼 참고

# 클러스터 인스턴스 구성 지침


