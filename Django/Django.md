# Django

> 2월 1일 ~

## DateBase

### 데이터의 분류

#### 1. 정형 데이터

- 구조화된 데이터
- 엑셀 스프레드시트, 관계 DB의 테이블, CSV



#### 2. 반정형 데이터

- 기본적인 구조가 정해짐
- **HTML, XML, JSON** 등



#### 3. 비정형 데이터

- 정해진 구조가 없음
- 댓글 텍스트, 영상, 이미지, 워드나 PDF(저장시 바이너리 형식)



### 데이터와 정보

- 데이터 : 컴퓨터 사용 시 불규칙하게 만들어지는 다양하고 많은 값들

- 정보 : 체계적이고 조직적으로 관리하고 사용되는 데이터, 여러가지 값들로 표현되는 데이터를 의미있고 가지있는 형태로 가공해 놓은 것

### DB와 DBMS

- DB : 특정 조직의 사용자들이 공유해 사용할 수 있도록 통합하고 저장한 **운영 데이터의 집합체**

- DBMS : 데이터베이스를 생성하여 안정적이고 효율적으로 운영하는 데 필요한 기능들을 제공하는 소프트웨어



### 데이터베이스의 특징

1. 데이터의 중복성을 최소화
2. 데이터의 일관성을 유지
3. 데이터의 무결성을 유지
   - 무결성 :  데이터베이스에 정확한 데이터가 유지되고 있음을 보장하는 것으로 데이터베이스에서 가장 중요한 개념 제약조건에 맞지 않는 데이터는 아예 입력되지 않도록 방지하는 기능을 제공해 데이터베이스의 무결성을 유지함





### 데이터 모델



### ER 모델링

엔티티 : 데이터베이스의 객체들을 엔티티라고 부름



### 관계형 DB

- 개체를 테이블로 사용하고 개체들 간의 공통 속성을 이용해 서로 연결
- 자료의 구조가 단순한 업무에 적합

