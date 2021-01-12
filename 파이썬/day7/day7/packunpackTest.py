data = [1, 2, 3, 4]

print(data)
print(*data)    # 모든 요소를 각각의 아규먼트로 전달
print(data[0], data[1], data[2], data[3])

print("*" * 30)
a, b, c, d = [10, 20, 30, 40]
print(a)
print(b)
print(c)
print(d)

print("*" * 30)
x, *y, z = [10, 20, 30, 40]
print(x)
print(y)
print(z)

print("*" * 30)
p = 100, 200, 300
print(p)
