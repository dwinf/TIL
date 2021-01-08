print("-- 중첩 리스트1 --")
lol = [ [1, 2, 3], [4, 5], [6, 7, 8, 9]]
print("이차원 리스트 인덱싱[행][열]")
print(lol[0])
print(lol[2][1])
print("이차원 리스트의 행 갯수와 각 행마다의 열 갯수")
print(len(lol))
print(len(lol[0]))
print(len(lol[1]))
print(len(lol[2]))
print("for문을 이용한 이차원 리스트 데이터 추출")
for sub in lol:
    for item in sub:
        print(item, end=' ')
    print()

print("-- 중첩 리스트2 --")
score = [
    [88, 76, 92, 98],
    [65, 70, 58, 82],
    [82, 80, 78, 88]
    ]

total = 0
totalsub = 0
for student in score:
    sum = 0
    for subject in student:
        sum += subject
    subjects = len(student)
    print("총점 :", sum, "평균 :", sum / subjects)
    total += sum
    totalsub += subjects
print("전체평균 :", total / totalsub)
