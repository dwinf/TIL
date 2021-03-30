a = [[10, 12, 14, 16],
     [18, 20, 22, 24],
     [26, 28, 30, 32],
     [34, 36, 38, 40]]

print("1행 1열의 데이터 :", a[0][0])
print("3행 4열의 데이터 : ", a[2][3])
print("행의 갯수 :", len(a))
print("열의 갯수 :", len(a[0]))
#print("3행의 데이터들 :", a[2])
print("3행의 데이터들 :", a[2][0], a[2][1], a[2][2], a[2][3])
"""b = []
for i in a:
    b.append(i[1])
print("2열의 데이터들 :", b)"""
print("2열의 데이터들 :", a[0][1], a[1][1], a[2][1], a[3][1])

"""c = list()
for i in range(0, 4):
        c.append(a[i][i])
print("왼쪽 대각선 데이터들 :", c)"""

print("왼쪽 대각선 데이터들 :", end='')
for i in range(len(a)):
    print(a[i][i], end=' ')
print()

"""d = list()
j = len(a) - 1
for i in range(0, 4):
    d.append(a[i][j])
    j -= 1
print("오른쪽 대각선 데이터들 :", d)"""

print("오른쪽 대각선 데이터들 :", end=' ')
j = len(a[0])
for i in range(len(a)):
    print(a[i][j-1], end=' ')
    j -= 1
