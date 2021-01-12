a = {i for i in range(1, 101) if i % 3 == 0}
b = {i for i in range(1, 101) if i % 5 == 0}

print(a & b)

listv = [dan * num for dan in range(1, 10) for num in range(1, 10)]
setv =  { dan * num for dan in range(1, 10) for num in range(1, 10)}

print(listv)
print(setv)