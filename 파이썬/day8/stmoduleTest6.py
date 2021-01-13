# =============== mathquiz  ===============
import random

a = random.randint(1, 9)
b = random.randint(1, 9)
question = "%d + %d = ? " % (a, b)
c = int(input(question))

if c == a + b:
    print("정답입니다.")
else:
    print("틀렸습니다.")

# =============== mathquiz2  ===============
import random

correct = 0
while True:
    a = random.randint(1, 9)
    b = random.randint(1, 9)
    question = "%d + %d = ?(끝낼 때는 0) " % (a, b)
    c = int(input(question))

    if c == 0:
        break
    elif c == a + b:
        print("정답입니다.")
        correct = correct + 1
    else:
        print("틀렸습니다.")

print("%d 개 맞췄습니다." % correct)

# =============== mathquiz3  ===============
import random

correct = 0
while True:
    a = random.randint(10, 99)
    b = random.randint(10, 99)
    op = random.randint(1, 3)

    if op == 1:
        ans = a + b
        mark = "+"
    elif op == 2:
        if (a < b):
            a, b = b, a
        ans = a - b
        mark = "-"
    else:
        ans = a * b
        mark = "*"

    question = "%d %s %d = ?(끝낼 때는 0) " % (a, mark, b)
    c = int(input(question))

    if c == 0:
        break
    elif c == ans:
        print("정답입니다.")
        correct = correct + 1
    else:
        print("틀렸습니다.")

print("%d 개 맞췄습니다." % correct)

# =============== randnum  ===============
import random

secret = random.randint(1,100)
while True:
    num = int(input("숫자를 입력하세요(끝낼 때 0) : "))
    if num == 0:
        break
    if num == secret:
        print("맞췄습니다")
        break
    elif num > secret:
        print("입력한 숫자보다 더 작습니다.")
    else:
        print("입력한 숫자보다 더 큽니다")

# =============== randnum2  ===============
import random

secret = random.randint(1,100)
count = 0
while True:
    num = int(input("숫자를 입력하세요(끝낼 때 0) : "))
    if num == 0:
        break
    count += 1
    if num == secret:
        print("%d번만에 맞췄습니다" % count)
        break
    elif num > secret:
        print("입력한 숫자보다 더 작습니다.")
    else:
        print("입력한 숫자보다 더 큽니다")