![image-20210201101726492](https://user-images.githubusercontent.com/73389275/110780439-08e0d100-82a8-11eb-9306-60876110fe50.png)

- 테이블 : 릴레이션 혹은 엔티티, 열(Column)과 행(Row)으로 구성됨 
- 필드 : 속성 혹은 컬럼, 열에 해당, 데이터 값을 기억하는 기억 단위 
- 레코드 : 투플, 테이블의 행에 해당, 카디널리티 
- 후보 키 : 한 테이블 내에서 데이터 레코드를 고유하게 식별할 수 있는 필드 
- **기본 키** : 후보 키 중에서 대표로 선정된 키 (= **primary key**)
- 외래 키 또는 **참조 키** : 관계가 설정된 다른 테이블의 기본 키를 참조하는 키

![image-20210201102032080](https://user-images.githubusercontent.com/73389275/110780469-11d1a280-82a8-11eb-9355-f4ddf87431a4.png)



### 데이터 제약 조건(무결성)

#### 개체 무결성

- 기본키는 공백(Null)값이나 중복된 값을 가질 수 없음

#### 참조 무결성

- 외래키를 통해 릴레이션은 참조할 수 없는 외래키 값을 가질 수 없도록 함
- 참조된 부서를 삭제할 때는 해당 부서를 참조하는 사원이 없어야함



### 정규화

- 삽입이상
- 삭제이상
- 수정이상



### 관계 유형

- 일대일(1:1)
- 일대다(1:n)
- 다대다(n:n)



---



## Django 모델(Model)

장고에서는 모델 클래스를 통해 DB연동

models.py에 하나 이상의 모델 클래스를 정의하며 하나의 모델 클래스는 하나의 테이블

따라서 sql문을 몰라도 DB설계 가능



CRUD(Create, Read, Update, Delete)

-> SQL(INSERT, SELECT, UPDATE, DELETE)

-> Django API(python)



#### Django를 가지고 DB를 연동(CRUD)하는 구현 과정

1. 모델 클래스를 생성한다. - models.py

   1. Model 클래스를 상속
   2. 만들려는 DB테이블의 컬럼 사양에 맞춰 클래스 변수를 정의

2. Django에서 제공하는 명령을 수행시켜 모델 클래스에 알맞는 DB테이블 생성

3. 모델 클래스를 통해서 CRUD를 구현

   - C : 모델 클래스의 객체를 생성한 후 save() 메서드 호출

   - R : 모델클래스.objects.all()

     ​	 모델클래스.objects.filter()

     ​	 모델클래스.objects.order_by()

     ​	 모델클래스.objects.first()

     ​	 모델클래스.objects.last()

     ​	 모델클래스.objects.count()

   - U, D : API를 통해 구현



---

---

2월 2일

heidisql 설치

##### thirdapp의 models.py

```python
name = models.CharField(max_length=10)  # max_length 필수
age = models.IntegerField(null=True)  # 생략 가능하도록 설정
```

- CharField -> VARCHAR(가변길이) 타입으로 생성, CHAR(고정길이)

- null=True : 값을 입력하지 않아도 된다.
- id는 따로 주지 않았지만 자동으로 추가된다.
  - 입력되는 데이터 순으로 1, 2, 3

```
DBTest.objects.all()	//모든 데이터를 QuerytSet 객체로 가져온다
DBTest.objects.count()	//데이터의 개수 리턴
DBTest.objects.first()	//첫번째 데이터 리턴
DBTest.objects.last()	//마지막 데이터 리턴
DBTest.objects.order_by('age')	//데이터를 나이순으로 정렬
DBTest.objects.filter('둘리')	//둘리라는 요소를 가진 데이터 리턴
DBTest.objects.get(id=1)	//id가 1인 데이터 리턴
```

studyproject/forthapp



---

---

2월 3일

accountapp/view.py

```python
def index(request) :
    context = None
    print(request.user.is_authenticated)
    print(request.user)
    if request.user.is_authenticated:
        context = {'logineduser': request.user}
    return render(request, 'index.html', context)
```

- request.user.is_authenticated : 로그인 여부를 확인(했으면 True)
- 로그인된 유저라면 회원정보 리턴



```python
def register(request):
    res_data = None
    if request.method =='POST':
        useremail = request.POST.get('useremail')
        firstname = request.POST.get('firstname', None)
        lastname = request.POST.get('lastname', None)
        password = request.POST.get('password', None)
        re_password = request.POST.get('re-password',None)
        res_data = {}
        if User.objects.filter(username=useremail):
            res_data['error']='이미 가입된 아이디(이메일주소)입니다.'
        elif password != re_password:
            res_data['error']='비밀번호가 다릅니다.'
        else:
            user = User.objects.create_user(username = useremail,
                            first_name = firstname,
                            last_name = lastname,
                            password = password)
            auth.login(request, user)
            redirect("index.html")
    return render(request, 'register.html', res_data)
```

- User.objects.filter : 유저 검색을 통해 일치하는 값을 찾음
- User.objects.create_user : 새로운 유저 생성
- auth.login(request, user) : 로그인 실행
- redirect("index.html") : 첫 화면으로 이동



```python
def login(request):
    if request.method == "POST":
        useremail = request.POST.get('useremail', None)
        password = request.POST.get('password', None)
        user = auth.authenticate(username=useremail, password=password)
        if user is not None :
            auth.login(request, user)
            return redirect("index")
        else :
            return render(request, 'login.html', {'error': '사용자 아이디 또는 패스워드가 틀립니다.'})
    else :
        return render(request, 'login.html')
```

- auth.authenticate : 조건에 해당하는 유저정보 리턴



```python
def logout(request):
    if request.user.is_authenticated:
        auth.logout(request)
    return redirect("index")
```

- auth.logout(request) : 로그아웃



```python
def only_member(request) :
    context = None
    if request.user.is_authenticated:
        context = {'logineduser': request.user.last_name+request.user.first_name}
    return render(request, 'member.html', context)
```

- 유저정보가 있다면 이동시켜줌

