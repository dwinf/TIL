import random
oper_num = random.randint(1, 10)
print(oper_num)
if oper_num == 1 or oper_num == 6:
    oper_num = 300 + 50
if oper_num == 2 or oper_num == 7:
    oper_num = 300 - 50
if oper_num == 3 or oper_num == 8:
    oper_num = 300 * 50
if oper_num == 4 or oper_num == 9:
    oper_num = 300 / 50
if oper_num == 5 or oper_num == 10:
    oper_num = 300 % 50
print(oper_num)