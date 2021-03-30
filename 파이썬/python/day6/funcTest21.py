def calcstep(**args):
    begin = args['begin']
    end = args['end']
    step = args['step']

    sum = 0
    for num in range(begin, end + 1, step):
        sum += num
    return sum


print("3 ~ 5 =", calcstep(begin=3, end=5, step=1))
print("3 ~ 5 =", calcstep(step=1, end=5, begin=3))
#print("3 ~ 5 =", calcstep(3, 5, 1))