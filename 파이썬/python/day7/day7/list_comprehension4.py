list1 = [chr(d) for d in range(ord('A'), ord('Z') + 1)]    # ord()는 유니코드상 숫자를 리턴
list1_1 = [d for d in range(ord('A'), ord('Z') + 1)]    # ord()는 유니코드상 숫자를 리턴
print(list1)
print(list1_1)  # chr() 함수를 쓰지 않으면 숫자로 리스트 구성

list2 = [d for d in range(1, 16)]
print(list2)

list3 = [d for d in range(1, 16) if not d % 2]  # 짝수인 경우
print(list3)

list4 = [d for d in range(1, 16) if not d % 3]  # 3의 배수인 경우
print(list4)

list5 = [d if d % 2 else '짝수' for d in range(1, 16)]    # else문을 쓰기 위해서는 if문이 앞으로
print(list5)

list6 = ['홀수' if d % 2 else '짝수' for d in range(1, 16)]
print(list6)     # 홀수 출력, 짝수면 '짝수' 출력

list7 = ['pass_' + str(d) if d % 2 else 'fail_' + str(d) for d in range(1, 16)]
print(list7)

oldlist = [1, 2, 'A', False, 3]

newlist = [i * i for i in oldlist if type(i) == int]

print(newlist)
