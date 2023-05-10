# Shell Script
> unix shell의 커맨드라인 인터프리터가 실행할 수 있는 명령어

파일 헤더에
```bash
#!/bin/sh    bourne shell을 사용하는 shell script
#!/bin/bash   bash shell script
#!/bin/zsh    zshell shell script
```
- **`#!`** 은 shebang 이라고 읽음
- 쉘 스크립트의 실행은 `./$FILENAME` 으로 실행
	- 또는 `sh $LOCATION/$FILENAME`
	- 실행하기 위해서는 실행(x) 권한이 필요

## 변수
### 변수
- **영문**, **숫자**, **\_** 만 허용
- **변수 명은 대문자**로 쓰는게 국룰
- `$변수명` 으로 변수 사용
	- NAME=kdc
- `readonly 변수명` : 읽기 전용 변수 == 상수 로 선언
	- 변경을 시도할 경우 에러
	- readonly NAME
	- readonly NAME2=daechan
- `unset 변수명` : 할당 해제
- **환경변수**도 스크립트 내에서 불러올 수 있음
	- $JAVA_HOME, $PYTHON_HOME 등

### 특수목적 변수
> 할당하지 않아도 사용 가능 

- \$$ : 현재 쉘의 pid
- $0 : 쉘 스크립트 이름  
- $1~$9 : 명령줄 인수
- $# : 인수의 개수    
- $* : 모든 명령줄 인수 리스트  
- $@ : 각 인자를 \"\" 로 감싸서 리턴
- $? : 최근 실행한 명령어의 종료 값  
	- 0 성공, 1~125 에러, 126 파일이 실행가능하지 않음, 128~255 시그널 발생
- $! : 최근 실행한 백그라운드 명령어의 pid

## 조건문
### if
```bash
if [ condition ]; then
	${if script}
elif [ condition ]; then
	${elif script}
else
	${else script}
fi
```
- `if` 로 시작해 `fi` 로 마무리
- 조건절 뒤에는 `; then` 을 붙혀 다음 문장을 수행

### case
```bash
case expression in  
    pattern_1)  
        statements  
        ;;  
    pattern_2)  
        statements  
        ;;  
    pattern_3|pattern_4|pattern_5)  
        statements  
        ;;  
    *)  
        statements  
        ;;
esac  
```
- `case` 로 시작 `esac` 로 마무리
- pattern은 글자 또는 정규표현식
- `*)` 는 **default**를 의미

## 반복문
### while


### for



### 연산자
> `sh` 에는 arithmetic operations 가 없기 때문에 **`awk`** 나 **`expr`** 등을 사용
```bash
expr $a + $b    # 더하기
expr $a - $b    # 빼기
expr $a \* $b   # 곱하기 *는 다른 뜻도 있으니 이스케이프 처리
expr $a / $b    # 나누기
expr $a % $b    # 나머지

a=$b    # b 값을 a에 할당
[ $a=$b ]
[ $a!=$b ]
```

