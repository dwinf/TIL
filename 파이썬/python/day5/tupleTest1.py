# 튜플
# 자료형(순서, 중복)
a = ()
b = tuple()
c = (1, 2, 3, 4)
d = (10, 10, 'Pen', 'Cap', 'Plate')
e = tuple('유니코')
f = (10,)   #요소가 하나일 경우 ',' 삽입

print("튜플데이터의 타입")
print(type(d), d, sep="--->")

print(a)
print(b)
print(c)
print(d)
print(e)
print(f)

print("튜플데이터의 길이")
print(len(a))
print(len(d))

print("튜플데이터의 인덱싱")
print('d - ', d[1])
print('d - ', d[0] + d[1] + d[1])
print('d - ', d[-1])

# 슬라이싱
print('d - ', d[0:3])
print('d - ', d[2:])

print(d)
d[1] = 20
