import random
lotto = set()
while True:
    lotto.add(random.randint(1, 45))
    if len(lotto) == 6:
        break
print("행운의 로또번호 :", lotto)

def printChar(a, b, c):
    print(a, b, c)

li = ['a', 'b', 'c']
printChar(*li)

def printDic(a, b, c):
    print(a, b, c)
d = {'a':20, 'b':30, 'c':50}
printDic(**d)