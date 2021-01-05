import random
num = random.randint(1, 20)
if num % 2 == 0 :
    print(num, "은 짝수", sep="")
else :
    print(num, "은 홀수", sep="")
print("-"*50)

if num % 2 == 0 :
    print(num)
    print("은 짝수")
else :
    print(num)
    print("은 홀수")
print("-"*50)

if num % 2 == 0 :
    print(num, end="")
    print("은 짝수")
else :
    print(num, end="")
    print("은 홀수")
print("-"*50)