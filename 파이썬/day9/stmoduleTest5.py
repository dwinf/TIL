# =============== random  ===============
import random

for i in range(5):
    print(random.random())
print("-" * 20)
import math
for i in range(5):
    rnum = random.random()
    rnumtoint = math.floor(rnum * 10)
    print(f"{rnum} : {rnumtoint}")


# =============== randint  ===============
import random

for i in range(5):
    print(random.randint(1,10))

# =============== uniform  ===============
import random

for i in range(5):
    print(random.uniform(1,100))

# =============== choice  ===============
import random

food = ["짜장면", "짬뽕", "탕수육", "군만두"]
print(random.choice(food))

# =============== shuffle  ===============
import random

food = ["짜장면", "짬뽕", "탕수육", "군만두"]
print(food)
random.shuffle(food)
print(food)

# =============== sample  ===============
import random

food = ["짜장면", "짬뽕", "탕수육", "군만두"]
print(random.sample(food, 2))

# =============== lotto  ===============
import random

nums = random.sample(range(1, 46), 6)
nums.sort()
print(nums)