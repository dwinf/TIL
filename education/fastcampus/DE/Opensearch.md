## Opensearch 개요

Opensearch는 검색, 로깅 및 분석을 위한 오픈소스 검색 엔진입니다. Elasticsearch에서 포크된 프로젝트로, Elasticsearch의 코드베이스를 기반으로 구축되었으며 Apache 2.0 라이선스 하에 배포됩니다. Opensearch는 Elasticsearch와 동일한 API와 호환되는 플러그인 아키텍처를 사용하여 Elasticsearch에서 사용되는 많은 툴과 애플리케이션을 사용할 수 있습니다.

Opensearch는 검색, 분석, 로깅 및 보안과 같은 다양한 기능을 제공합니다. 이를 위해 Opensearch는 다양한 플러그인을 제공하며 이를 사용하여 기능을 확장할 수 있습니다. Opensearch는 클러스터링 기능도 제공하며, 수백 대의 서버를 지원할 수 있습니다.

## Opensearch 사용 방법

### 1. Opensearch 설치 및 설정

Opensearch를 설치하려면 다음 단계를 수행합니다.

1.  Opensearch를 다운로드하고 압축을 해제합니다.
    
2.  `opensearch.yml` 파일을 열어서 클러스터의 이름, 노드의 이름, 네트워크 설정 등 필요한 설정을 구성합니다.
    
3.  Opensearch를 시작합니다.
    

bashCopy code

`bin/opensearch`

### 2. 데이터 색인

Opensearch는 데이터를 색인하여 검색할 수 있습니다. 데이터를 색인하려면 다음 단계를 수행합니다.

1.  인덱스를 만듭니다.

perlCopy code

`PUT /<index-name>`

2.  매핑을 정의합니다.

bashCopy code

`PUT /<index-name>/_mapping {   "properties": {     "title": {       "type": "text"     },     "body": {       "type": "text"     },     "timestamp": {       "type": "date"     }   } }`

3.  데이터를 색인합니다.

javascriptCopy code

`PUT /<index-name>/_doc/<document-id> {   "title": "Example",   "body": "This is an example document.",   "timestamp": "2023-04-07T10:15:00" }`

### 3. 데이터 검색

Opensearch를 사용하여 데이터를 검색하려면 다음 단계를 수행합니다.

1.  검색 쿼리를 작성합니다.

phpCopy code

`GET /<index-name>/_search?q=<query>`

2.  필드를 지정하여 검색합니다.

perlCopy code

`GET /<index-name>/`



역인덱스
text 타입 필드는 분석기를 사용해 인덱싱
인덱싱이란 데이터를 구조화하는 방법 -> 검색효율 향상


역인덱스와 전문검색
역인덱스의 목적은 텍스트를 효율적이고 빠른 전문 검색이 가능한(+빠르게) 구조로 만들어 자장하는 것
전문 검색이란 특정 단어가 포함된 문서를 찾아내는 검색방식
RDBMS에서도 LIKE, 정규표현식 등으로도 검색이 가능하겠지만 테이블 풀 스캔을 하기 때문에 느림
-> 인덱스를 이용해서 검색 속도를 높일 수 있도록 고안된 것이 역인덱스 데이터 구조

역인덱스는 도큐먼트의 필드 수준에서 작동
text 타입 필드 하나 당 1개씩 생성

![사진](https://yoonsung.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F5272dc8c-c31b-4574-85e5-b74a41a90155%2FUntitled.png?id=51311c77-a6e8-46f1-a245-0dc478a14d8b&table=block&spaceId=5d897442-979a-4711-9adc-3bdaa80aace1&width=1760&userId=&cache=v2)


정리하면 OpenSearch의 `text` 타입 필드는 분석기가 적용되고, 분석 결과는 역인덱스에 저장
검색 쿼리를 수행하면, 실제로 도큐먼트 자체를 검색하는 것이 아니라 역인덱스에 대해 검색을 수행


OpenSearch는 2가지 유형의 쿼리를 지원
- 용어 수준 쿼리(Term-level query)
	- 검색어와 정확히 일치하는 용어를 찾기 위해 사용
	- `keyword` 타입이 아닌 경우에도 용어 수준 쿼리를 수행 가능
	- "Hello, World!"를 쿼리할 경우
		- 대소문자와 특수문자까지 정확하게 일치하는 검색어로 쿼리
- 전문 쿼리(Full-text query)
	- 전문 검색을 위해 사용
	- 검색어와 도큐먼트의 일치하는 정도에 따라 관련성 점수를 계산 후 내림차순 정렬
	- `text` 타입으로 매핑된 필드에만 수행 가능
	- "Hello, World!"를 쿼리할 경우
		- "hello world"로 검색해도 찾을 수 있음

---

