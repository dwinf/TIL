import random
list1 = []
for i in range(10):
    list1.append(random.randint(0, 100))

#list2 = [random.randint(1, 100) for i in range(1, 11)]  # i 대신 _ 사용 가능

ranDict = {i: 'pass' if list1[i-1] >= 60 else 'nopass' for i in range(1, 11)}
print(ranDict)