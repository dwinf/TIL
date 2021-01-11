import random
lotto = list()
while True:
    ranNum = random.randint(1, 45)
    if ranNum not in lotto:
        lotto.append(ranNum)
    if len(lotto) == 6:
        break

print("행운의 로또번호 :")
for i in lotto:
    print(i, end=' ')
