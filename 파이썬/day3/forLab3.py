import random
sum = 0
a = random.randint(1,40)
b = random.randint(30,40)
"""if a > b:
    c = b
    b = a
    a = c """
for d in range(a, b+1):
    if d % 2 == 0:
        sum += d
print(a, "부터", b, "까지의 짝수의 합 :",sum)