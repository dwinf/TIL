- [[#CH01 Observability|CH01 Observability]]
	- [[#CH01 Observability#Observability란|Observability란]]
		- [[#CH01 Observability#Observability란#1. Tracing|1. Tracing]]
		- [[#Observability란#2. Monitoring|2. Monitoring]]
		- [[#Observability란#3. Observability|3. Observability]]
	- [[#Observability 를 위해 필요한 것|Observability 를 위해 필요한 것]]
		- [[#Observability 를 위해 필요한 것#운영 데이터의 중요성|운영 데이터의 중요성]]
		- [[#Observability 를 위해 필요한 것#데이터를 남겨라|데이터를 남겨라]]
		- [[#Observability 를 위해 필요한 것#지속적인 데이터 observability 경험|지속적인 데이터 observability 경험]]
		- [[#Observability 를 위해 필요한 것#시스템에 대한 이해|시스템에 대한 이해]]
	- [[#대표적인 Observability 도구들|대표적인 Observability 도구들]]
	- [[#데이터 엔지니어가 모니터링해야 할 대상|데이터 엔지니어가 모니터링해야 할 대상]]
	- [[#데이터 수집 방식|데이터 수집 방식]]
- [[#CH02 Prometheus|CH02 Proemtheus]]
	- [[#Prometheus 설치|Prometheus 설치]]
		- [[#Prometheus 설치#요약|요약]]
	- [[#Pushgateway 설치|Pushgateway 설치]]
	- [[#Prometheus Data|Prometheus Data]]
		- [[#Prometheus Data#Prometheus Data Format|Prometheus Data Format]]
		- [[#Prometheus Data#Job & Instance|Job & Instance]]
		- [[#Prometheus Data#Metric Type|Metric Type]]
		- [[#Prometheus Data#PromQL|PromQL]]
	- [[#Prometheus Server|Prometheus Server]]
		- [[#Prometheus Server#Prometheus 의 한계|Prometheus 의 한계]]
		- [[#Prometheus Server#Thanos|Thanos]]
- [[#CH03 Grafana|CH03 Grafana]]
	- [[#grafana 설치|grafana 설치]]
	- [[#Grafana로 대시보드 구성하기|Grafana로 대시보드 구성하기]]
		- [[#Grafana로 대시보드 구성하기#대시보드를 구성|대시보드를 구성]]
		- [[#Grafana로 대시보드 구성하기#Alert 수신|Alert 수신]]
[[#CH04 Node Exporter|CH04 Node Exporter]]
	- [[#Node Exporter로 메트릭 노출하기#Node Exporter 설치|Node Exporter 설치]]
	- [[#Node Exporter로 메트릭 노출하기#Prometheus 에서 Node Exporter Scrap|Prometheus 에서 Node Exporter Scrap]]
	- [[#Node Exporter로 메트릭 노출하기#Node Monitoring Dashboard|Node Monitoring Dashboard]]
	- [[#Node Exporter로 메트릭 노출하기#Metric|Metric]]
- [[#CH05 Application Monitoring|CH05 Application Monitoring]]
	- [[#세팅|세팅]]
		- [[#세팅#build.gradle|build.gradle]]
	- [[#Custom Metric 구현하기|Custom Metric 구현하기]]
	- [[#Counter 사용하기|Counter 사용하기]]
	- [[#Histogram 사용하기|Histogram 사용하기]]


# CH01 Observability

## Observability란

### 1. Tracing
프로그램의 실행 과정을 상세히 남기는 것
    - 가장 오래된 기법
- 호출하는 메소드의 시작 시간과 끝 시간을 남겨서 걸린 시간을 계산할 수 있게 하는 것.
- 에러 발생시 **Stacktrace**
- network ping의 **router trip** 경로

상세하게 남길수록 부하가 커지거나, 데이터를 과도하게 사용하게 되므로 주의

### 2. Monitoring
에러, 다운타임, 비정상 상태 등을 감지하기 위해 이벤트, 메트릭 정보들 남기고 추적
- Metric monitoring 
    - 특정 기간이나 범위의 성공/실패 상태를 모니터링
    - 목표치 대비 성능의 상태나 관계를 모니터링
- Log monitoring 
    - 관심 있는 이벤트 데이터를 남기고 내용을 살피는 방식.

### 3. Observability
HW, OS, SW, Cloud infra 등의 모든 데이터를 활용
어플리케이션의 상태부터 시스템 전체의 상태를 확인, 이상 감지, 원인 추론까지 하는 것을 포괄하는 개념

Observability 가 가능하기 위해서는 세가지 성격의 데이터가 필요하다.
1.	Trace: 데이터의 흐름에 대한 정보를 파악하기 위한 데이터(위의 1. Tracing 과는 다름)
2.	Log: 이벤트 정보
3.	Metric: 일정 기간 걸쳐 측정된 성능, 수치 데이터


## Observability 를 위해 필요한 것

### 운영 데이터의 중요성
- 모든 시스템은 어떤 기능이나 서비스를 하기 위해서 동작
- 그 목적을 달성하는 지를 지속적으로 관찰할 필요가 있다.
- 코드를 개발하는 것 만큼이나 운영하면서 데이터로 확인하는 것도 중요

### 데이터를 남겨라
- 일단 데이터가 있어야 뭐든 할 수 있다.(Tracing, Monitoring, Observability)

### 지속적인 데이터 observability 경험
- 어떤 데이터가 필요한지 정의하고 추가로 데이터를 남길 수 있도록 개발
- observability 를 등한시한 개발자는 언제 생길지 모르는 에러나 장애에 매일 불안에 떨며 잠을 자게 된다.

### 시스템에 대한 이해
- Observability 의 좋은 경험을 위해서는 필요한 데이터가, 조회하기 적절한 형태로 남아야 한다.
- IT 시스템, 각 어플리케이션의 내부 구조, 로직, 사용 목적이나 용도에 따라서 데이터를 남겨야 한다. 

## 대표적인 Observability 도구들
|Opentelemetry|Datadog|Dynatrace|
|---|---|---|
|오픈소스|Cloud|Cloud + 부분적 On-premise|
|전용 OTLP 프로토콜|쉬운 설치|Java Tracing 도구들의 기능이 더 상세하고 성능이 좋은 편|


## 데이터 엔지니어가 모니터링해야 할 대상
1. host machine
	- Physical machine, Virtual Machine, Container 환경
	- running 여부 / cpu usage / memory usage / disk usage / network I/O (IOPS)
2. OS 상태
	- FD count / socket status and count / cpu,memory,disk per cgroup
3. Process/Application 상태
	- cpu, memory, disk usage of process / open FD count in process
	- 사용하는 프레임워크 레벨에서 진단이 필요한 정보
	- 내 어플리케이션의 로직이나 상태를 확인하기 위한 정보
4. 인프라 환경 정보
	- 리소스가 부족 / 시스템이 운영체제나 machine 과 버전이 안 맞거나 crash 가 나는 것

---

# CH02 Prometheus
## 데이터 수집 방식
|종류|파일을 이용한 수집|Network를 이용한 Push|Network를 이용한 Polling|
|---|---|---|---|
|특징|로그를 파일로만 남김|직접 로그 수집<br/>TCP, HTTP|채널을 통해 Polling으로 scrap<br>Metic 수집에 더 적합|
|장점|어플과 로그 수집기 분리<br>역할/동작 구분되어 유연성 증가|전송의 성공, 실패 여부를 어플에서 판단|어플과 메트릭 수집 분리<br>사용성이 좋고, 확장성이 높음|
|단점|어플과 로그 수집기를 별도로 관리<br>하나의 이상도 전체의 이상으로 판단|어플의 로직과 로그 전송이 서로 영향을 미칠 가능성<br>bottleneck 현상|주기나 시점에 따라 값이 바뀜<br>특정 순간의 정확한 정보 학인에 적합하지 않다|
-  어플 = 어플리케이션
- 필요에 따라 적합한 방식을 사용하는 것이 바람직하다.

## Prometheus 설치
> [매뉴얼 참고](https://prometheus.io/docs/prometheus/latest/getting_started/)
### 요약
```bash
# 설치파일 다운로드
wget https://github.com/prometheus/prometheus/releases/download/v2.40.6/prometheus-2.40.6.linux-amd64.tar.gz
# 압축해제
tar xvfz prometheus-*.tar.gz
# 파일명 변경
mv prometheus-2.40.6.linux-amd64 prometheus
# prometheus 실행
# 실행(위 폴더로 이동하여)
./prometheus --config.file=prometheus.yml
```

`vi /etc/systemd/system/prometheus.service`
```bash
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network.target

[Service]
User=kdc
Restart=on-failure
ExecStart=/data5/kdc/prometheus/prometheus \
  --config.file=/data5/kdc/prometheus/prometheus.yml \
  --storage.tsdb.path=/data5/kdc/prometheus \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target
```
```bash
sudo systemctl daemon-reload
sudo systemctl enable prometheus.service
sudo systemctl start prometheus.service
```

## Pushgateway 설치
[매뉴얼 참고](https://github.com/prometheus/pushgateway/blob/master/README.md)
```bash
# 설치파일 다운로드
wget https://github.com/prometheus/pushgateway/releases/download/v1.5.1/pushgateway-1.5.1.linux-amd64.tar.gz
# 압축해제
tar xvfz pushgateway-*.tar.gz
# 파일명 변경
mv pushgateway-1.5.1.linux-amd64 pushgateway
# prometheus 실행
# 실행(위 폴더로 이동하여)
./pushgateway
```
`vi /etc/systemd/system/pushgateway.service`
```bash
[Unit]
Description=Pushgateway
Wants=network-online.target
After=network-online.target

[Service]
User=kdc
Type=simple
ExecStart=/data5/kdc/pushgateway/pushgateway

[Install]
WantedBy=multi-user.target
```
- 이후 과정은 prometheus 참고

prometheus.yml 을 수정해서 pushgateway 의 데이터도 scrap 되도록 설정
```bash
    - job_name: 'pushgateway'
    honor_labels: true
    static_configs:
        - targets: ['$YOUR_PUSHGATEWAY_IP_OR_DNS:9091']
```
- 위 내용을 `scrap_configs:` 의 하위에 추가

## Prometheus Data
프로메테우스 스토리지는 데이터를 time series로 저장
다만, scrap 하는 쪽에서 time 정보를 기록

### Prometheus Data Format
```bash
# 형식
<metric name>{<label name>=<label value>, ...} number
# 예시
api_http_requests_total{method="POST", handler="/messages"} 1.0
```
- metric name
    - `[a-zA-Z_:][a-zA-Z0-9_:]` 정규식을 만족해야함
    - 띄어쓰기는 `_`로 구분
- label name
    - `[a-zA-Z_][a-zA-Z0-9_]` 정규식을 만족해야함
    - 단, `__`로 시작하는 이름은 예약어이므로 유의
- label value
    - any Unicode characters

### Job & Instance
- Job은 같은 목적, 같은 일을 하는 대상
- Job은 여러 개의 instance를 가짐
    - job 의 value는 ”prometheus_server”
    - instance의 value는 ”server1”, “server2”.. 등으로 실제 서버의 이름이 올 수 있다.

### Metric Type
- 메트릭 타입 : Counter / Gauge / Histogram / Summary
- 타입별로 사용하는 PromQL 이나 대시보드의 형태가 달라짐

1. Counter
    - 증가하는 숫자 메트릭
    - 감소로는 사용하면 안됨
2. Gauge
    - 증가하거나 감소하는 숫자 값을 나타낼 때 사용
3. Histogram
    - 관찰 대상에 대해서 버킷별로 구분해서 저장하고 조회
4. Summary
    - Histogram 과 비슷
    - 관찰 대상에 대한 total count 를 제공하고, 모든 관찰값에 대한 sum 도 제공


### PromQL
> [매뉴얼](https://prometheus.io/docs/prometheus/latest/querying/basics/)을 기반으로 설명

metric 에 대한 집계 또는 변환 작업을 수행하는 쿼리
[Basics](https://prometheus.io/docs/prometheus/latest/querying/basics/) / [Operators](https://prometheus.io/docs/prometheus/latest/querying/operators/) / [Functions](https://prometheus.io/docs/prometheus/latest/querying/functions/) / [Examples](https://prometheus.io/docs/prometheus/latest/querying/examples/)


## Prometheus Server
![Prometheus Server Architecture](https://www.opensourceforu.com/wp-content/uploads/2017/03/Figure1.png)

- 메트릭을 여러 노드로부터 수집하고, Local Storage에 저장
- Local Storage 는 선택할 수 있지만, 기본으로 TSDB를 사용
- scraping (pull, polling) 방식으로 메트릭을 수집
- Metric 대상은 Service Discovery 도구와 연동하면 dynamic 하게 대상을 찾을 수 있다.
    - 간단하게는 IP:Port로도 가능


### Prometheus 의 한계
- 기본적으로 Local Storage 에 데이터를 구성 + 클러스터 구성 x
- TTL(Time To Live) 기반의 데이터이기 때문에 처음부터 대용량을 고려하지 않음

### Thanos
![Untitled](https://yoonsung.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F096fd69f-ff84-4f9a-9975-85bdb93e8a9c%2FUntitled.png?id=ba08a0e5-bc91-40d7-bdea-f3d925ef178a&table=block&spaceId=5d897442-979a-4711-9adc-3bdaa80aace1&width=2000&userId=&cache=v2)

- 확장성 있는 저장소와 그에 맞는 아키텍처로 등장한 툴
- Prometheus 서버는 scrap 의 역할에만 충실하고, 데이터의 저장이나 관리, 조회는 Thanos 에게 위임
- scrap 한 데이터는 Thanos sidecar 에서 chunk 단위로 object storage 로 전송
- Grafana 는 Thanos query 로 prometheus data, promql 을 조회
- query 는 Thanos gateway 와 Thanos sidecar 에 조회를 해서 long-term 데이터(object storage)와 최신 데이터 모두를 조회

---

# CH03 Grafana
> 모니터링을 위한 대시보드
> 무료 + 디자인이 괜찮아 많이 사용한다.

## grafana 설치
```bash
# 설치파일 다운로드
wget https://dl.grafana.com/oss/release/grafana-9.3.1.linux-amd64.tar.gz
# 압축해제
tar -zxvf grafana-9.3.1.linux-amd64.tar.gz
# 파일명 변경
mv grafana-9.3.1 grafana
# prometheus 실행
./bin/grafana-server
```
Grafana는 metadata 저장소로 다음 데이터베이스를 필요로 한다.
- [SQLite 3](https://www.sqlite.org/index.html)
- [MySQL 5.7+](https://www.mysql.com/support/supportedplatforms/database.html)
- [PostgreSQL 10+](https://www.postgresql.org/support/versioning/)
    - `conf/default.ini` 에서 DB 및 포트 수정 가능
    - 기본적으로 SQLite / 3000포트 사용

`vi /etc/systemd/system/grafana.service`
```bash
[Unit]
Description=Grafana instance
Wants=network-online.target
After=network-online.target

[Service]
User=kdc
Group=kdc
Type=simple
Restart=on-failure
WorkingDirectory=/data5/kdc/grafana-9.4.3
ExecStart=/data5/kdc/grafana-9.4.3/bin/grafana-server
LimitNOFILE=10000
UMask=0027

[Install]
WantedBy=multi-user.target
```

## Grafana로 대시보드 구성하기
### 대시보드를 구성
> [매뉴얼 참고](https://grafana.com/docs/grafana/latest/getting-started/build-first-dashboard/) 
1. Datasource 추가하기
2. Create Dashboard
3. Create Panel in Dashboard

### Alert 수신 
> [매뉴얼 참고](https://grafana.com/docs/grafana/latest/alerting/) 
1. Create contact point
2. Create policy
3. Create alert rule (from panel)

---

# CH04 Node Exporter
### Node Exporter 설치
```bash
# 설치파일 다운로드
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
# 압축해제
tar xvfz node_exporter-1.5.0.linux-amd64.tar.gz
# 실행
./node_expoerter
```
- 9100포트를 통해 확인 가능

`vi /etc/systemd/system/grafana.service`
```bash
Description=Node Exporter
After=network.target

[Service]
User=kdc
Group=kdc
Type=simple
ExecStart=/data5/kdc/node_exporter-1.5.0.linux-amd64/node_exporter

[Install]
WantedBy=multi-user.target
```

### Prometheus 에서 Node Exporter Scrap
```bash
# scrape_configs:
  - job_name: node
    static_configs:
      - targets: ["localhost:9100"]
```
- prometheus.yml 의 scrap_configs 에 위 내용 추가


### Node Monitoring Dashboard
- Grafana 사이트에 여러 사람들의 대시보드 json이 있다.
- 가져다 쓰면 편함

1. Dashboards → import 클릭
2. 원하는 대시보드의 ID값 or url or json파일을 넣고 로드
3. data source 선택 후 import
4. save

- 기타 세부 설정이 필요한 경우 구글링

### Metric
> Memory 사용량
> 메모리만 해도 너무 다양한 메트릭이 있다... 잘 구분할 것
- total: `node_memory_MemTotal_bytes`
- used: `node_memory_MemTotal_bytes - node_memory_MemFree_bytes - node_memory_Buffers_bytes - node_memory_Cached_bytes - node_memory_SReclaimable_bytes`
- shared: `node_memory_Shmem_bytes`
- free: `node_memory_MemFree_bytes`
- buff/cache: `node_memory_Buffers_bytes + node_memory_Cached_bytes + node_memory_SReclaimable_bytes`
- available: `node_memory_MemAvailable_bytes`

---

# CH05 Application Monitoring
> 실습 챕터

## 세팅
- Prometheus 에서는 각 언어별로  [client library](https://prometheus.io/docs/instrumenting/clientlibs/)를 제공한다. 
  - 강의 실습은 JAVA를 이용해 진행
- Prometheus format 으로 노출할 수 있는 설정, 각 언어별로 기본 모니터링 시스템을 이용해 메트릭 정보 추출, custom metric을 남기는 기능 등을 할 수 있다.

### build.gradle
```bash
plugins {
    id 'java'
    id 'org.springframework.boot' version '2.7.6' # 3.x버전부터는 자바8 지원x
    id 'io.spring.dependency-management' version '1.0.15.RELEASE'
}

version = '0.0.1-SNAPSHOT'
sourceCompatibility = '1.8' # 3.x버전 이상을 사용하려면 자바 17이상

repositories {
    mavenCentral()
}

# 중략

tasks.named('test') {
    useJUnitPlatform()
}
```

## Custom Metric 구현하기
```bash
static final Counter requests = Counter.build() # Gauge, Histogram, Sumary, Counter
                                           .name("requests_total")
                                           .help("Total requests.")
                                           .labelNames("method", "api")
                                           .register();
```
- 한 번 선언된 메트릭은 static으로 JVM 내에서 global 영역에 존재해야 한다.
- builder pattern 으로 설정한다.
- label 이 있다면 string varags 로 세팅한다.
    - label 은 사용할때 순서대로 맞춰넣어야 하므로 순서가 중요하다.
- register 에서 `CollectorRegistry` 를 지정하지 않으면, default registry 를 사용한다.
    - 다른 framework 내장 registry 와 연동하려면 해당 객체를 등록해주던가, 아니면 default registry 를 역으로 해당 framework 에 등록해야한다.

## Counter 사용하기

1. API 호출 수를 count 하기 위한 counter 정의. 

```bash
static final Counter requests = Counter.build()
                                           .name("requests_total")
                                           .help("Total requests.")
                                           .labelNames("method", "api")
                                           .register();
```

- label 로 HTTP method 와 API 종류를 구분할 수 있게 한다.


2. API의 각 메소드에 다음과 같이 api 별로 count를 할 수 있도록 한다.

```bash
requests.labels($http_method, $api).inc();
```

- 각 메소드에 맞게 $http_method, $api 값을 넣는다.
- inc() 는 atomic 하게 해당하는 counter 를 increment ( = +1) 한다.
    - inc(amount) 함수로 원하는 양만큼 증가시킬 수도 있다.

3.  Counter Monitoring

Req/s by API

```java
sum by (method, api) (irate(requests_total[$__rate_interval]))
```

## Histogram 사용하기

1. Website 호출 latency 를 측정하기위한 Histogram 정의

```bash
static final Histogram remoteSiteLatency = Histogram.build()
                                                     .name("remote_website_latency_seconds")
                                                     .help("Request latency in seconds.")
                                                     .labelNames("site")
																										 .buckets(0.1, 0.5, 0.8, 0.9, 0.95, 0.99, 1)
                                                     .register();
```

- label로 site 를 구분할 수 있게 했다.

2. 명시적으로 timer 에 값 넣기

```java
long startTime = System.currentTimeMillis();
String response = restTemplate.getForObject(site, String.class);
remoteSiteLatency.labels(site).observe((System.currentTimeMillis() - startTime) / 1000);
```

3. timer 로 측정 끝 구간 알기

```java
Histogram.Timer timer = remoteSiteLatency.labels(site).startTimer();
String response = restTemplate.getForObject(site, String.class);
timer.observeDuration();
```

4. try-with-resource 구문에서 사용하기

```java
        try (Histogram.Timer requestTimer = remoteSiteLatency.labels(site).startTimer()) {
            String response = restTemplate.getForObject(site, String.class);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.unprocessableEntity().body(e.getMessage() + e.getStackTrace());
        }
```

5. Histogram Monitoring

0.95 0.99 등 worst 를 histogra_quantitile 함수로 aggregation 해서 집계한다.

Histogram latency .95 by site

```java
histogram_quantile(0.95, sum(rate(remote_website_latency_seconds_bucket[5m])) by (le, site))
```

- unit: seconds