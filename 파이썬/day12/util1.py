INCH = 2.54

def calcsum(n):
    sum = 0
    for num in range(n + 1):
        sum += num
    return sum

print("인치 =", INCH)
print("합계 =", calcsum(10))