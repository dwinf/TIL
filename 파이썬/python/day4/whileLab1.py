import random
ranNum = random.randint(5, 10)
num = 0
while num <= ranNum:
    print(str(num), "->", str(num * num))
    num += 1
