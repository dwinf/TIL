alist = list(range(1,11))
print(alist)
a,b,c = alist[0:3]
print(f"a={a}, b={b},c={c}")
#a,b,c = alist
a,*b,c = alist
print(f"a={a}, b={b},c={c}")

print("-*"*20)
numList = [0, 1, 2]
engList = ['zero', 'one', 'two']
espList = ['cero', 'uno', 'dos']
print(list(zip(numList, engList, espList)))
for num, eng, esp in zip(numList, engList, espList):
    print(f'{num} is {eng} in English and {esp} in Spanish.')

print("-*"*20)
upperCase = ['A', 'B', 'C', 'D', 'E', 'F']
lowerCase = ['a', 'b', 'c', 'd', 'e', 'f']
for i, (upper, lower) in enumerate(zip(upperCase, lowerCase), 1):
    print(f'{i}: {upper} and {lower}.')


