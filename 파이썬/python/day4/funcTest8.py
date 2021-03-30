def add(num1, num2) :
    print(num1 + num2)

r1 = add(10, 20)
v1 = 100; v2 = 200
r2 = add(v1, v2)
print(r1)
print(r2)
print(add(1000, 2000))
#print(1+add(1000, 2000)) #에러
print(1 + bool(add(1000, 2000))) #bool에서 none은 false이고 덧셈연산에서 0으로 처리
