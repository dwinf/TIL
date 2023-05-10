# 개요
> 많은 양의 **데이터 처리**하는 어플리케이션을 쉽게 작성하는 것을 돕는 소프트웨어 프레임워크

- 동시에 여러 머신에서 동작
- 신뢰성 보장
- 고장 감내성(내결함성) 보장

MapReduce job 은 input data-set 을 독립적인 chunk 단위로 나누고, 각 chunk에 대한 처리는 map task 에서 parallel 하게 수행된다. map 의 output 은 정렬을 한 뒤에 reduce task 의 input 이 된다. 보통 Job의 input/output 은 모두 파일 시스템에 저장된다. 프레임워크는 task 에 대한 scheduling, monitoring, fail에 대한 재처리 등을 관리한다.

MapReduce 프레임워크와 HDFS 가 같은 노드 셋에서 동작한다면, 대개의 경우 storage node 와 computing node 는 같다. 이 방식으로 인해 task를 데이터가 있는 node 에 효과적으로 스케줄링 할 수 있고, 이 결과로 높은 aggregate bandwidth 를 가지므로 클러스터 전체적으로 대량의 데이터를 처리하는데 효과적이다.

맵리듀스의 프레임워크는
- 1개의  master RM
- 클러스터 당 1개의 worker NM
- application 당 1개의 MRAppMaster
으로 구성된다.

최소한의 구성으로, 어플리케이션은 input, **output location**(보통 hdfs)을 지정하고, map 과 reduce 함수를 MapReduce 프레임워크에서 제공하는 **interface와 abstract class** 를 이용해서 구현해야한다. 구현체 외에 다른 job parameter 는  job 제출(submit)시에 설정한다.

하둡의 job client는 job 과 configuration을 RM에게 제출한다
RM은 들어온 작업에 대해 아래와 같은 역할을 한다.
-   application software 와 configuration 을 worker 에 나눠준다.
-   분산한 작업을 모니터링한다.
-   status 또는 diagnostic information을 job-client 에게 제공한다.


# MR 프로그래밍
> 실습 데이터는 Part8 > Chapter2 AWS EMR Hadoop 실습 > 2 실습용 데이터 다운로드
> 실습 환경은 intellij의 메이븐을 통해 빌드
> 하지만 실무에서 mr을 코딩해서 다룰 일이 있을까...?

- 관련 코드는 [강의자료](https://yoonsung.notion.site/P08-C04-MapReduce-86e9d5e8bf784c95ae05c405d4116d71) 참고


## 사용자 정의 옵션
> org.apache.hadoop.util 패키지로 제공되는 편의를 위한 기능
> GenericOptionsParser, Tool, ToolRunner 등

### Counter
- 맵리듀스 job 진행 과정을 기록하고 모니터링할 수 있는 api

### 실습 내용

사용자 정의 옵션을 사용해서 출발 지연 시간, 도착 지연 시간을 계산
Counter 를 이용해서 **지연여부별로 counter** 를 남긴다.


# 맵리듀스 정렬
## Secondary Sort(보조정렬)

앞선 예제에서 결과 데이터는 파일에 행으로 나누어져 있는데, 정렬이 되어있지 않는다. 정렬되지 않은 이유는 맵리듀스에서 사용한 키를 연월을 단순히 붙인 텍스트로 인식했기 때문이다.

이것을 보조 정렬을 이용해서 월의 오름차순으로 정렬해보자.

보조정렬의 구현 순서

1.  Composite Key 를 정의한다.
    1.  어떤 키를 grouping key 로 사용할지 결정
2.  Composite key 의 레코드를 정렬하기 위한 Comparator 를 정의
3.  grouping key 를 파티셔닝할 partitioner 정의
4.  grouping key 를 정렬하기 위한 Comparator 정의

