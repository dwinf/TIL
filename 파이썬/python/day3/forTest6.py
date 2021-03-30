import random
dan = random.randint(1,9)
print(dan, "단")
for num in range(2, 10):
    print(dan, "*", num, "=", dan * num, end="\t")
