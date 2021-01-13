def fct_fac(n):
    def exp(x):
        return x ** n
    return exp


rtnf1 = fct_fac(2)  # 수행하고 나서도 지역변수 n이 사라지지 않고 저장
rtnf2 = fct_fac(3)  # 클로저 함수

print(type(rtnf1))
print(type(rtnf2))

print(rtnf1(4))
print(rtnf2(4))
