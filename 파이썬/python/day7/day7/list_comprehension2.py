oldlist = [17, 2, 14, 6, 10, 19, 16, 12, 5]
newlist1 = [oldlist]
print(newlist1)

newlist2 = list([1, 2, 3, 4, 5, 6, 7, 8])
print(newlist2)

newlist3 = list((1, 2, 3, 4, 5, 6, 7, 8))
print(newlist3)

newlist4 = list({1, 2, 3, 4, 5, 6, 7, 8})
print(newlist4)

newlist5 = list("ABC")
print(newlist5)

'''newlist11 =["ABC"]
print(newlist11)'''

newlist6 = [x for x in range(1, 9)]
print(newlist6)

newlist7 = [x for x in oldlist if x % 2]    # 참이 되는 요소만 가져옴
print(newlist7)

newlist8 = [x for x in oldlist if x > 10]
print(newlist8)

newlist9 = [x * 10 for x in oldlist if x < 10]
print(newlist9)

flowernames = ['rose', 'sunflower', 'tulip', 'magnolia', 'goldenbell', 'lily']
newlist10 = [i for i in flowernames if len(i) == 4]
print(newlist10)
