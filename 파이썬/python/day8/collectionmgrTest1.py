score = [88, 95, 70, 100, 99]
for no, s in enumerate(score, 1):
    print(str(no) + "번 학생의 성적 :", s)

names = "둘리,고길동,희동이,마이콜,또치,도우너"
namelist = names.split(",")
print(namelist)
namelist.sort()
print(namelist)
for num, name in enumerate(namelist):
    print(f"이름순으로 {name}는 {num + 1}번입니다.")
for data in enumerate(namelist):
    print(f"enumerate를 적용한 결과 : {data}")
for num, name in enumerate(namelist, 100):
    print(f"이름순으로 {name}는 {num}번입니다.")

for i, s in enumerate(score):
    print(f"{i}번 학생의 성적 : {s}")
