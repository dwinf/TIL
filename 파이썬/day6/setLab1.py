import random
a =set()
b = set()
for i in range(1, 11):
    a.add(random.randint(1,20))
for i in range(1, 11):
    b.add(random.randint(1,20))
print("집합 1 :", a)
print("집합 2 :", b)
print("두 집합에 모두 있는 데이터 :", a & b)
print("집합1 또는 집합2에 있는 데이터 :", a | b)
print("집합1에는 있고 집합2에는 없는 데이터", a - b)
print("집합2에는 있고 집합1에는 없는 데이터", b - a)
print("집합1과 집합2가 각자 가지고 있는 데이터 :", a ^ b)
