Zookeeper
분산 코디네이션 서비스
분산 어플리케이션을 만들기 위해 필요한 동기화 설정, 그룹, 네이밍에 대한 추상화된 수준의 서비스 제공 -> api를 통해
디렉토리구조의 데이터 모델 + java로 작성 및 java와 c사용
분산 시스템에서 coordintaion 기능은 중요도에 비해 구현이 힘듦. 벽돌될까봐...(Lock, Race condition, Deadlock)
이 부분은 주키퍼에 맡기면 분산 어플리케이션 구현이 쉬워짐


Zookeeper의 주요 기능
ZNodes
파일시스템과 유사하게 구성된 shared hierarchical namespace를 통해 분산 프로세스가 서로 상호작용 가능
데이터 레지스터라고 불림
주키퍼의 데이터는 메모리에서 처리하기 때문에 high throughput과 low latency를 제공한다


비기능적 특징
- high performance
    - ZooKeeper의 성능은 대규모(수천대) 분산 시스템에서 사용할 수 있는 수준이다.
- high available
    - Reliability는 SPOF(single point of failure)가 발생하지 않도록 설계되었다.
- strictly ordered access
    - Strictly Ordered access는 클라이언트에서 정교한 동기화 기능을 구현할 수 있게 한다.


복제된 구성요소
ensemble(앙상블)이라는 호스트 집합을 통해 복제된다
Zookeeper 클러스터를 구성하는 서버들은 모두 서로에 대해 알고 있다
Cluster를 구성하는 서버들 중 **과반수(quorum)**이상이 유지된다면, 일부에 장애나 문제가 있어도 전체 Zookeeper 서비스는 유지된다
    - 따라서 Cluster를 구성하는 서버는 홀수 대의 서버로 구성되어야 함