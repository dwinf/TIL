# Django 웹 프레임워크

> 웹 제작 기초

- MVC, MFV
- Django 개념
- Project와 App
- settings.py
- manage.py



## MVC & MTV

- Model : (사용자가 입력한 데이터를)안전하게 **데이터**를 저장
- View : 모델의 데이터를 웹서버가 적절한 형태로 유저에게 보여줌
- Control, Template(Django) : 사용자의 입력과 이벤트에 반응하여 Model과 View를 업데이트

![img](https://1.bp.blogspot.com/-GMvBz2taYH8/UL4v-8e51HI/AAAAAAAAAFk/RnpdpsNOhjY/s1600/mvc_role_diagram.png)

참고 : https://www.essenceandartifact.com/2012/12/the-essence-of-mvc.html



## Project와 App

- 프로젝트 생성

  $ django-admin startproject tutorial(프로젝트이름)

- app 생성

  \# ./manage.py startapp community(app이름)



## settings.py

> 프로젝트 환경설정 파일

- DEBUG
  - 디버그 모드 설정(True면 변수들의 상태를 확인 가능, 배포시에는 False)
- INSTALLED_APPS
  - pip로 설치한 앱 또는 본인이 만든 app을 추가
- MIDDELWARE_CLASSES
  - request와 response 사이의 주요 기능 레이어(인증, 보안 등)
- TEMPLATES
  - django template관련 설정, 실제 뷰(html, 변수)
- DATABASES
  - 데이터베이스 엔진의 연결 설정
- STATIC_URL
  - 정적 파일의 URL(css, javascript, image, etc.)



## manage.py

- 프로젝트 관리 명령어 모음
- 주요 명령어
  - startapp : 앱 생성
  - runserver : 서버 실행
  - createsuperuser : 관리자 생성
  - makemigrations app : app의 모델 변경사항 체크
  - migrate : 변경사항을 DB에 반영
  - shell : 쉘을 통해 데이터 확인
  - collectstatic : static 파일을 한 곳에 모음 



---



# Django 실습

- 프로젝트 & app 생성
- 디렉토리 구조 확인
- 관리자 페이지 확인
- 글쓰기
- 리스트
- 글 보기



## 프로젝트 & app 생성

프로젝트 생성 : django-admin startproject tutorial 

앱 생성 : ./manage.py startapp community

settings.py를 통해 정보 확인