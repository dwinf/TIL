# 괄호가 없는 튜플
tuple_test = 10, 20, 30, 40     #자동으로 튜플로 패킹
print("# 괄호가 없는 튜플의 값과 자료형 출력")
print("tuple_test:", tuple_test)
print("type(tuple_test):", type(tuple_test))
print()

# 괄호가 없는 튜플 활용
a, b, c = 10, 20, 30    #패킹 후 언패킹
print("# 괄호가 없는 튜플을 활용한 할당")
print("a:", a)
print("b:", b)
print("c:", c)

a, b, c = "ABC" #문자열도 가능
print("# 괄호가 없는 튜플을 활용한 할당")
print("a:", a)
print("b:", b)
print("c:", c)