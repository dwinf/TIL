def calcsum(n):
    if (n < 0):
        return -1
    sum = 0
    for i in range(n+1):
        sum = sum + i
    return sum

result = calcsum(10)
if result == -1:
    print("입력값이 잘못되었습니다.")
else:
    print("~10 =", result)

result = calcsum(-5)
if result == -1:
    print("입력값이 잘못되었습니다.")
else:
    print("~10 =", result)