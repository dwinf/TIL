a = [[10, 20, 30, 40, 50],
     [5, 10, 15],
     [11, 22, 33, 44],
     [9, 8, 7, 6, 5, 4, 3, 2, 13]]
for i in range(len(a)):
    sum = 0
    for j in range(len(a[i])):
            sum += a[i][j]
    print(i + 1, "행의 합은", sum, "입니다")