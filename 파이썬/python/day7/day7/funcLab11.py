def mydict(**dic):
    dic1 = {}
    if len(dic) == 0:   #if p: 로 해도 된다. p가 비어있으면 False 리턴
        return dic1
    for key, value in dic.items():
        dic1['my' + key] = value
    return dic1


print(mydict())
print(mydict(b=2, c=3, d=4, e=5, f=6))
print(mydict(교육='멀캠', 현재='파이썬'))


def mydic2(**kwargs):
    mdic = {}
    for k, v in kwargs.items():
        mdic['my' + k] = v
    return mdic


print(mydic2())
print(mydic2(name='Lee', age=20))


def mydic3(**p):
    d = {}
    if len(p) != 0:
        for i in p:
            d['my' + i] = p[i]
    return d


print(mydict())
print(mydict(b=2, c=3, d=4, e=5, f=6))
