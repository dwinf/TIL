sum = 0
for d in range(1, 51):
    if d % 3 == 0:
        if d % 5 == 0:
            continue
        sum += d
print("결과 =", sum)