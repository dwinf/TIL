# scala
> 2.12.15 버전

### 변수선언
- `var name="John"`
- name="Mary"
    - 한번 선언하면 같은 타입만 재할당 가능
    - name=12
    - type mismatch 에러
- `var name: String = "John"`
    - 타입을 명시적으로 선언 가능
- `val  Name="John"`
    - 상수 선언
    - 재할당 X
- 이름 규칙
    - 변수(**var**) : `var lowerCamelCase: String = "lowerCamelCase"`
    - 상수(**val**) : `val UpperCamelCase: String = "UpperCamelCase"`

### 연산자
- 기본적으로 java와 유사
    - 산술 : +, -, *, /, %
    - 대입 : =, +=, -=, *=, /=, %=
    - 관계 : ==, !=, >, >=, <, <=
    - 논리 : &&(and), ||(or), !(not)
        - True/False 로 리턴
    - 비트 : &(and), |(or), ^(xor), ~(not), <<(왼쪽으로), >>(오른쪽으로)

```scala
// 1. () []
// 2. ! ~
// 3. * / %
// 4. + -
// 5. >> <<
// 6. < <= > >=
// 7. == !=
// 8. &
// 9. ^
// 10. |
// 11. &&
// 12. ||
// 13. 대입 연산자 (= += -= ...)

println(1.0 + 2.0 * 3.0 / 4.0) // 2.5
println((1.0 + 2.0) * 3.0 / 4.0) // 2.25

var a: Int = 1
var b: Int = 2
var c: Int = 3
a += b - c
println(a) // 0 (- 가 += 보다 먼저 선행되기에 a += (b - c) 라고 볼 수 있습니다.

var a: Int = 10
var b: Int = 20
var c: Int = 5

println(a * b)  // 200
println(b / c)  // 4

a *= b / c
println(a)  // 40

val t: Boolean = true
val f: Boolean = false
println(t || f && t)    // true
println(!f && t)    // true
println(!t || !t)   // false
println(f || f && t)    // false
```

## Pattern Matching
- 자바의 switch와 유사 기능
- Match 블락은 문장(Statement)이 아닌 식(Expression)
- 값을 반환하고 타입을 지정할 수 있음

```scala
val anything: Int = 42

anything match {
  // anything 이 0 이면 호출됩니다.
  case 0 => println("Matched 0!")

  // anything 이 0이 아닐 때 디폴트로 호출됩니다.
  case _ => println("Oops! No match!")
}
// 위의 경우에서는 마지막 println("Oops! No match!") 가 호출됩니다.
/////////////////////////////////////////////////////
def example(anything: Int): String = anything match {
  // anything 이 0 이면 호출됩니다.
  case 0 => "Matched 0!"

  // anything 이 1 이면 호출됩니다.
  case 1 => "Matched 1!"

  // anything 이 0도 1도 아닐 때 디폴트로 호출됩니다.
  case _ => "Oops! No match!"
}

val case0: String = example(0) 
println(case0) // "Matched 0!"

val case1: String = example(1)
println(case1) // "Matched 1!"

val case2: String = example(2)
println(case2) // "Oops! No match!"

val casestring0: Int = example(0) // Not allowed!
val casestring0: String = example("0") // Not allowed!
```

## 조건식
- `if`, `if-else`, `nested if-else`, `if-else if ladder` 
    - 다른 언어의 if문과 같음


## 반복문
- `for`, `foreach`
- 화살표 `<-`  를 사용해서 컬렉션 내의 요소들을 각각 처리
- k, v 형식을 이용행 Map 처리
```scala
val nums: List[Int] = List(1,2,3,4,5)

for (num <- nums) println(num)
nums.foreach(it => print(it + ","))

val numbers = Map(
	"one" -> 1,
	"two" -> 2,
	"three" -> 3
)
for ((key, value) <- numbers) println(s"Number $key : $value")
```
### 반복식
- 문장이 아닌 식으로 사용할 수 있음
- `for-expression` 은 기존 컬렉션(List/Array 같은)으로부터 새로운 컬렉션을 만들 때 유용

#### yield
`for` 을 식으로 사용하기 위해서는 `**yield**` (뜻: 생성)이란 키워드를 알아야 합니다. `for` loop 가 돌면서 각 요소를 처리한 후 값을 yield (또는 `return 이라고 해석해도 무방`합니다) 한다고 이해하시면 됩니다.