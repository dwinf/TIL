# =============== is  ===============
list1 = [1, 2, 3]
list2 = list1
list3 = list1.copy()

print("1 == 2", list1 is list2)
print("1 == 3", list1 is list3)
print("2 == 3", list2 is list3)

# =============== varis  ===============
a = 1
b = a
print("a =", a, " b =", b, ":", a is b)
b = 2
print("a =", a, " b =", b, ":", a is b)

a = [1,2,3,4,5]
b = a
print(id(a), id(b))
print(a, b)

b = [6,7,8,9,10]
print(id(a), id(b))
print(a, b)

