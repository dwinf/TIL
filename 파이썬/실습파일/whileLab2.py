import random
while True:
    pairNum1 = random.randint(1, 6)
    pairNum2 = random.randint(1, 6)
    if pairNum1 < pairNum2:
        print("pariNum1이 pairNum2 보다 작다")
    elif pairNum1 > pairNum2:
        print("pariNum1이 pairNum2 보다 크다")
    else:
        print("게임 끝")
        break
