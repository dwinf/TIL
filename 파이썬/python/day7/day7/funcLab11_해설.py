def mydict(**p):
    d = {}
    print(p)
    print(type(p))
    if p:
        for i in p:
            d['my' + i] = p[i]
    return d

print(mydict(a=1, b=2, c=3))
print(mydict())
print(mydict(교육='멀티캠퍼스',현재='파이썬'))


def mydic(**kwargs):
    mdic = {}
    for k, v in kwargs.items():
        mdic['my'+k] = v
    return mdic

print(mydic())
print(mydic(name='Lee', age=20))
print(mydic(apple=10, lemon=3, melon=1))