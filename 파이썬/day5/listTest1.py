# 리스트
# 리스트 자료형(순서, 중복, 수정, 삭제)
a = []  #비어있는 리스트
b = list()
c = [1, 2, 3, 4]
d = [10, 10, 'Pen', 'Cap', 'Plate']
e = list('유니코')
f = [10]

print("리스트데이터의 타입")
print(type(d), d, sep="--->")

print(a)
print(b)
print(c)
print(d)
print(e)
print(f)

print("리스트데이터의 길이")
print(len(a))
print(len(d))

print("리스트데이터의 인덱싱")
print('d - ', d[1])
print('d - ', d[0] + d[1] + d[1])
print('d - ', d[-1])

print("리스트데이터의 슬라이싱")
print('d - ', d[0:3])
print('d - ', d[2:])

print(d)
d[1] = 20
print(d)

for e in d:
    print(e)