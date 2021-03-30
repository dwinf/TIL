print("-- 슬라이싱 --")
nums = [0,1,2,3,4,5,6,7,8,9]
print(nums[2:5])
print(nums[:4])
print(nums[6:])
print(nums[1:7:2])
print("-- 인덱스를 사용한 대입 --")
score = [ 88, 95, 70, 100, 99 ]
print(score[2])
score[2] = 55
print(score)
score[2] = [55, 66]
print(score)
print("-- 슬라이싱을 사용한 대입 --")
nums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
print(nums)
nums[0:0] = [100]
print(nums)
nums[2:5] = [20, 30, 40]
print(nums)
nums[6:8] = [90, 91, 92, 93, 94]
print(nums)
print("-- 슬라이싱을 사용한 제거 --")
nums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
print(nums)
nums[2:5] = []
print(nums)
del nums[4]
print(nums)
print("-- 리스트 연산 --")
list1 = [1, 2, 3, 4, 5]
list2 = [10, 11]
listadd = list1 + list2
print(listadd)
listmulti = list2 * 3
print(listmulti)
