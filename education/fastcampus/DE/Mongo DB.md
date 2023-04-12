# MongoDB
## Document
- MongoDB에서 데이터를 저장하는 단위
- 형식X, 생성시점에 어떤 형식의 내용이 와도 무관
- 하나의 Document는 자신의 데이터에 대해 완결성을 가짐
- 필드나 값은 **BSON Type**
    - JSON style의 binary 포맷
    - JSON 보다 더 상세한 데이터 타입을 사용 가능
- 단, `_id` 필드(고유값)는 각 document의 Primary Key로서 반드시 가져야 한다.


## _id 필드와 ObjectId
- 모든 Document는 고유값을 뜻하는 _id 필드를 반드시 가진다
- _id를 지정하지 않으면 **ObjectId** 형식의 데이터가 자동 생성
    - 데이터 생성 시점에 할당
    - 일반적으로 권장되는 형식
- ObjectId는 다음의 12Bytes 조합으로 생성된다
    - A 4-byte timestamp: 데이터 생성 시점의 unix epoch timestamp 값
    - A 5-byte random value: 프로세스당 unique함을 보장하는 random 값
    - A 3-byte incrementing counter: 1씩 증가해서 할당되는 counter. random value에 의해 초기화
- `ObjectId.getTimestamp()`를 통해서 별도의 필드 없이 **생성 시점**을 가져올 수 있다.
- ObjectID 의 맨 앞이 timestamp로 되어있음
    - ObjectId로 정렬하면 (대략적인) 시간순 정렬이 된다.

## Collection
Document 를 저장하기 위한 논리적인 묶음(table과 유사)
RDBMS처럼 이름, 데이터 타입 등에 제약을 걸 수 있다. == Schema Validation
사용상의 편의를 위해 최소한이라도 사용하는 것을 추천

## Database
논리적으로 Database 구분
주로 사용하는 서비스, 유저 등 구분하기 위해 사용

## Schema
