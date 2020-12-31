# Chapter 1 자바 시작

- 소스: 프로그래밍 언어로 작성된 텍스트 파일
- `컴파일`: 소스 파일을 컴퓨터가 이해할 수 있는 기계어로 만드는 과정
  - 자바: .java -> .class
  - C: .c -> .obj -> .exe
  - C++: .cpp -> .obj -> .exe



- 자바는 클래스 이름과 소스파일의 이름이 일치해야 한다.

```java
// Hello.java 파일

public class Hello{
    public static void main(String[] args){
        System.out.print("Hello");
    }
}
```





## 1.7 자바의 특징

**플랫폼 독립성**

- 자바는 하드웨어, 운영체제 등 플랫폼에 종속되지 않는 독립적인 바이트 코드로 컴파일
- 자바 가상 기계(JVM)만 있으면 자바 프로그램 실행 가능

**객체 지향**

- 캡슐화, 상속, 다형성을 지원
- 객체 간의 상호 관계로 모델링

