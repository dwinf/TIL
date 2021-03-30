listnum = [1, 10, 5, 7, 21, 4, 8, 18]
max = 0
min = 100
for i in listnum:
    if i < min:
        min = i
    elif i > max:
        max = i

print("최솟값 :", min, ", 최댓값 :", max)