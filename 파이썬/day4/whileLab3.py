import random
count = 0
while True:
    randNum = random.randint(0, 30)
    if 1 <= randNum <= 26:
        print(chr(randNum + 64), "(%d)" %randNum)
        count += 1
    else:
        print("수행횟수는 %d번입니다."%count)
        break

