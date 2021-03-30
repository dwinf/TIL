print("-- 리스트에 데이터 추가 --")
nums = [1, 2, 3, 4]
print(nums)
nums.append(5)
print(nums)
nums.insert(2, 99)
print(nums)

print("-- 리스트에 범위를 지정하여 데이터 추가 --")
nums = [1, 2, 3, 4]
print(nums)
nums[2:2] = [90, 91, 92]
print(nums)

nums = [1, 2, 3, 4]
nums[2] = [90, 91, 92]
print(nums)

print("-- 리스트 뒤에 또 다른 리스트 데이터 확장 --")
list1 = [1, 2, 3, 4, 5]
list2 = [10, 11]
list1.extend(list2)
print(list1)

print("-- 리스트의 데이터를 삭제하는 다양한 방법 --")
score = [ 88, 95, 70, 100, 99, 80, 78, 50 ]
score.remove(100)
print(score)
del(score[2])
print(score)
score[1:4] = []
print(score)

print("-- pop() 메서드로 ㄹ스트 데이터 지우고 꺼내기 --")
score = [ 88, 95, 70, 100, 99 ]
print(score.pop())
print(score.pop())
print(score.pop(1))
print(score)

print("-- 리스트에서 데이터 위치(인덱스) 찾기와 갯수 카운팅 --")
score = [ 88, 95, 70, 100, 99, 80, 78, 50 ]
perfect = score.index(100)
print("만점 받은 학생은 " + str(perfect) + "번입니다.")
pernum = score.count(100)
print("만점자 수는 " + str(pernum) + "명입니다")

print("-- in 연산자를 사용하여 리스트에 데이터 존재여부 채크 --")
ans = input("결제 하시겠습니까? ")
if ans in ['yes', 'y', 'ok', '예', '당근']:
    print("구입해 주셔서 감사합니다.")
else:
    print("안녕히 가세요.")
