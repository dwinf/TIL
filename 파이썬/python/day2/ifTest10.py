import random
num = random.randint(1, 20)

print("num(", num, ") : ", sep="", end="")
if num < 10 :
    print("10보다 작은 수-", end="")
    if num < 5 :
        print("5보다 작은 수-", end="")
    else :
        print("5보다 큰 수-", end="")
else :
    print("10보다 큰 수-", end="")
print("OK?")

