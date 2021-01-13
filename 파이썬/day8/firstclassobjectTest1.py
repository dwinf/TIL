def func1(n):
    return n * 2

def func2():
    print("func2 호출 - hello")

print(type(func1))
print(type(func2))
print(func1(10))
print(func2())

print("=" * 20)
print(func2)
v = func2   # func2를 v도 쓸 수 있게 됨
print(v)
v()     # func2 호출 - hello, v() == func2()

def say1():
    print("안녕?")

def say2():
    print("Hello?")

print("=" * 20)

import types
def callback(fn):
    if type(fn) == types.FunctionType:  # fn이 함수라면
        fn()
    else :
        print("아규먼트로 함수를 주세요")

callback(say1)
callback(say2)
callback(100)



