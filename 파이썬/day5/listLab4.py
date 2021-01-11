import random
listnum = []
for i in range(1, 11):
    #num = random.randint(1, 50)
    listnum.append(random.randint(1, 50))

print(listnum)

for i in range(0, len(listnum)):
    if listnum[i] < 10:
        listnum[i] = 100
print(listnum)

print(listnum[0])
print(listnum[-1])
print(listnum[1:7])
print(listnum[::-1])    #역순으로 출력
print(listnum[:])
del listnum[4]
print(listnum[:])
del listnum[1:3]
print(listnum[:])
