maria = {'korean': 94, 'english': 91, 'mathematics': 89, 'science': 83}
print(maria)
average = sum(maria.values()) / len(maria)
print(average)


list1 = [ ['boy', '소년'], ['school', '학교'], ['book', '책'] ]
dic = dict(list1)
print(dic)

list2 = [ ('boy', '소년'), ('school', '학교'), ('book', '책') ]
dic = dict(list2)
print(dic)

list3 = dict(boy= '소년', school='학교', book='책')
dic = dict(list3)
print(dic)


x = {'a': 10, 'b': 20, 'c': 30, 'd': 40}
print(x)

item = x.items()
# for key, value in item:
#     if value == 20:
#         del x[key]

for key, value in list(item):
    if value == 20:
        del x[key]

print(x)