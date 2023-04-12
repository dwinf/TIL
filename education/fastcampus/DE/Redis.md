# Redis

## CacheDB
캐시란 미래의 사용될 데이터를 빠르게 조회할수 있는 곳에 (복제하여)두고 사용하는 것을 의미

cache hit : 조회하는 데이터를 캐시에서 찾음
cache miss : 조회하는 데이터를 캐시에서 못찾음
hit ratio : access 시도 횟수 대비 cache hit 비율. 이 값이 높으면 캐시가 비용효율적(cost-effective)하다

### 사례
- cache에 hit되는 경우 메모리 IO에 의한 속도를 줄일 수 있다
- 데이터베이스에서 인덱싱 데이터는 메모리에 올려두고 관리하기 때문에, 인덱싱 기준으로 조회하면 조회속도가 빠르다.

### 고려사항
- 언제든 유실될 수 있음(임시 데이터니까)
- 용량이 (상대적으로) 적고, 용량의 비용이 비싸다
- Cache hit ratio 를 측정하고 높일 수 있는 방법을 고민

### Cache(In-memory) DB란
데이터를 메모리에만 저장한 뒤, 빠른 데이터 조회 및 저장을 제공하는 데이터베이스
단, 메모리가 디스크보다 비싸고 용량 확장에 제한이 있기에 DB특징을 고려하여 선택적으로 사용해야 한다.

### CacheDB 종류
1. memcached
key-value 형식의 데이터 저장 및 조회
멀티 스레드로 데이터를 다룸
    - 트래픽이 몰려도 응답 속도는 비교적 안정됨
한 번 저장된 후, 변경되지 않는 정보를 저장할 때 유용

2. redis
다양한 자료구조를 API로 제공(key-value 형식)
싱글 스레드
    - 한 번에 하나의 client만 자료를 저장/조회 하기 때문에 데이터 lock없이 빠르게 데이터를 조회
    - 트래픽이 몰리면 응답속도가 불안정
Disk 에 persistent 하게 데이터를 백업 가능(성능의 손해 有)

3. couchbase
In-Memory First Document Database
ocument 단위로 저장하고, Document내의 필드도 key-value로 조회
조회속도도 빠르고, 분산 클러스터 아키텍처로 구성되어 있어서 확장성도 좋다
특정 자료구조를 원하는 경우에는 다른 db보다 느릴 수 있다


## 레디스의 key
모든 자료구조는 키밸류 형식/ 저장과 조회는 키를 기준으로 함
키는 바이너르 시퀀스로 바이너리-세이프하다. 
-> 무엇으로 하던 앞에서부터 byte 단위로 비교

### Key 설계 시 고려사항
1. Avoid long key
	- 메모리를 더 많이 차지하고 key 비교 연산 등에서도 비용이 많이 든다.
	- Key의 크기는 1K를 넘지 않도록
	- 키에 사용되는 데이터가 크면 hashing을 통해 유니크함 보장 + 특정 길이로 줄이는 방법을 추천
		- SHA1, SHA256 등
	- 키의 최대 사이즈는 512MB
2. Avoid too short key
	- 짧으면 메모리를 조금 사용할 것 같지만 크게 차이 없고, 비교연산 드엥서도 큰 차이가 없다.
	- 그렇게 줄인 **key의 의미를 파악할 수 없는 경우** 개발, 운영 과정에서 버그나 문제를 야기
		- 성능 이상의 문제
	- 과한 축약어로 키를 설계하게 되면 그 키를 설명하기 위한 별도의 문서를 작성해야할 필요가 생김
3. Try to stick with schema
	- 키안에 포함되어 있는 정보가 의미가 있다면, schema를 가지는 것은 좋은 방법
	- - object-type:id
	    - user:1000
	- dash(-), dot(.) 으로 구분한 multi word
	    - comment:4321:reply.to
	    - comment:4321:reply-to

---

## Strings
String 은 bytes를 그대로 저장
	즉, text 뿐만 아니라 어떤 object나 binary를 bytes 로 serialized 한 형태로 저장
하나의 String 은 512MB가 최대

