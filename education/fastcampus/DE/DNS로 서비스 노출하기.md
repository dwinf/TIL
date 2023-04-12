## 1 DNS(Domain Name System)

DNS는 사람이 기억하기 쉬운 도메인 이름(hostname)을 컴퓨터가 인식할 수 있는 IP address로 변환해주는 서비스/시스템(인터넷 전화번호부) 이다.
`google.com` , `naver.com` 의 주소를 브라우저에 입력하면, 각각 google의 서버, naver의 서버로 연결해서 데이터를 받아올 수 있는 것은 DNS가 google의 서버, naver의 서버의 주소를 찾아주기 때문이다.

### DNS 서버의 종류
![](https://www.cloudflare.com/img/learning/dns/what-is-dns/dns-record-request-sequence-1.png)
1. DNS recursor
	- 클라이언트로부터 요청(query)을 받는 서버
	- 이미 처리한 적있는 DNS 주소에 대해서는 캐시를 통해서 빠르게 응답
	- 사서(도서관에서 책의 위치를 아는)

2. Root nameserver
	- 도메인 이름(hostname)을 IP주소로 바꾸는 첫번째 단계
	- hostname의 IP 주소를 얻을 수 있는 특정 위치에 물어보도록 연결
	- 도서관의 카테고리 안내 색인/방향표

3. TLD nameserver
	- TLD(최상위 도메인, Top Level Domain) 서버는 특정 IP주소 검색의 다음 단계
	- com, org, net, kr 등 호스팅 
	- 도서관의 특정 책장

4. Authoritative nameserver
	- hostname에 해당하는 IP 주소를 가지고 있는 담당 서버
	- DNS로부터 IP주소를 찾는 마지막 단계이다. 
	- authoritative nameserver 가 요청한 레코드의 접근을 했었다면, IP 주소를 리턴할 수 있다. 
	- 이렇게 얻은 IP주소는 DNS Recursor 에게 전달한다. 
	- 책장에서 실제 책이 어디있는지 찾을 수 있는 사전


### DNS lookup
![](https://www.cloudflare.com/img/learning/dns/what-is-dns/dns-lookup-diagram.png)


### DNS Caching
위 과정처럼 dns 주소를 찾는 과정을 매번 거친다면 시간 / 비용적 손해가 발생
한번 얻어둔 ip를 저장해두고 매번 사용 == DNS Caching
Caching은 기본적으로 TTL

OS 단계에서도 DNS Caching을 하기 때문에 브라우저에서 miss가 되더라도 OS에서 hit 되는 경우가 많음. OS에서도 찾지 못하면 DNS resolver에 IP주소를 찾기 위한 요청을 전달

---

#### Recursive Resolver 에서의 Caching

Recursive resolver가 client로부터 요청을 받으면 다음과 같은 순서로 캐시를 확인한다.

1.  resolver 가 해당 도메인의 A Record(IP address)를 가지고 있는 경우, 바로 응답한다.
2.  resolver 가 A Record(IP address) 는 가지고 있지 않지만, authoritative nameserver의 NS record(domain)을 가지고 있는 경우. 이 경우에는 앞의 과정을 생략하고 바로 authoritative nameserver로 요청을 전송한다. 위 `1.2 DNS lookup을 하는 과정`에서 6단계로 바로간다.
3.  resolver 가 도메인의 TLD 정보를 가지고 있지만 NS record를 가지고 있지 않은 경우, resolver 는 TLD 서버에게 요청한다. 위 `1.2 DNS lookup을 하는 과정`에서 4단계로 바로 간다.
4.  위 1,2,3이 아닌 경우, root server에게 질의하는 것부터 모두 수행한다.


## 1.4 Linux 에서의 DNS 관련 설정

리눅스에서 DNS resolver 설정은 **/etc/resolv.conf** 에 있다. 특정 DNS를 못찾는 경우 이 설정이 잘못되었거나, 내가 찾고자하는 DNS를 찾아줄 수 있는 nameserver 가 등록이 안되어있는지 확인해보아야 한다.

-   ubuntu의 경우 DNS를 설정하기 위해서는 `systemd-resolved.service`를 사용해서 수정해야한다.

별도의 전용망 또는 kubernetes cluster 에 속한 노드 등, 외부 인터넷에 연결되지 않은 환경에서는 DNS 문제가 생겼을 때 이 파일을 확인하는 것이 1번이다.

---
---

# 2 AWS에서 DNS 사용하기

## 2.1 Router53 설정하기

### 2.1.1 DNS 생성하기

[공식문서](https://docs.aws.amazon.com/ko_kr/Route53/latest/DeveloperGuide/domain-register.html)

1.  [Route53 Dashboard](http://console.aws.amazon.com/route53/v2/home#Dashboard) 또는 [Registered Domain](http://console.aws.amazon.com/route53/home#DomainListing) 페이지에 접속
2.  Register Domain 에서 원하는 도메인 이름을 입력하고 Check
3.  비슷한 이름, 확장자별 가격을 확인하고 자신이 원하는 것을 add-to-cart, continue
4.  Registrant Contact 에서 정보를 입력하고 continue
5.  Contact detail 을 확인하고, 인증서 자동갱신 여부를 체크하고, 하단의 Terms and Condition 에서 agree.
6.  Complete Order
7.  [console.aws.amazon.com/route53/home#DomainRequests](http://console.aws.amazon.com/route53/home#DomainRequests:) 에서 Pending 중인것 확인
    1.  생성까지 수분~1시간이 걸릴 수 있다.
8.  도메인 생성 요청이 완료가되면, [console.aws.amazon.com/route53/home#DomainListing](http://console.aws.amazon.com/route53/home#DomainListing:) 에서 Registered Domain 에서 확인할 수 있다.
9.  Register 단계에서 입력한 이메일로 verify email 이 도착해 있다. 해당 이메일의 link를 클릭해서 valid email인것을 인증해야한다. 인증하지 않으면 수시간 후에 domain 주소가 막힌다.
    1.  이메일 제목: “Verify your email address for $yourdomain”
    2.  이메일 발신자: **[noreply@domainnameverification.net](mailto:noreply@domainnameverification.net)** or **[noreply@registrar.amazon.com](mailto:noreply@registrar.amazon.com)**

### 2.1.2 Record 설정하기

생성한 도메인의 Hosted Zone 설정에 들어가면, 기본으로 NS, SOA 설정이 되어있다. ([NS, SOA에 대한 설명](https://docs.aws.amazon.com/ko_kr/Route53/latest/DeveloperGuide/SOA-NSrecords.html))

-   특별한 경우가 아니면 이 설정은 바꾸지 않는다.

1.  Create Record
2.  subdomain 설정을 하려면 subdomain 이름을 입력한다.
    1.  실습에서는 simple 선택
3.  Record Type 을 설정한다.
    1.  EC2 의 IP주소를 입력하려면 A 타입을 선택한다.
4.  Value에 DNS로부터 연결을 원하는 주소를 입력한다.
    1.  EC2의 public IP 를 입력한다.
5.  TTL은 routing 정책을 얼마 주기로 DNS서비스가 유지하는지를 나타낸다.
    1.  즉 routing 정책이나 주소의 변화가 있을때, 이 시간만큼은 client 입장에서 변화가 없을 수 있다.
    2.  실습에서는 변화를 빠르게 확인해야하므로 1m 을 선택한다.
    3.  상용 서비스에서는 짧을 필요는 없다. 5분~10분을 정적수준으로 본다.
6.  Routing Policy를 선택한다.
    1.  여기서는 simple

### 2.1.4 host/nslookup 명령어로 연결 확인하기

host, nslookup 명령어는 리눅스에서 DNS를 lookup 해서 Record, IP 정보 등을 간단하게 확인할 수 있는 명령어이다.

-   최신 리눅스 버전에서는 host 를 사용하도록 권장한다.

다음과 같이 내가 설정한 EC2의 Public IP 주소가 나오는지 확인한다.

```bash
$ nslookup simple.my-de-sample-fc.link
Server:		1.214.68.2
Address:	1.214.68.2#53

Non-authoritative answer:
Name:	simple.my-de-sample-fc.link
Address: 13.125.255.35
```

```bash
$ host simple.my-de-sample-fc.link
simple.my-de-sample-fc.link has address 13.125.255.35
```

SSH Port 에 inbound가 허용되어있다면, 다음과 같이 DNS를 통해서 EC2에 ssh에 접속할 수도 있다.

```bash
ssh -i $mykey ubuntu@simple.my-de-sample-fc.link
```

## 3 GSLB - 안정적인 서비스를 위한 DNS 설정

### 3.1 글로벌 DNS 브랜드

대표적으로 다음과 같은 브랜드/제품들이 GSLB를 제공하고 있다.

1.  AWS, GCP, Azure
2.  Akamai
3.  Cloudflare
4.  Citrix
5.  NGINX
6.  (국내)NCloud
7.  (국내)NHNCloud

### 3.2 GSLB란?

GSLB는 Gloabl Server Load Balancing의 약자이다. 이름을 보면 LoadBalancer 의 일종 같지만, 실제로는 client 가 전세계 어디에 있던지 빠르게 신뢰성있는 응답을 제공하기위한 지능적인 DNS라고 이해하는 것이 더 정확하다. 초기에는 전 세계에 퍼져서 DNS 서비스를 제공할 수 있다는 것으로 알려졌지만, 그것을 위해 기능적으로 많은 것들이 필요해서 필요한 기술의 총체로 말할 수 있다.

#### 3.2.1 GSLB의 주요 기능들

GSLB 제품이나 서비스마다 제공하는 기능이나 특이점이 다를 수 있지만, 통상 아래와 같은 기능들을 제공할 때 GSLB가 가능하다고 볼 수 있다.

-   **Performance**: client의 request를 네트워크상 가까운 서버로 연결할 수 있다. 트래픽을 지역에 맞게 분산해서 연결할 수 있다.
-   **Customized Content**: 지역이나 언어별로 커스텀한 콘텐츠를 자동으로 제공할 수 있다.
-   **Disaster Recovery**: 네트워크 장애나 데이터센터 장애 등이 발생했을 때, 다른 지역에 있는 서버로 redirect해서 HA(high availability) 구성이 가능하게 한다.
-   **Maintenance**: 연결 규칙이나 구성이 (쉽게, 소프트웨어적으로) 변경 가능해야한다.
-   **Compliance**: 국가나 지역의 규제에 맞게 요청을 전달할 수 있다.

따라서 자신이 글로벌 클라이언트에게 서비스 노출하는 개발자라면, GSLB 기능을 지원하는 DNS 회사, 제품, 설정을 이용하는 것이 좋다.

---
---

## AWS Route53에서 Routing 설정
> AWS에서는 GSLB라고 따로 정의한 상품이 있지는 않지만, Route53의 라우팅 정책을 통해서 GSLB의 기능적인 목표를 달성할 수 있다.

### Failover
- dns/server 로 연결이 안될 때 대체 서비스로 연결하도록 함
- 사용되고 있는 Failover 구성을 하고 싶으면 weighted를 사용해서 이중화와 리소스 사용률을 다 잡을 수 있다. 배포가 누락되어 버그가 발생하는 것도 방지할 수 있다.
장점
- 장애상황에 대비하여 안정적인 서비스 제공
단점
- 사용하지 않는 인프라를 여분으로 둬야함
	- 관리되지 않아 Failover가 발생해도 사용자 입장에서 버그가 발생


### Failover 실습 - nc command 로 TCP 연결 받기

nc(netcat) 명령어로 간단하게 echo 서버를 띄울 수 있다.

다음 명령어를 자신의 EC2 서버에서 수행하자.

```bash
nc -l -p 2000 -k
```

-   -l [localhost](http://localhost)
-   -p 2000 해당 포트로 listen 한다.
-   -k 응답 후에도 계속 살아있다.

다른 클라이언트(서버 또는 자신의 컴퓨터)에서 해당 EC2 서버에 요청을 보내고, EC2서버의 nc 에서 echo가 이루어지는지 확인한다.

```bash
echo hi | nc $ec2_public_ip 2000
```

### Failover 실습 - Health Check 생성

HealthCheck를 통해서 정상/비정상 판단이 되어야, Failover 전략을 수행할 수 있다.

HealthCheck 의 [종류](https://docs.aws.amazon.com/ko_kr/Route53/latest/DeveloperGuide/health-checks-types.html)마다 비정상으로 판단하는 방법이 다르다. 구체적인 기준은 [문서](https://docs.aws.amazon.com/ko_kr/Route53/latest/DeveloperGuide/dns-failover-determining-health-of-endpoints.html)를 확인한다.

실습에서는 endpoint 모니터링 > 프로토콜 > TCP 연결을 확인한다.

1.  HealthCheck [Home](http://aws.amazon.com/route53/healthchecks/home#/) 에서 Create HealthCheck
2.  What to monitor: Endpoint
3.  Specify endpoint by: IP address
4.  Protocol: TCP
5.  IP address: 자신의 EC2 public IP
6.  port: 자신이 띄운 nc process의 port
7.  Advanced Configuration 에서 자신의 서비스에 필요한 것을 설정한다.
    -  실습에서는 빠른 확인을 위해 interval=10s, failure threshold=1로 설정한다.
8.  Alarm 연동이 필요한 경우(cloudwatch등) 설정한다.

위의 방식으로 두대의 EC2 서버에 대해서 각각 health check 를 생성한다.

-   두대의 EC2 서버에 접속해서 4.1.3 의 nc 커맨드로 port를 listen 해둔다.

### Failover 실습 - record 생성

Hosted zones > 자신의 record > Create Record 를 선택한 후 다음 설정으로 레코드르 생성한다.

1.  Record 1에 대해서
    
    1.  Record name: failover
    2.  Record type: A
    3.  Value: 첫번째 서버의 IP주소
    4.  TTL: 1m
    5.  Routing Policy: Failover
    6.  Failover record type: Primary
        -  health check 가 정상이라면, 이 연결로만 라우팅한다.
    7.  Health check ID: 첫번째 서버에 해당하는 healthcheck
    8.  Record ID: failover-primary
        -  같은 record name에 대해서 구분하기 위해서 사용
2.  Add another record 버튼을 눌러서 Record 2를 만든다.
    
    1.  아래 설정 외에는 Record 1과 동일하다.
    2.  Failover record type: Secondary
        -  Primary 가 unhealthy 상태라면 이 연결로 라우팅한다.
    3.  Health check ID: 두번째 서버에 해당하는 healthcheck
    4.  Record ID: failover-secondary
        -  같은 record name에 대해서 구분하기 위해서 사용


### Failover 실습 - record 생성

Hosted zones > 자신의 record > Create Record 를 선택한 후 다음 설정으로 레코드르 생성한다.

1.  Record 1에 대해서
    
    1.  Record name: failover
    2.  Record type: A
    3.  Value: 첫번째 서버의 IP주소
    4.  TTL: 1m
    5.  Routing Policy: Failover
    6.  Failover record type: Primary
        -  health check 가 정상이라면, 이 연결로만 라우팅한다.
    7.  Health check ID: 첫번째 서버에 해당하는 healthcheck
    8.  Record ID: failover-primary
        -  같은 record name에 대해서 구분하기 위해서 사용
2.  Add another record 버튼을 눌러서 Record 2를 만든다.
    
    1.  아래 설정 외에는 Record 1과 동일하다.
    2.  Failover record type: Secondary
        -  Primary 가 unhealthy 상태라면 이 연결로 라우팅한다.
    3.  Health check ID: 두번째 서버에 해당하는 healthcheck
    4.  Record ID: failover-secondary
        -  같은 record name에 대해서 구분하기 위해서 사용
