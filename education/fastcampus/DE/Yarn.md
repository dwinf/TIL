Hadoop 2.0 과 함께 등장
대용량 multi processing 처리에 있어서 성능의 향상과 유연한 execution engine 이 장점


## Container
> Yarn에서는 RM가 자원을 할당해주는 Node Manager에 가까운 듯


컨테이너의 사전적 정의는 소프트웨어 서비스를 실행하는 데 필요한 특정 버전의 프로그래밍 언어의 런타임과 소프트웨어 실행에 필요한 라이브러리 등을 함께 담고있는 **응용 프로그램 코드의 경량 패키지**이다.

컨테이너화는 개발자들이 더 빠르게 개발하고 소프트웨어를 효과적으로 개발하고, 스케일에 대해서 더 유연하게 대응할 수 있도록 해준다.

[Linux 의 cgroup](https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt) 기능이 컨테이너화가 가능한 초기의 기술적인 기반이 되었다. 최근에는 cloud, kubernetes를 중심으로 컨테이너화를 활용하는 전략이 가속화되고 있다.

컨테이너를 사용하면 얻을 수 있는 대표적인 이점은 다음과 같다.

1. **Separation of responsibility**

컨테이너화 하기 전에는 소프트웨어를 배포할 때, 배포하는 환경을 제약하거나 같이 관리해야 했다. 특정 소프트웨어 개발자 입장에서 배포 환경의 **out of scope** 이므로 개발 난이도가 높아지거나 관리의 복잡도가 높아지게 된다.

어플리케이션 또는 소프트웨어를 컨테이너화 하면 개발자는 **Application 의 로직과 그것의 직접적인 dependency에만 관심을 집중**할 수 있다.

굳이 커널의 버전, 시스템 라이브러리의 사소한 업데이트에 관심을 갖지 않아도 된다.

2. **Workload portability**

컨테이너는 가상화된 환경으로 어디서나 동작할 수 있다. **인프라로부터 자유롭게** 다양한 환경에서 구동이 가능하다.

-   하지만 반드시 그럴 수 있다는 것은 아님...

3. **Application isolation**

컨테이너는 CPU, memory, storage, and network resources 를 운영체제 수준에서 가상화한다. 따라서 같은 호스트에 있는 다른 어플리케이션의 영향이나 간섭 없이 **독립된 리소스를 관리**할 수 있다.


# Yarn Architecture
> cpu, memory 와 같은 자원을 할당해주고 리소스의 사용을 관리하는 소프트웨어

엄밀히 HDFS와는 독립적임. **HDFS는 Storage** 기능을 제공하고, **Yarn 은 application 을 구동**하는 기능을 제공



