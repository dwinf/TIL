import random
def differtwovalue(num1, num2):
    if num2 > num1:
        a = num2
        num2 = num1
        num1 = a

    result = num1 - num2
    return result

for i in range(1, 6):
    randNum1 = random.randint(1, 30)
    randNum2 = random.randint(1, 30)
    sub = differtwovalue(randNum1, randNum2)
    print("%2d" %randNum1, '와', "%2d" %randNum2, "의 차는", "%2d" %sub, "입니다.")