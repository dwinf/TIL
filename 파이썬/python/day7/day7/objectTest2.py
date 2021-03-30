l1 = [1, 2, 3, 4, 5]
l2 = l1     # l1과 리스트를 공유

print(l1)
print(l2)

print(l1[0])
print(l2[0])

print(id(l1))   # 참조값
print(id(l2))

l2[0] = 77

print(l1)
print(l2)

print("*" * 30)

l3 = [1, 2, 3, 4, 5]
l4 = [1, 2, 3, 4, 5]    #l3와 내용만 값은 다른 리스트

print(l3)
print(l4)

print(l3[0])
print(l4[0])

print(id(l3))
print(id(l4))

l3[0] = 77

print(l3)
print(l4)
