def sumEven(*p):
    sum = 0
    for i in p:
        if i % 2 == 0:
            sum += i

    if len(p) == 0:
        #sum = -1
        return -1
    else:
        return sum
print(sumEven(1,2,3,4,5,6,8))
print(sumEven(1,3,5,7))
print(sumEven(10,20,100))
print(sumEven())
