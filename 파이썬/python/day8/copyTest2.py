# =============== deepcopy  ===============
list0 = [ 'a', 'b' ]
list1 = [ list0, 1, 2 ]
list2 = list1.copy()
print(list1[0] is list2[0])
list2[0][1] = 'c'
print(list1)
print(list2)

# =============== deepcopy2  ===============
import copy

list0 = [ "a", "b" ]
list1 = [ list0, 1, 2 ]
list2 = copy.deepcopy(list1)

list2[0][1] = "c"
print(list1)
print(list2)