### commands
- **[`SET`](<https://redis.io/commands/set>)** 지정한 key에 원하는 value 를 저장한다. 아래는 함께 쓰일 수 있는 옵션들
    - **`EX`** _seconds_ -- 지정한 시간(초, seconds)만큼 지난 뒤에 expire
    - **`PX`** _milliseconds_ -- 지정한 시간(밀리초, milliseconds)만큼 지난 뒤에 expire
    - **`EXAT`** _timestamp-seconds_ -- 지정한 시간(unix timestamp seconds)에 expire
	    - unix timestamp는 UTC를 기준으로 하기 때문에 주의
    - **`PXAT`** _timestamp-milliseconds_ -- 지정한 시간(unix timestamp milliseconds)에 expire
    - **`NX`** -- SETNX와 같음
    - **`XX`** -- Key가 존재하면 Set.
    - **`KEEPTTL`** -- Key가 존재하는 시간. EX, PX 류와 동시사용 불가.
    - **`GET`** -- Set하기 이전의 string을 리턴. 이전에 존재하지 않았으면 nil을 리턴. **`SET`** 이전에 존재하던 값(value)이 String이 아니면 Set을 취소하고 error를 리턴
- **[`SETNX`](<https://redis.io/commands/setnx>)** 지정한 key가 존재하지 않으면, key와 value를 저장한다.
    - **lock을 구현할 때** 유용하다.
    - 분산 환경에서 deduplication 을 적은 비용으로 구현할 수 있다.
    - SET if Not eXist
- **[`GET`](<https://redis.io/commands/get>)** 지정한 key에 저장된 value를 가져온다.
- **[`MGET`](<https://redis.io/commands/mget>)** 여러개의 key에 저장된 값을 한 번에 가져온다.

### Counter commands
key에 대해서 숫자를 atomic하게 증가/감소 시키고 그 결과를 리턴
분산환경에서 덧셈 뺄셈 연산을 lock free로 구현할 때 주로 사용
- **[`INCR`](<https://redis.io/commands/incr/>)** 지정한 key의 value를 1씩 증가시킨다.
    - counter 를 lock free로 구현할 때 유용하다.
    - rate limiter를 구현할 때도 쓸 수 있다.
- **[`INCRBY`](<https://redis.io/commands/incrby>)** 지정한 key의 value로 정수형 숫자를 가지고, 그 숫자를 atomic하게 숫자를 증가/감소 시킨다.
	- INCRBY counter 3
- **[`INCRBYFLOAT`](https://redis.io/commands/incrbyfloat)** 지정한 key의 value로 소숫점 숫자를 가지고, 그 숫자를 atomic하게 숫자를 증가/감소 시킨다.
	- INCRBYFLOAT counter 0.3

## 자료구조
### Lists
> key에 리스트 저장, [Document](https://redis.io/docs/data-types/lists/)
- L이 Head, R이 Tail을 의미
- 리스트 원소의 최대 갯수는 2^32 - 1 개
- Stack, Queue 등을 구현하는데 사용

#### Commands
- **[`LPUSH`](<https://redis.io/commands/lpush>)** 새 원소를 Head에 추가한다.
- **[`RPUSH`](<https://redis.io/commands/rpush>)** 새 원소를 Tail에 추가한다.
- **[`LPOP`](<https://redis.io/commands/lpop>)** Head의 원소를 지우고 리턴한다.
- **[`RPOP`](<https://redis.io/commands/rpop>)** Tail의 원소를 지우고 리턴한다.
- **[`LLEN`](<https://redis.io/commands/llen>)** 리스트의 길이를 리턴한다.
- **[`LMOVE`](<https://redis.io/commands/lmove>)** atomic하게 한 리스트의 원소들을 다른 리스트로 옮긴다.
    - Reliable Queue를 구현하는데 사용할 수 있다. (LMOVE, LREM 이용)
    - Circular List를 만들 수 있다. (source, destination을 같은 리스트로)
- **[`LTRIM`](<https://redis.io/commands/ltrim>)** 지정한 range 만큼의 원소들을 남기고 나머지를 지운다.
    - -1 은 마지막 원소를 뜻한다.
    - 주의: 지우는 대상이 많을 수록 시간이 오래걸린다. O(N)
- **[`BLPOP`](<https://redis.io/commands/blpop>)**
    - LPOP과 같다. 만약 리스트가 비어있다면 새로운 원소가 들어올 때까지 기다린다.(blocking) 단, timeout발생 이전까지 기다린다.
- **[`BLMOVE`](<https://redis.io/commands/blmove>)**
    - LMOVE와 같다. source의 리스트가 비어있다면 새로운 원소가 들어올 때까지 기다린다.


### Sets
> Set 자료구조, [Document](https://redis.io/docs/data-types/sets/)
- **정렬되지 않은 unique string 데이터**(member)에 대한 집합을 저장할 때 쓴다.
- 대부분 command의 시간복잡도가 O(1) 이지만, 그렇지 않은 command의 경우 주의해서 사용해야한다.
- 하나의 Set에 들어갈 수 있는 member의 사이즈는 최대 2^32 - 1
	- 10만개 이하로 관리하는 것이 defacto guide이다.
- 사용 사례
	- **유일한 원소**를 저장/조회할 때 쓴다.
	- 관계를 표현할 때 쓴다.
	- **집합연산**을 하고 싶을 때 쓴다.

#### Commands
- **[`SADD`](<https://redis.io/commands/sadd>)** Set 에 새로운 member를 추가한다.
- **[`SREM`](<https://redis.io/commands/srem>)** Set 에서 특정 member를 삭제한다.
- **[`SMEMBERS`](<https://redis.io/commands/smembers/>)** Set에 저장된 모든 member를 리턴한다.
    - O(N)의 시간복잡도를 가지고, memeber가 많은 경우 레디스에 부하를 주거나 다른 commands를 느리게할 수 있으므로 주의해야한다. SMEMBERS보다는 [**`SSCAN`**](https://redis.io/commands/sscan)을 통해서 부분조회하는 것을 권장한다.
- **[`SISMEMBER`](<https://redis.io/commands/sismember>)** 주어진 String이 Set에 존재하는지 확인한다.
    - SMEMBERS 와 마찬가지로 O(N)의 시간복잡도를 가진다.
- **[`SINTER`](<https://redis.io/commands/sinter>)** 주어진 두 개 이상의 Set에 모두 존재하는 member들을 리턴한다. (교집합)
    - worst case O(N*M) - N은 cardinality, M은 비교대상이 되는 Set의 갯수
- **[`SCARD`](<https://redis.io/commands/scard>)** Set의 size(cardinality)를 조회한다.


### Sorted Sets
> 정렬기능이 있는 Set 자료구조, [Document](https://redis.io/docs/data-types/sorted-sets/)

- unique string 데이터(member)를 score 정보로 정렬된 형태의 집합으로 저장할 때 쓴다.
- 같은 score 정보를 가진 memeber가 여러개 있다면, 문자열순(lexicographically)으로 정렬한다.
- 사용 사례
	- Ranking: 높은 score 순으로 실시간 정렬을 가진 자료가 필요할 때 쓸 수 있다.
	- Sliding-Window를 가진 Rate Limiter를 구현할 수 있다.

#### Commands
- **[`ZADD`](<https://redis.io/commands/zadd>)** 새로운 member를 score 값과 함께 추가한다. 이미 존재하는 member라면 score를 업데이트 한다.
	- `ZADD rank 1 one`
- **[`ZRANGE`](<https://redis.io/commands/zrange>)** 주어진 Range(start stop)에 해당하는 member들을 리턴한다.
	- `ZRANGE myzset 0 -1`
	- `WITHSCORES` 옵션 : 멤버의 score 값을 함께 리턴
- **[`ZRANK`](<https://redis.io/commands/zrank>)** 주어진 key에서 member의 rank를 리턴한다. Ranking은 **0부터 시작**하는 오름차순이다. (0 = lowest) / score의 오름차순으로 ranking
    - **[`ZREVRANK`](<https://redis.io/commands/zrevrank>)** 0이 가장 높은 Ranking (0=highest) / score의 내림차순으로 ranking
- **[`ZCARD`](https://redis.io/commands/zcard/)** 주어진 key에 해당하는 memeber의 수(cardinality)를 구한다.
- **[`ZREMRANGEBYSCORE`](<https://redis.io/commands/zremrangebyscore/>)** 주어진 key에서 주어진 min, max 이내의 (inclusive) score를 가지는 member를 삭제하고, 삭제된 memeber의 수를 리턴한다.
	- `ZREMRANGEBYSCORE rank 1.1 2`
	- score값이 1.1 ~ 2에 해당하는 member 삭제
    - 시간 복잡도 **O(log(N)+M)**
        - N: sorted set에 저장된 member의 수
        - M: 지워질 대상의 member의 수
    - 위 시간복잡도 때문에 대량의 데이터가 저장되어있는 자료구조일수록 성능문제가 발생할 수 있다. 따라서 적절한 수를 유지하도록 **[`EXPIRE`](https://redis.io/commands/expire/)** 또는 **[`ZREMRANGEBYSCORE`](<https://redis.io/commands/zremrangebyscore/>)** 로
    - 관리할 필요가 있다.
        - 1개의 key에 10만개의 member를 넘지 않는 것이 defacto guide(=국룰).

#### sliding-window rate limiter 구현

**Rate Limiter**
- 단위 시간당 요청/처리량을 제한을 두기 위한 소프트웨어적 기법
- 악성 사용, 비정상적인 동작에 의한 시스템/로직의 문제 등을 사전 방지
- 결제시스템, 로그인의 단위 시간당 시도 횟수 제한 등

**Sliding-Window**

- window: 판단을 위해 정해놓은 시간의 구간(1초, 1분, 1시간 등)
- sliding-window: 판단의 대상이 되는 시간의 구간이 이동
	- 고정적인 시간 단위로 검증하는 것이 아닌, 현재 시간에 따라서 판단의 시간 구간이 정해짐
- TCP/IP 프로토콜에서 Flow Control할때 sliding window에 기반한 판단을 한다.


### HyperLogLog (HLL)
> 하나의 set에서 cardinality를 추정하기 위한 데이터 구조, [Document](https://redis.io/docs/data-types/hyperloglogs/)

HLL를 이용하면 작은 메모리(최대 12 KB)를 이용해서 많은 수의 데이터의 cardinality를 **추정치**(0.81% 의 표준 오차율)로 계산

HLL의 동작원리에 대한 수학적인 설명이 굳이 궁금하다면 다음 글을 참고
- [확률적 자료구조를 이용한 추정 - Cardinality 추정과 HyperLogLog](https://d2.naver.com/helloworld/711301)

하나의 Key에 대해서는 O(1)를 보장
	- key를 여러개 준 경우 O(N) 이상으로 늘어난다.

#### Commands
-   **[`PFADD`](<https://redis.io/commands/pfadd>)** 주어진 Key의 HLL 자료구조에 데이터를 추가한다.
-   **[`PFCOUNT`](<https://redis.io/commands/pfcount>)** 주어진 Key들의 HLL count의 합을 리턴한다.
    -   이 합은 각각의 cardinality의 합이 아니라 주어진 key에 넣은 모든 데이터에 대한 cardinality 값의 합이다.
-   **[`PFMERGE`](<https://redis.io/commands/pfmerge>)** 여러개의 HLL를 하나로 합친다. 합집합.
    -   이 합은 각각의 cardinality의 합이 아니라 주어진 key에 넣은 모든 데이터에 대한 cardinality 값의 합이다.


#### 주의사항
대량의 데이터에 대해서 실시간 추정치 count를 하기위해서 Redis의 HLL를 이용하는 경우, 아무리 **[`PFADD`](<https://redis.io/commands/pfadd>)** command가 O(1)를 보장하더라도, 같은 key에 대해서 처리할 수 있는 요청량은 한계가 있다. (클러스터를 쓰더라도 결국 하나의 key는 하나의 노드에서 처리한다.)

-   [링크](http://redisgate.kr/redis/command/hyperloglog.php)에 따르면, 1백만개의 PFADD에 5.23초 소요
-   초당 십만개 이상의 데이터라면 하나의 key로 HLL을 담기에는 client의 응답시간이 너무 느려질 수 있다.

이 경우 key를 분산해서 HLL 자료구조를 사용한 다음, count가 필요할 때 **[`PFCOUNT`](<https://redis.io/commands/pfcount>)** 또는 **[`PFMERGE`](<https://redis.io/commands/pfmerge>)** 를 이용해서 최종 cardinality 를 구하는 것을 추천한다.

---

## Redis 사용과 운영
Redis는 In-Memory Database이다. 메모리는
	- 용량이 클수록 가격이 비쌈
	- 데이터가 휘발성
이라는 특징이 있음

따라서, 컴퓨터가 **종료되더라도 데이터가 유지**되도록 고민해야하고 **비정상 종료가 되지 않도록** node를 관리

### Key Eviction
maxmemory를 넘지 않도록 하기 위한 key 관리 규칙(어떤 key를 제거해야 하는가)

**maxmemory 설정**
- redis.conf 중 `maxmemory` 값으로 설정
	- 64bit 환경에서는 0이 기본값 == limit이 없다
- Redis가 관리하는 memory는 추정치이기 때문에 가용한 총 memory보다 적게 주어야 오차가 있어도 관리가 가능


---
### 3.1.1 maxmemory 설정

redis.conf 파일에 `maxmemory` 키로 max memory를 설정한다.

-   0은 limit이 없다.
    -   64bit system은 기본값이 0
    -   32 bit system은 기본값이 3GB

Redis가 관리하는 memory는 추정치이다. maxmemory는 해당 노드에 Redis가 가용한 총 memory보다 조금 적게 주어야 오차가 있더라도 관리가 된다.

### 3.1.2 Eviction이 동작하는 과정

1.  client가 새로운 command를 요청하고, 그 결과 새로운 데이터가 추가된다면 다음 2과정으로 넘어간다.
2.  memory usage를 확인하고 maxmemory limit을 넘는지 확인한다. 넘는다면, eviction policy에 따라서 key를 eviction한다.
3.  새로운 command를 실행한다.
    1.  Eviction policy가 noeviction 이었다면, error를 리턴한다.

### 3.1.3 Eviction Policies

conf 파일에 **`maxmemory-policy`** 키로 설정할 수 있다.

-   **noeviction**: memory limit에 다다르면, 새로운 값을 저장할 수 없다. (client의 command는 error를 리턴받는다.) replication을 적용하는 경우, 이 설정은 primary database(원본)에만 적용 가능하다.
-   **allkeys-lru**: 최근에 사용된 key를 유지한다. 사용한지 오래된 key(LRU, least recently used)를 제거한다.
-   **allkeys-lfu**: 자주 사용하는 key를 유지한다. 자주 사용되지 않은 key(LFU, least frequently used)를 제거한다.
-   **volatile-lru**: 정책은 LRU이지만, expire 가 설정된(true) key에 대해서만 지운다.
-   **volatile-lfu**: 정책은 LFU이지만, expire 가 설정된(true) key에 대해서만 지운다.
-   **allkeys-random**: Random하게 지운다.
-   **volatile-random**: Random이지만, expire 가 설정된(true) key에 대해서만 지운다.
-   **volatile-ttl**: expire가 설정된(true) key 중에서 TTL(time-to-live)이 짧은 순으로 지운다.

### 3.1.4 Redis 세팅(운영자)을 위한 Eviction 가이드

Eviction policy는 runtime에 변경이 가능하다.

-   **`[INFO](<https://redis.io/commands/info>)`** 의 결과 cache misses 수가 증가하는 것을 보고 수정의 근거를 찾는 것이 바람직하다.

When: Application 개발자들이 어떻게 사용할지 모르고, expire를 설정하는 것의 가이드가 잘 되어있지 않다면

-   Use: **allkeys-lru**

When: Application 개발자들이 어떻게 사용할지 모르고, expire 설정하는 것의 가이드가 잘 되어있지 않은데, Key의 분배가 고르고 사용 패턴이 일정하다면

-   Use: **allkeys-random**

When: Application 개발자들이 어떻게 사용할지 모르지만, expire가 대부분 설정이 되어있다면

-   Use: **volatile-ttl**

**결론: 할 수 만 있다면, volatile-ttl 이 Redis 사용자(client)의 의도를 해치지 않는 가장 안정적인 선택이다.**

### 3.1.5 Application 개발자(사용자)를 위한 가이드

key에 expire 를 설정하지 않으면 **volatile-lru**, **volatile-lfu**, **volatile-random**, **volatile-ttl** 의 동작은 **noeviction** 과 같다. 이는 Redis (cluster)의 상태를 안좋게 만들수 있는 위험이 있다.

따라서 모든 redis의 key에는 expire 설정을 꼭 하는 것이 필요하다.

-   반드시 계속해서 유지해야하는 Cache 데이터인 경우에는, key에는 expire를 걸고 application 수준에서 주기적으로 등록하는 방법이 귀찮지만 안전하다.

(List, HLL등의 자료구조에서 key 안의) member의 경우 expire 설정을 할 수 없다.(Enterprise 는 가능) 이때 활용할 수 있는 디자인 패턴으로는 다음과 같은 방법을 생각해볼 수 있다.

1.  Use multiple keys

-   Key를 시간대별로 구분할 수 있도록 설계한 뒤, key에 expire를 세팅한다.
-   사례: HyperLogLog

1.  Use single key

-   자료구조의 특성상 Multiple Keys로 설계하기 어려운 경우
-   Key를 member의 값(또는 score)에 timestamp를 알 수 있는 구분자를 넣어서 SCAN또는 RANGE류의 commands를 이용해서 주기적으로 또는 다음 커맨드 실행전에 지운다.
-   사례: Sorted Sets

**결론: 가장 안정적인 volatile-ttl 를 선택할 수 있도록, expire를 항상 설정하도록 설계하고, 사용하자.**

## 3.2 Redis Persistence

Redis는 데이터를 메모리 뿐만 아니라 File로도 남겨서 메모리의 데이터가 사라졌을 때 복구할 수 있는 방법을 제공한다.

아래와 같은 옵션이 있다.

### 3.2.1 **RDB** (Redis Database)

주기적으로 해당 시점의 snapshot을 남긴다.

-   최소 5분 이상의 간격으로 세팅한다.

장점

-   성능 손해를 최소화 할 수 있다.
-   backup파일이 AOF에 비해 작고 복구가 쉽고 빠르다.

단점

-   마지막으로 snapshot이 남은 시점과 그 다음 주기의 사이에 장애가 발생하면 Cache 데이터가 유실될 수 있다.
-   디스크에 남기는 child process를 만들기 위해 fork()를 수행하는데, 이 시간동안 client에 응답을 주지 못할 수 있다.
    -   데이터가 클수록, CPU 성능이 안좋을수록 영향이 크다.
    -   몇 ms~ 1초 정도 소요된다.

### 3.2.2 **AOF** (Append Only File)

모든 write operation 마다 Log를 쌓는다. 처음부터 모두 실행하면 데이터가 모두 복구된다. 해당 File은 append만으로 쓰여진다. Logging되는 데이터 자체가 redis protocol과 일치해서 AOF로부터의 복구가 쉽다. File이 너무 커질경우를 위해서 [rewrite](https://redis.io/docs/manual/persistence/#log-rewriting) 기능으로 파일이 너무 커지지 않도록 관리한다.

AOF에는 다음과 같은 [fsync](https://linux.die.net/man/2/fsync) 옵션들이 있다. 자신이 원하는 안정성(durability)에 따라서 속도와의 trade-off를 고려해서 선택한다.

-   no fsync at all
    -   fsync를 하지 않는다. 운영체제가 fsync 하는 주기마다 파일에 sync된다. 리눅스는 기본이 30초 이다.
    -   AOF중에는 가장 빠르고, 가장 안전하지 않다.
-   fsync every second: 매 초마다
-   fsync at every query: 매 쿼리마다
    -   가장 안전하고 가장 느리다.

장점

-   (거의) 모든 데이터가 백업되고 복구될 수 있으므로, 가장 안전(durability)하다.
-   AOF파일에는 문제가 거의 없다.
-   AOF파일에 쓰인 내용은 Redis protocol과 일치하므로 이해하기 쉽다.

단점

-   RDB에 비해 성능 손해가 크다.
    -   write query 응답 속도가 느리다.
    -   backup 파일이 크다.
    -   복구시간이 오래 걸린다.

### 3.2.3 **No persistence**

데이터를 파일로 남가지 않는다. 성능의 손해가 없다.

### 3.2.4 **RDB + AOF**

RDB와 AOF를 조합한 방식.

RDB의 주기 사이는 AOF로 중간과정을 남긴다.

### 3.2.5 팁

Persistence의 성능의 병목지점은 Disk이다. 때문에 Disk는 HDD보다는 SSD를 쓰는 것이 좋다. (사실 거의 무조건 SSD를 써야한다.)

성능을 위해서는 Persistence를 쓰지 않고 Replication(데이터의 복제)을 이용해서 유실되지 않는 정도로 보장하는 것이 좋다. (물론, Replication은 persistence 처럼 파일수준의 복구용으로 보장되지 않기 때문에 목적이 다르다.) 중요한 데이터의 경우 Application에서 Redis Cache에 hit되지 않으면 원본데이터(RDBMS 등)을 조회하도록 구현해놓는 것은 필수이다.

### 3.2.6 생각해볼 점

여러분이 풀고있는 문제중, 다음 3가지의 옵션 중 어떤 것을 사용하는 것이 좋을까 고민해보자.

1.  성능의 지속적인 손해가 있음에도 AOF로 Persistence를 쓰는 것
2.  Cache의 복구에 불편함과 불완전함이 있지만 RDB로 Persistence를 써서 성능의 손해를 최소화 하는 것
3.  장애로부터의 복구에 불편함이나 손해가 있더라도 Persistence를 쓰지 않고 성능의 이점을 극대화 하는 것