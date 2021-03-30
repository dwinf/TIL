def getlist1(times, *nums) :
    newnums = []
    for data in nums :
        newnums.append(data * times)
    return newnums

print(getlist1(2, 1,2,3,4,5))
print(getlist1(3, 1,2,3,4,5,6,7))


def getlist2(times, *nums) :
    newnums = list()
    for data in nums :
        newnums.append(data * times)
    return newnums

print(getlist2(2, 1,2,3,4,5))
print(getlist2(3, 1,2,3,4,5,6,7))

