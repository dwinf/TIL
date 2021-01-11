def sumAll(*p):
    sum = 0
    for i in p:
        if type(i) == int:
            sum += i
    if sum == 0:
        pass
    else:
        return sum

print(sumAll('iron', 12, 13, '**', '$'))
print(sumAll(1,2,3,4,'afk',5,6,8))
print(sumAll(1,2, 'Ab', 'C'))
print(sumAll('가나', 'a','b','c'))
print(sumAll())
