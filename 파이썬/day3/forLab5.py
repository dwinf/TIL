sum = 0
for d in range(1, 51):
    if d % 3 == 0 and d % 5 != 0:
        sum += d
print("결과 =", sum)