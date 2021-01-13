def createList(*p, type=1):
    #tl = []
    if not p:
        p = [i for i in range(1, 31)]

    if type == 1:
        tl = [i for i in p]
    elif type == 2:
        tl = [i for i in p if not i % 2]
    elif type == 3:
        tl = [i for i in p if i % 2]
    else:
        tl = [i for i in p if i > 10]
    return tl


print(createList())
print(createList(type=3))
print(createList(1,3,6,22,86,11, type = 2))
print(createList(1,2,3,4,5, type = 3))
print(createList(1,2,3,4,5, type = 4))
