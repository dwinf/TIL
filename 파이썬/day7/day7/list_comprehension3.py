r1 = ["Black", "White"]
r2 = ["Red", "Blue", "Green"]
r3 = []
for t in r1 :
    for p in r2 :
        r3.append(t+p)
print(r3)

r3 = [ t + p for t in r1 for p in r2 ]
print(r3)
print("*"*80)
gugulist1 = [ dan * num for dan in range(1, 10) for num in range(1, 10)]
print(gugulist1)

gugulist2 = [ dan * num for dan in range(1, 10) for num in range(1, 10) if dan * num < 30]
print(gugulist2)    # break는 가장 가까운 반복문(뒤)만 탈출