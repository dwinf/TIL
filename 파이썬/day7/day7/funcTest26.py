def updatelist(times, listnums) :
    for i in range(len(listnums)) :
        listnums[i] *= times


l1 = [1,2,3,4,5]
print(l1)
updatelist(2, l1)
print(l1)
print("-"*10)
l2 =  [10, 20, 30, 40];
print(l2)
updatelist(3, l2)
print(l2)

